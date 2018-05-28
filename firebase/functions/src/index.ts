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