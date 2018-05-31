import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const userPath = "users";
const groupPath = "groups";
const betPath = "bets";
const transactionPath = "transactions";


function getUserList(bet) {
    return db.collection(groupPath).doc(bet.group).get().then((doc) => {
        const group = doc.data();
        const members = group.members;
        const membersList = Object.keys(members).filter(elem => {
            return elem !== bet.uid;
        });
        const userList = membersList.map(uid => {
            return db.collection(userPath).doc(uid).get().then(user => {
                const userMap = {
                    balance: user.data().balance,
                    atStake: user.data().atStake,
                    uid: uid,
                }; 
                return userMap;
            });
        });
        Promise.all(userList).then(results => {
            // calculate the amount to be split for each user
            betSplit(bet, results);
        });
    });
}

function betSplit(bet, userList) {
    const receiverCount = userList.length;
    const totalAtStakeProd = userList.reduce((prevVal, elem) => {
        return prevVal * elem.atStake;
    }, 1);
    const betSplitMap = {};
    const betBalMap = new Map;
    userList.forEach(user => {
        betSplitMap[user.uid] = receiveAmount(bet.amount, receiverCount, 
            user.atStake, totalAtStakeProd);
        betBalMap.set(user.uid, user.balance + betSplitMap[user.uid]);
    });
    // update all the balances
    betBalMap.forEach((amount, uid) => {
        return db.collection(userPath).doc(uid).update({
            balance: amount,
        }).catch(err => {
            console.log('Error updating document', err);
        });
    });
    // write the transaction document for everyone to see...
    return db.collection(transactionPath).add({
        "amount": bet.amount,
        "isWon": false,
        "date": Date.now(),
        "betType": bet.type,
        "user": bet.uid,
        "recipients": betSplitMap,
    }).catch(function(error) {
        console.error("Error adding document: ", error);
    });
}

function receiveAmount(
    betAmount: number,
    receiverCount: number,
    atStake: number,
    totalAtStakeProd: number,
) {
    const amount = (betAmount/receiverCount) + 
        ((Math.log(atStake/((totalAtStakeProd/atStake)^(1/(receiverCount-1))))*100)/receiverCount);
    // TODO store the remainder as profit
    return Math.floor(amount);
} 

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

export const onBetModified = functions.firestore
    .document('bets/{betID}')
    .onUpdate((snap, context) => {
        const prevBet = snap.before.data();
        const newBet = snap.after.data();
        if ((prevBet.winCond !== newBet.winCond) && (!prevBet.isExpired)) {
            const betRef = db.collection(betPath).doc(snap.after.id);
            return betRef.update({
                isExpired: true,
            })
            .catch(err => {
                console.log('Error getting document', err);
            });
        } else if (!prevBet.isExpired && newBet.isExpired) {
            if (newBet.winCond) {
                return db.collection(transactionPath).add({
                    "isWon": newBet.winCond,
                    "date": Date.now(),
                    "betType": newBet.type,
                    "user": newBet.uid,
                    "group": newBet.group,
                }); 
            } else {
                //reduce the user's balance by bet amount
                // TODO

                // get the list of users in the bet's group
                return getUserList(newBet)
                .catch(err => {
                    console.log('Error running getUserList', err);
                });
            }
        } else {
            return 'onBetModified: no change';
        }
});