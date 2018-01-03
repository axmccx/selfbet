'use strict';

var functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const express = require('express');
const app = express();
const createGroup = express();
const joinGroup = express();
const placeBet = express();
const triggerBet = express();

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


createGroup.use(validateFirebaseIdToken);
createGroup.get('/:groupName', (req, res) => {
	console.log('createGroup called');
	const uid = req.user.uid;
	const r = req.params;
	const userRef = db.collection('users').doc(uid);
	const groupRef = db.collection('groups').doc(r.groupName);

	// check whether the group already exists...
	groupRef.get().then((docSnapshot) => {
		if (docSnapshot.exists) {
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
			userRef.update({
				memberOfGroups: [r.groupName]
			}).catch(error => {
				console.log(error);
			});
			console.log(r.groupName + ' has been created!');
			res.send(r.groupName + ' has been created! :)');
		}
	});
});
exports.createGroup = functions.https.onRequest(createGroup);


joinGroup.use(validateFirebaseIdToken);
joinGroup.get('/:groupName', (req, res) => {
	console.log('joinGroup called');
	const uid = req.user.uid;
	const r = req.params;
	const userRef = db.collection('users').doc(uid);
	const groupRef = db.collection('groups').doc(r.groupName);
	groupRef.get().then((docSnapshot) => {
		if (docSnapshot.exists) {
			// get current members array of the specified group, and append the uid...
			var members_lst = docSnapshot.data()["members"];
			members_lst.push(uid);
			groupRef.update({
				members: members_lst
			}).catch(error => {
			 	console.log(error);
			});
			userRef.update({
				memberOfGroups: [r.groupName]
			}).catch(error => {
				console.log(error);
			});
			console.log('User ' + uid + ' joined group '+ r.groupName);
			res.send('You joined ' + r.groupName + '!');
		} else {
			res.send('ERROR: ' + r.groupName + ' doesn\'t exists');
			console.log('ERROR: Trying to join ' + r.groupName + ', but it doesn\'t already exists');
		}
	});
});
exports.joinGroup = functions.https.onRequest(joinGroup);


placeBet.use(validateFirebaseIdToken);
placeBet.get('/:groupName/:type/:amount', (req, res) => {
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
exports.placeBet = functions.https.onRequest(placeBet);


triggerBet.use(validateFirebaseIdToken);
triggerBet.get('/:betID', (req, res) => {
	console.log('triggerBet called');
	const uid = req.user.uid;
	const r = req.params;
	const betRef = db.collection('users').doc(uid).collection('bets').doc(r.betID);

	// determine the group of the bet
	// determine the amount of the bet
	// determine the list of users in the group
	// remove the current user from this list
	// count the number of users remaining
	// delete the amount by this number
	// reduce the balance of the current user by the original amount 
	// increase the balance of all other users by the divide amount

	console.log('Bet was triggered');
	res.send('Bet was triggered');
});
exports.triggerBet = functions.https.onRequest(triggerBet);