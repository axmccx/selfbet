'use strict';

var functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.createGroup = functions.https.onRequest((request, response) => {
	console.log('createGroup called');
	if (!request.headers.authorization) {
		console.error('No Firebase ID token was passed');
		response.status(403).send('Unauthorized');
		return;
	}
	admin.auth().verifyIdToken(request.headers.authorization).then(decodedIdToken => {
		console.log('ID Token correctly decoded', decodedIdToken);
		createGroupInDB(decodedIdToken.uid, request.query.groupName, response)
	}).catch(error => {
		console.error('Error while verifying Firebase ID token:', error);
		response.status(403).send('Unauthorized');
	});
});

function createGroupInDB(uid, groupName, response) {
	const db = admin.firestore();
	const userRef = db.collection('users').doc(uid);
	const groupRef = db.collection('groups').doc(groupName);

	// check whether the group already exists...
	groupRef.get().then((docSnapshot) => {
		if (docSnapshot.exists) {
			response.send('ERROR: ' + groupName + ' already exists');
			console.log('ERROR: ' + groupName + ' already exists');
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
				memberOfGroups: [groupName]
			}).catch(error => {
				console.log(error);
			});
			console.log(groupName + ' has been created!');
			response.send(groupName + ' has been created! :)');
		}
	});
}

exports.joinGroup = functions.https.onRequest((request, response) => {
	console.log('joinGroup called');
	if (!request.headers.authorization) {
		console.error('No Firebase ID token was passed');
		response.status(403).send('Unauthorized');
		return;
	}
	admin.auth().verifyIdToken(request.headers.authorization).then(decodedIdToken => {
		console.log('ID Token correctly decoded', decodedIdToken);
		joinGroupInDB(decodedIdToken.uid, request.query.groupName, response)
	}).catch(error => {
		console.error('Error while verifying Firebase ID token:', error);
		response.status(403).send('Unauthorized');
	});
});

function joinGroupInDB(uid, groupName, response) {
	const db = admin.firestore();
	const userRef = db.collection('users').doc(uid);
	const groupRef = db.collection('groups').doc(groupName);
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
				memberOfGroups: [groupName]
			}).catch(error => {
				console.log(error);
			});
			console.log('User ' + uid + ' joined group '+ groupName);
			response.send('You joined ' + groupName + '!');
		} else {
			response.send('ERROR: ' + groupName + ' doesn\'t exists');
			console.log('ERROR: Trying to join ' + groupName + ', but it doesn\'t already exists');
		}
	});
}

exports.placeBet = functions.https.onRequest((request, response) => {
	console.log('placeBet called');
	if (!request.headers.authorization) {
		console.error('No Firebase ID token was passed');
		response.status(403).send('Unauthorized');
		return;
	}
	admin.auth().verifyIdToken(request.headers.authorization).then(decodedIdToken => {
		console.log('ID Token correctly decoded', decodedIdToken);
		placeBetInDB(decodedIdToken.uid, request.query.groupName, request.query.type, request.query.amount, response)
	}).catch(error => {
		console.error('Error while verifying Firebase ID token:', error);
		response.status(403).send('Unauthorized');
	});
});

function placeBetInDB(uid, nGroupName, nType, nAmount, response) {
	const db = admin.firestore();
	const betsRef = db.collection('users').doc(uid).collection('bets');

	betsRef.add({
	    amount: nAmount,
	    group: nGroupName,
	    type: nType
	}).catch(error => {
		console.log(error);
		response.send('An error occured');
	});
	console.log('Bet has been placed');
	response.send('Bet has been placed');
}