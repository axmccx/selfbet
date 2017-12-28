package com.example.alexm.selfbet.fragments;

import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.alexm.selfbet.MainActivity;
import com.example.alexm.selfbet.R;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.EventListener;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreException;

import butterknife.BindView;
import butterknife.ButterKnife;

public class HomeFragment extends Fragment {

    @BindView(R.id.tv_balance) TextView balanceText;

    public static final String BALANCE_KEY = "balance";
    private MainActivity activity;
    private FirebaseAuth mAuth;
    private FirebaseFirestore mFirestore;
    private DocumentReference mDocRef;

    public static HomeFragment newInstance() {
        HomeFragment fragment = new HomeFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_home);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_home, container, false);
        ButterKnife.bind(this, view);

        activity = (MainActivity) getActivity();
        mAuth = activity.getmAuth();

        if (mAuth.getCurrentUser() != null) {
            mFirestore = FirebaseFirestore.getInstance();
            mDocRef = mFirestore.document("users/" + mAuth.getUid());

            mDocRef.addSnapshotListener(activity, new EventListener<DocumentSnapshot>() {
                @Override
                public void onEvent(DocumentSnapshot documentSnapshot, FirebaseFirestoreException e) {
                    // had to put a null guard here, I have no idea why this method runs on logout,
                    // considering there is no instance of HomeFragment.
                    if (documentSnapshot != null && documentSnapshot.exists()) {
                        String userBalance = documentSnapshot.get(BALANCE_KEY).toString();
                        balanceText.setText("Balance: $" + userBalance + ".00");
                    }
                }
            });
        }
        return view;
    }
}