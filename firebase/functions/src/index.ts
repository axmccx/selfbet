import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const userPath = "users";

export const onBetPlaced = functions.firestore
    .document('bets/{betID}')
    .onCreate((snap, context) => {
        const newBet = snap.data();
        const userRef = db.collection(userPath).doc(newBet.uid);
        return userRef.get().then(doc => {
            if (!doc.exists) {
                console.log(`No such user:${newBet.uid}`);
            } else {
                const newAtStake = doc.data().atStake + newBet.amount;
                userRef.update({
                    atStake: newAtStake
                }).catch(err => {
                    console.log('Error updating document', err);
                });
            }
        })
        .catch(err => {
            console.log('Error getting document', err);
        });
});

export const onBetDeleted = functions.firestore
    .document('bets/{betID}')
    .onDelete((snap, context) => {
        const delBet = snap.data();
        const userRef = db.collection(userPath).doc(delBet.uid);
        return userRef.get().then(doc => {
            if (!doc.exists) {
                console.log(`No such user:${delBet.uid}`);
            } else {
                const newBalance = doc.data().balance + delBet.amount;
                const newAtStake = doc.data().atStake - delBet.amount;
                userRef.update({
                    balance: newBalance,
                    atStake: newAtStake,
                }).catch(err => {
                    console.log('Error updating document', err);
                });
            }
        })
        .catch(err => {
            console.log('Error getting document', err);
        });
});