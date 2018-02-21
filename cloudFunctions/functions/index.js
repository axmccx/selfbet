'use strict';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const express = require('express');
const app = express();

const validateFirebaseIdToken = (req, res, next) => {
	console.log('Check if request is authorized with Firebase ID token');
	if (!req.headers.authorization) {
		console.error('No Firebase ID token was passed.');
		res.status(403).send('Unauthorized');
		return;
	}
	admin.auth().verifyIdToken(req.headers.authorization).then(decodedIdToken => {
		console.log('ID Token correctly decoded', decodedIdToken);
		req.user = decodedIdToken;
		next();
	}).catch(error => {
		console.error('Error while verifying Firebase ID token:', error);
		res.status(403).send('Unauthorized');
	});
};

function changeBalance(balance, amount, increase) {
	var balance_int = parseInt(balance);
	var amount_int = parseInt(amount);
	var new_balance;
	if (increase) {
		new_balance = balance_int + amount_int;
	} else {
		if (amount_int > balance_int) {	//this shouldn't be needed after I add the amount guards
			new_balance = 0;
		} else {
			new_balance = balance_int - amount_int;
		}
	}
	return new_balance.toString();
}

function transferToMember(memberRef, transfer_amount) {
	db.runTransaction(t => {
		return t.get(memberRef).then(mDoc => {
		 	if (mDoc.exists) {
				var member_balance = mDoc.data()["balance"];
				var new_mem_balance = changeBalance(member_balance, transfer_amount, true);
				//console.log('(loop) memberRed =  ' + memberRef.id);
				t.update(memberRef, {balance: new_mem_balance});
			}
		});
	}).then(result => {
		console.log('transfered ' + transfer_amount + ' to ' + memberRef.id);
	}).catch(err => {
        console.log('transferToMember failure:', err);
	});
}

app.use(validateFirebaseIdToken);

app.get('/createGroup/:groupName', (req, res) => {
	console.log('createGroup called');
	const uid = req.user.uid;
	const r = req.params;
	const userRef = db.collection('users').doc(uid);
	const groupRef = db.collection('groups').doc(r.groupName);

	// check whether the group already exists...
	groupRef.get().then((doc) => {
		if (doc.exists) {
			res.send('ERROR: ' + r.groupName + ' already exists');
			console.log('ERROR: ' + r.groupName + ' already exists');
		} else {
			// create group document in the groups collection, call it the group name
			// add the users uid in the member's array
			groupRef.set({
				members: [uid]
			}).catch(error => {
				console.log(error);
			});
			// Update the user's memberOfGroups array with the new group name
			userRef.get().then((userDoc) => {
				var group_lst = userDoc.data()["memberOfGroups"];
				group_lst.push(r.groupName);
				userRef.update({
					memberOfGroups: group_lst
				}).catch(error => {
					console.log(error);
				});
			});
			console.log(r.groupName + ' has been created!');
			res.send(r.groupName + ' has been created! :)');
		}
	});
});

app.get('/joinGroup/:groupName', (req, res) => {
	console.log('joinGroup called');
	const uid = req.user.uid;
	const r = req.params;
	const userRef = db.collection('users').doc(uid);
	const groupRef = db.collection('groups').doc(r.groupName);
	groupRef.get().then((doc) => {
		if (doc.exists) {
			// get current members array of the specified group, and append the uid...
			var members_lst = doc.data()["members"];
			members_lst.push(uid);
			groupRef.update({
				members: members_lst
			}).catch(error => {
			 	console.log(error);
			});
			// get current group array from user, and append the group name...
			userRef.get().then((userDoc) => {
				var group_lst = userDoc.data()["memberOfGroups"];
				group_lst.push(r.groupName);
				userRef.update({
					memberOfGroups: group_lst
				}).catch(error => {
					console.log(error);
				});
			});
			console.log('User ' + uid + ' joined group '+ r.groupName);
			res.send('You joined ' + r.groupName + '!');
		} else {
			res.send('ERROR: ' + r.groupName + ' doesn\'t exists');
			console.log('ERROR: Trying to join ' + r.groupName + ', but it doesn\'t already exists');
		}
	});
});

app.get('/placeBet/:groupName/:type/:amount', (req, res) => {
	console.log('placeBet called');
	const uid = req.user.uid;
	const r = req.params;
	const betsRef = db.collection('users').doc(uid).collection('bets');
	betsRef.add({
	    amount: r.amount,
	    group: r.groupName,
	    type: r.type
	}).catch(error => {
		console.log(error);
		res.send('An error occured');
	});
	console.log('Bet has been placed');
	res.send('Bet has been placed');
});

app.get('/triggerBet/:betID', (req, res) => {
	console.log('triggerBet called');
	const uid = req.user.uid;
	const r = req.params;
	const userRef = db.collection('users').doc(uid);
	const betRef = db.collection('users').doc(uid).collection('bets').doc(r.betID);
	var batch = db.batch();

	betRef.get().then((doc) => {
		if (doc.exists) {
			// determine the amount of the bet
			var amount = doc.data()["amount"];

			// reduce the balance of the current user by the amount 
			userRef.get().then((uDoc) => {
				if (uDoc.exists) {
					var current_balance = uDoc.data()["balance"];
					var new_balance = changeBalance(current_balance, amount, false);
					userRef.update({
						balance: new_balance
					}).catch(error => {
					 	console.log(error);
					})
				}
			});

			// determine the group of the bet
			var groupName = doc.data()["group"];
			const groupRef = db.collection('groups').doc(groupName);

			// determine the list of users in the group
			groupRef.get().then((gDoc) => {
				if (gDoc.exists) {
					var members_lst = gDoc.data()["members"];

					// remove the current user from this list
					const index = members_lst.indexOf(uid);
					members_lst.splice(index, 1);

					// count the number of users remaining
					var user_count = members_lst.length

					// divide the amount by this number
					var transfer_amount = parseInt(amount) / user_count;

					// increase the balance of all other users by the divide amount
					// ## for each user id in the list, 
					// 		obtain their current balance
					//		increase it by the amount, and set the new value
					for (var i = 0; i < user_count; i++) {
						var memberRef = db.collection('users').doc(members_lst[i]);
						transferToMember(memberRef, transfer_amount);
					}
				}
			});	
		}
	});
	res.send('Bet was triggered');
});

exports.api = functions.https.onRequest(app);