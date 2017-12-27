package com.example.alexm.selfbet.fragments;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Toast;

import com.example.alexm.selfbet.MainActivity;
import com.example.alexm.selfbet.R;
import com.google.android.gms.tasks.OnCompleteListener;

import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MoneyFragment extends Fragment {
    @BindView(R.id.btn_faucet) Button faucetButton;
    private View view;
    public static final String BALANCE_KEY = "balance";
    private static final String TAG = "SaveToFirestore";

    private MainActivity activity;
    private FirebaseAuth mAuth;
    private FirebaseFirestore mFirestore;
    private DocumentReference mDocRef;

    public static MoneyFragment newInstance() {
        MoneyFragment fragment = new MoneyFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_money);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_money, container, false);
        ButterKnife.bind(this, view);

        faucetButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                openFaucet();
            }
        });

        activity = (MainActivity) getActivity();
        mAuth = activity.getmAuth();
        mFirestore = FirebaseFirestore.getInstance();
        mDocRef = mFirestore.document("users/" + mAuth.getUid());

        return view;
    }

    private void openFaucet() {
        mDocRef.get().addOnSuccessListener(new OnSuccessListener<DocumentSnapshot>() {
            @Override
            public void onSuccess(DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists()) {
                    String balance = documentSnapshot.getData().get(BALANCE_KEY).toString();
                    if (balance.equals("0")) {
                        addFunds();
                    } else {
                        Toast.makeText(activity.getApplicationContext(), "Balance needs to be zero!", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });
    }

    public void addFunds() {
        Map<String, Object> dataToSave = new HashMap<String, Object>();
        dataToSave.put(BALANCE_KEY, 20);

        mDocRef.update(dataToSave).addOnCompleteListener(new OnCompleteListener<Void>() {
            @Override
            public void onComplete(@NonNull Task<Void> task) {
                if (task.isSuccessful()) {
                    Log.d(TAG, "It worked!");
                    Toast.makeText(getActivity().getApplicationContext(), "Adding $20 to account...", Toast.LENGTH_SHORT).show();
                } else {
                    Log.w(TAG, "I messed up...", task.getException());
                    Toast.makeText(getActivity().getApplicationContext(), "Oops, something went wrong", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}

