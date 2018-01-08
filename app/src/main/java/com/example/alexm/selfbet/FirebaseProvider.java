package com.example.alexm.selfbet;


// This class provides anything related to firebase,
// including authorization and database data.

import android.support.annotation.NonNull;
import android.util.Log;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GetTokenResult;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.EventListener;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Observable;

public class FirebaseProvider extends Observable {
    private static FirebaseAuth mAuth;
    private static DocumentReference userRef;
    private static ArrayList<String> groupList;
    private static String userBalance;
    private static MainActivity context;
    private static FirebaseUser mUser;

    FirebaseProvider(MainActivity context) {
        FirebaseProvider.context = context;
        FirebaseApp.initializeApp(context);
        mAuth = FirebaseAuth.getInstance();
        mUser = mAuth.getCurrentUser();
        FirebaseFirestore mFirestore = FirebaseFirestore.getInstance();
        userRef = mFirestore.document("users/" + mAuth.getUid());

        userRef.addSnapshotListener(new EventListener<DocumentSnapshot>() {
            @Override
            public void onEvent(DocumentSnapshot documentSnapshot, FirebaseFirestoreException e) {
                if (documentSnapshot != null) {
                    userBalance = documentSnapshot.get("balance").toString();
                    groupList = (ArrayList<String>) documentSnapshot.get("memberOfGroups");
                    notifyObservers();
                }
            }
        });
    }

    public static FirebaseAuth getAuth() {
        return mAuth;
    }

    static boolean userIsNull() {
        return (mUser == null);
    }

    public static String getUID() {
        return mAuth.getUid();
    }

    public static String getUserBalance() {
        return userBalance;
    }

    public static ArrayList<String> getGroupList() {
        return groupList;
    }

    @Override
    public void notifyObservers(){
        setChanged();
        super.notifyObservers();
    }

    public static void openFaucet() {
        if (FirebaseProvider.getUserBalance().equals("0")) {
            addFunds();
        } else {
            Toast.makeText(context, "Balance needs to be zero!", Toast.LENGTH_SHORT).show();
        }
    }

    private static void addFunds() {
        Map<String, Object> dataToSave = new HashMap<String, Object>();
        dataToSave.put("balance", 20);

        userRef.update(dataToSave).addOnCompleteListener(new OnCompleteListener<Void>() {
            @Override
            public void onComplete(@NonNull Task<Void> task) {
                if (task.isSuccessful()) {
                    Log.d("Selfbet_Log: ", "It worked!");
                    Toast.makeText(context, "Adding $20 to account...", Toast.LENGTH_SHORT).show();
                } else {
                    Log.w("Selfbet_Log: ", "I messed up...", task.getException());
                    Toast.makeText(context, "Oops, something went wrong", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
