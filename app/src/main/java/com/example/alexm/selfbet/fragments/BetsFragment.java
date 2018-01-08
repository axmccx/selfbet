package com.example.alexm.selfbet.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.app.Fragment;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.alexm.selfbet.FSRecyclerAdapter;
import com.example.alexm.selfbet.FirebaseProvider;
import com.example.alexm.selfbet.MainActivity;
import com.example.alexm.selfbet.PlaceBetActivity;
import com.example.alexm.selfbet.R;
import com.example.alexm.selfbet.SingleBet;
import com.firebase.ui.firestore.FirestoreRecyclerAdapter;
import com.firebase.ui.firestore.FirestoreRecyclerOptions;
import com.getbase.floatingactionbutton.FloatingActionButton;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.Query;

import butterknife.BindView;
import butterknife.ButterKnife;

public class BetsFragment extends Fragment {

    @BindView(R.id.btn_place_bet) FloatingActionButton placeBet;
    @BindView(R.id.rv_bets) RecyclerView betsList;

    protected View view;
    private FirebaseFirestore db;
    private FirestoreRecyclerAdapter adapter;

    public static BetsFragment newInstance() {
        return new BetsFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_bets);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_bets, container, false);
        ButterKnife.bind(this, view);

        init();
        getBetsList();

        placeBet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //check if part of a group first...
                Intent intent = new Intent(getActivity(), PlaceBetActivity.class);
                startActivity(intent);
            }
        });

        return view;
    }

    private void init(){
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity().getApplicationContext());
        betsList.setLayoutManager(layoutManager);

        DividerItemDecoration dividerItemDecoration = new DividerItemDecoration(betsList.getContext(),
                layoutManager.getOrientation());
        betsList.addItemDecoration(dividerItemDecoration);

        db = FirebaseFirestore.getInstance();
    }

    private void getBetsList() {
        Query query = db.collection("users/" + FirebaseProvider.getUID() + "/bets");

        FirestoreRecyclerOptions<SingleBet> bet = new FirestoreRecyclerOptions.Builder<SingleBet>()
                .setQuery(query, SingleBet.class)
                .build();

        adapter = new FSRecyclerAdapter(bet);
        adapter.notifyDataSetChanged();
        betsList.setAdapter(adapter);
    }

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        @Override
    public void onStart() {
        super.onStart();
        adapter.startListening();
    }

    @Override
    public void onStop() {
        super.onStop();
        adapter.stopListening();
    }
}
