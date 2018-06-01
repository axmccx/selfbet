"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const userPath = "users";
const groupPath = "groups";
const betPath = "bets";
const transactionPath = "transactions";
function generateLostBet(bet) {
    return db.collection(groupPath).doc(bet.group).get().then((doc) => {
        const group = doc.data();
        const members = group.members;
        const membersList = {};
        Object.keys(members).map(uid => {
            membersList[uid] = true;
        });
        const recipientsList = Object.keys(members).filter(elem => {
            return elem !== bet.uid;
        });
        let errorCheck = false;
        const userList = recipientsList.map(uid => {
            const userMap = db.collection(userPath).doc(uid).get().then(user => {
                return {
                    balance: user.data().balance,
                    atStake: user.data().atStake,
                    uid: uid,
                };
            }).catch(err => {
                console.log('Error getting user\'s doc for userMap', err);
                errorCheck = true;
                return {
                    balance: 0,
                    atStake: 0,
                    uid: uid,
                };
            });
            return userMap;
        });
        // poor error checking...
        if (errorCheck) {
            return;
        }
        Promise.all(userList).then(readyUserList => {
            // calculate the amount to be split for each user
            const receiverCount = readyUserList.length;
            const totalAtStakeProd = readyUserList
                .reduce((prevVal, userMap) => {
                return prevVal * userMap.atStake;
            }, 1);
            const betSplitMap = {};
            const betBalMap = new Map;
            readyUserList.forEach(userMap => {
                betSplitMap[userMap.uid] = calcWinnings(bet.amount, receiverCount, userMap.atStake, totalAtStakeProd);
                betBalMap.set(userMap.uid, userMap.balance
                    + betSplitMap[userMap.uid]);
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
                "uid": bet.uid,
                "amount": bet.amount,
                "group": bet.group,
                "betType": bet.type,
                "date": Date.now(),
                "isWon": false,
                "members": membersList,
                "recipients": betSplitMap,
            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });
        }).catch(err => {
            console.log('Error waiting for userList', err);
        });
    });
}
function calcWinnings(betAmount, receiverCount, atStake, totalAtStakeProd) {
    if (receiverCount === 1) {
        return betAmount;
    }
    else if (receiverCount > 1) {
        const amount = (betAmount + ((Math.log(atStake /
            (Math.pow((totalAtStakeProd / atStake), (1 / (receiverCount - 1)))))) * 100))
            / receiverCount;
        return Math.floor(amount);
    }
    else {
        return 0;
    }
}
exports.onBetPlaced = functions.firestore
    .document('bets/{betID}')
    .onCreate((snap, context) => {
    const newBet = snap.data();
    const userRef = db.collection(userPath).doc(newBet.uid);
    return userRef.get().then(doc => {
        if (!doc.exists) {
            console.log(`No such user:${newBet.uid}`);
        }
        else {
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
exports.onBetDeleted = functions.firestore
    .document('bets/{betID}')
    .onDelete((snap, context) => {
    const delBet = snap.data();
    if (delBet.winCond) {
        const userRef = db.collection(userPath).doc(delBet.uid);
        return userRef.get().then(doc => {
            if (!doc.exists) {
                console.log(`No such user:${delBet.uid}`);
            }
            else {
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
    }
    else {
        return "no money change";
    }
});
exports.onBetModified = functions.firestore
    .document('bets/{betID}')
    .onUpdate((snap, context) => {
    const prevBet = snap.before.data();
    const newBet = snap.after.data();
    // if bet's win condition changes and not expired, set isExpited
    // else if lost bet was renewed, update balance and atStake
    // else if bet was just set isExpire, deal with outcome. 
    if ((prevBet.winCond !== newBet.winCond) && (!prevBet.isExpired)) {
        const betRef = db.collection(betPath).doc(snap.after.id);
        return betRef.update({
            isExpired: true,
        })
            .catch(err => {
            console.log('Error getting document', err);
        });
    }
    else if ((prevBet.isExpired && !newBet.isExpired) &&
        (!prevBet.winCond)) {
        const userRef = db.collection(userPath).doc(newBet.uid);
        return userRef.get().then(doc => {
            const newBalance = doc.data().balance - newBet.amount;
            const newAtStake = doc.data().atStake + newBet.amount;
            userRef.update({
                balance: newBalance,
                atStake: newAtStake,
            }).catch(err => {
                console.log('Error updating document', err);
            });
        });
    }
    else if (!prevBet.isExpired && newBet.isExpired) {
        if (newBet.winCond) {
            return db.collection(transactionPath).add({
                "uid": newBet.uid,
                "amount": newBet.amount,
                "group": newBet.group,
                "betType": newBet.type,
                "date": Date.now(),
                "isWon": newBet.winCond,
                "members": { [newBet.uid]: true, },
                "recipients": {},
            });
        }
        else {
            //reduce the user's atStake by bet amount
            db.collection(userPath).doc(newBet.uid).get().then(user => {
                const newAtStake = user.data().atStake - newBet.amount;
                db.collection(userPath).doc(newBet.uid).update({
                    atStake: newAtStake,
                }).catch(err => {
                    console.log('Error updating user\'s atStake', err);
                });
            }).catch(err => {
                console.log('Error getting userDoc', err);
            });
            ;
            // get the list of users in the bet's group
            return generateLostBet(newBet)
                .catch(err => {
                console.log('Error running getUserList', err);
            });
        }
    }
    else {
        return 'onBetModified: no change';
    }
});
//# sourceMappingURL=index.js.map