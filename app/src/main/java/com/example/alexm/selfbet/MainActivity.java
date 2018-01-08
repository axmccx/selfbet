package com.example.alexm.selfbet;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;

import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.app.Fragment;
import android.app.FragmentTransaction;

import com.example.alexm.selfbet.fragments.BetsFragment;
import com.example.alexm.selfbet.fragments.GroupFragment;
import com.example.alexm.selfbet.fragments.HomeFragment;
import com.example.alexm.selfbet.fragments.MoneyFragment;
import com.example.alexm.selfbet.fragments.SettingsFragment;
import com.ittianyu.bottomnavigationviewex.BottomNavigationViewEx;

public class MainActivity extends AppCompatActivity {
    private FirebaseProvider firebaseProvider;

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            Fragment selectedFragment = null;
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    selectedFragment = HomeFragment.newInstance();
                    firebaseProvider.addObserver((HomeFragment) selectedFragment);
                    break;
                case R.id.navigation_group:
                    selectedFragment = GroupFragment.newInstance();
                    firebaseProvider.addObserver((GroupFragment) selectedFragment);
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

        firebaseProvider = new FirebaseProvider(this);

        BottomNavigationViewEx navigation = findViewById(R.id.navigation);
        navigation.enableShiftingMode(false);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);

        FragmentTransaction transaction = getFragmentManager().beginTransaction();
        HomeFragment homeFragment = HomeFragment.newInstance();
        firebaseProvider.addObserver(homeFragment);
        transaction.replace(R.id.container, homeFragment);
        transaction.commit();
    }

    @Override
    public void onStart() {
        super.onStart();
        if (FirebaseProvider.userIsNull()) {
            Intent intent = new Intent(this, LoginActivity.class);
            startActivity(intent);
            finish();
        }
    }
}
