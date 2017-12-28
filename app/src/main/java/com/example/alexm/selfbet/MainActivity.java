package com.example.alexm.selfbet;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;

import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.MenuItem;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.widget.TextView;
import android.widget.Toast;

import com.example.alexm.selfbet.fragments.BetsFragment;
import com.example.alexm.selfbet.fragments.GroupFragment;
import com.example.alexm.selfbet.fragments.HomeFragment;
import com.example.alexm.selfbet.fragments.MoneyFragment;
import com.example.alexm.selfbet.fragments.SettingsFragment;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;
import com.ittianyu.bottomnavigationviewex.BottomNavigationViewEx;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    public static final String TAG = "Selfbet_Log: ";
    public static final String BALANCE_KEY = "balance";

    private FirebaseAuth mAuth;
    private FirebaseFirestore mFirestore;
    private DocumentReference mDocRef;

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            Fragment selectedFragment = null;
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    selectedFragment = HomeFragment.newInstance();
                    break;
                case R.id.navigation_group:
                    selectedFragment = GroupFragment.newInstance();
                    break;
                case R.id.navigation_bets:
                    selectedFragment = BetsFragment.newInstance();
                    break;
                case R.id.navigation_money:
                    selectedFragment = MoneyFragment.newInstance();
                    break;
                case R.id.navigation_settings:
                    selectedFragment = SettingsFragment.newInstance();
                    break;
            }
            FragmentTransaction transaction = getFragmentManager().beginTransaction();
            transaction.replace(R.id.container, selectedFragment);
            transaction.commit();
            return true;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        FirebaseApp.initializeApp(this);
        mAuth = FirebaseAuth.getInstance();
        mFirestore = FirebaseFirestore.getInstance();
        mDocRef = mFirestore.document("users/" + mAuth.getUid());

        BottomNavigationViewEx navigation = findViewById(R.id.navigation);
        navigation.enableShiftingMode(false);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);

        FragmentTransaction transaction = getFragmentManager().beginTransaction();
        transaction.replace(R.id.container, HomeFragment.newInstance());
        transaction.commit();
    }

    @Override
    public void onStart() {
        super.onStart();
        FirebaseUser currentUser = mAuth.getCurrentUser();
        updateUI(currentUser);
    }

    private void updateUI(FirebaseUser user) {
        if (user != null) {

        } else {
            Intent intent = new Intent(this, LoginActivity.class);
            startActivity(intent);
            finish();
        }
    }

    public FirebaseAuth getmAuth() {
        return mAuth;
    }

    public void openFaucet() {
        mDocRef.get().addOnSuccessListener(new OnSuccessListener<DocumentSnapshot>() {
            @Override
            public void onSuccess(DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists()) {
                    String balance = documentSnapshot.getData().get(BALANCE_KEY).toString();
                    if (balance.equals("0")) {
                        addFunds();
                    } else {
                        Toast.makeText(getApplicationContext(), "Balance needs to be zero!", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });
    }

    private void addFunds() {
        Map<String, Object> dataToSave = new HashMap<String, Object>();
        dataToSave.put(BALANCE_KEY, 20);

        mDocRef.update(dataToSave).addOnCompleteListener(new OnCompleteListener<Void>() {
            @Override
            public void onComplete(@NonNull Task<Void> task) {
                if (task.isSuccessful()) {
                    Log.d(TAG, "It worked!");
                    Toast.makeText(getApplicationContext(), "Adding $20 to account...", Toast.LENGTH_SHORT).show();
                } else {
                    Log.w(TAG, "I messed up...", task.getException());
                    Toast.makeText(getApplicationContext(), "Oops, something went wrong", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    public void signOut() {
        mAuth.signOut();
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
    }
}
