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

import com.example.alexm.selfbet.R;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.firestore.DocumentReference;
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

    private DocumentReference mDocref = FirebaseFirestore.getInstance()
            .document("sampleData/userTest");

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

        return view;
    }

    private void openFaucet() {
        Map<String, Object> dataToSave = new HashMap<String, Object>();
        dataToSave.put(BALANCE_KEY, 20);

        mDocref.set(dataToSave).addOnCompleteListener(new OnCompleteListener<Void>() {
            @Override
            public void onComplete(@NonNull Task<Void> task) {
                if (task.isSuccessful()) {
                    Log.d(TAG, "It worked!");
                    Toast.makeText(getActivity().getApplicationContext(), "Adding credits...", Toast.LENGTH_SHORT).show();
                } else {
                    Log.w(TAG, "I messed up...", task.getException());
                    Toast.makeText(getActivity().getApplicationContext(), "Something went wrong", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}

