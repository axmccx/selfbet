import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const userPath = "users";
const groupPath = "groups";
const betPath = "bets";
const transactionPath = "transactions";

function generateLostBet(bet) {
    return db.collection(groupPath).doc(bet.group).get().then((doc) => {
        const group = doc.data();
        const membersList = {}; 
        Object.keys(group.members).map(uid => {
            membersList[uid] = Date.now();
        });
        const recipientsList = Object.keys(group.members).filter(elem => {
            return elem !== bet.uid;
        });
        let errorCheck = false;
        const userList = recipientsList.map(uid => {
            const userMap = db.collection(userPath).doc(uid).get().then(user => {
                return {
                    balance: user.data().balance,
                    atStake: group.membersAtStake[uid],
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
            const calcedAtStakeMap = {};
            readyUserList.forEach(userMap => {
                calcedAtStakeMap[userMap.uid] = userMap.atStake; 
                if(userMap.atStake < 100) {
                    userMap.atStake = 100;
                }
            });
            const totalAtStakeProd = readyUserList.reduce((prevVal, userMap) => {
                return prevVal * userMap.atStake;
            }, 1);
            const betSplitMap = {};
            const betBalMap = new Map;
            readyUserList.forEach(userMap => {
                betSplitMap[userMap.uid] = calcWinnings(bet.amount, 
                    receiverCount, userMap.atStake, totalAtStakeProd);  
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
                "calcedAtStake": calcedAtStakeMap,
                "recipients": betSplitMap,
            }).catch(function(error) {
                console.error("Error adding document: ", error);
            });
        }).catch(err => {
            console.log('Error waiting for userList', err);
        });
    });
}

function calcWinnings(
    betAmount: number,
    receiverCount: number,
    atStake: number,
    totalAtStakeProd: number,
) {
    if (receiverCount === 1) {
        return betAmount;
    } else if (receiverCount > 1) {
        const amount = (betAmount+((Math.log(atStake/
            (Math.pow((totalAtStakeProd/atStake),(1/(receiverCount-1))))))*100))
            /receiverCount;
        return Math.floor(amount);
    } else {
        return 0;
    }
} 

export const onBetModified = functions.firestore
    .document('bets/{betID}')
    .onUpdate((snap, context) => {
        const prevBet = snap.before.data();
        const newBet = snap.after.data();
        // bet's win condition changes and not expired => set isExpited
        if ((prevBet.winCond !== newBet.winCond) && (!prevBet.isExpired)) {
            const betRef = db.collection(betPath).doc(snap.after.id);
            return betRef.update({
                isExpired: true,
            })
            .catch(err => {
                console.log('Error getting document', err);
            });
        // bet expired => deal with outcome.     
        } else if (!prevBet.isExpired && newBet.isExpired) {
            // reduce AtStake in the bet's group
            db.collection(groupPath).doc(newBet.group).get().then(
                group => {
                const newAtStake = group.data().membersAtStake[newBet.uid] 
                    - newBet.amount;   
                const groupUpdate = {};
                groupUpdate[`membersAtStake.${newBet.uid}`] = newAtStake;
                db.collection(groupPath).doc(newBet.group).update(groupUpdate)
                .catch(err => {
                    console.log('Error updating user\'s atStake', err);
                });
            }).catch(err => {
                console.log('Error getting group from bet', err);
            });
            // bet won => update balance and create new won transaction entry
            if (newBet.winCond) {
                const userRef = db.collection(userPath).doc(newBet.uid);
                userRef.get().then(doc => {
                        if (!doc.exists) {
                        console.log(`No such user:${newBet.uid}`);
                    } else {
                        const newBalance = doc.data().balance + newBet.amount;
                        const newAtStake = doc.data().atStake - newBet.amount;
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
                return db.collection(transactionPath).add({
                    "uid": newBet.uid,
                    "amount": newBet.amount,
                    "group": newBet.group,
                    "betType": newBet.type,
                    "date": Date.now(),
                    "isWon": newBet.winCond,
                    "members": { [newBet.uid]: Date.now(), },
                    "calcedAtStake": {},
                    "recipients": {},
                });
            // bet lost => run process...     
            } else {
                //reduce the user's atStake by bet amount
                db.collection(userPath).doc(newBet.uid).get().then(
                    user => {
                    const newAtStake = user.data().atStake - newBet.amount;
                    db.collection(userPath).doc(newBet.uid).update({
                        atStake: newAtStake,
                    }).catch(err => {
                        console.log('Error updating user\'s atStake', err);
                    });
                }).catch(err => {
                    console.log('Error getting userDoc', err);
                });
                return generateLostBet(newBet)
                .catch(err => {
                    console.log('Error running getUserList', err);
                });
            }
        } else {
            return 'onBetModified: no change';
        }
});