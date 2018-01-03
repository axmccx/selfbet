package com.example.alexm.selfbet.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.app.Fragment;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.example.alexm.selfbet.MainActivity;
import com.example.alexm.selfbet.PlaceBetActivity;
import com.example.alexm.selfbet.R;
import com.example.alexm.selfbet.SingleBet;
import com.firebase.ui.firestore.FirestoreRecyclerAdapter;
import com.firebase.ui.firestore.FirestoreRecyclerOptions;
import com.getbase.floatingactionbutton.FloatingActionButton;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreException;
import com.google.firebase.firestore.Query;

import butterknife.BindView;
import butterknife.ButterKnife;

public class BetsFragment extends Fragment {

    @BindView(R.id.btn_place_bet) FloatingActionButton placeBet;
    @BindView(R.id.rv_bets) RecyclerView betsList;

    protected View view;
    private LinearLayoutManager layoutManager;

    private MainActivity activity;
    private FirebaseAuth mAuth;
    private FirebaseFirestore db;
    private FirestoreRecyclerAdapter adapter;

    public static BetsFragment newInstance() {
        BetsFragment fragment = new BetsFragment();
        return fragment;
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
                Intent intent = new Intent(getActivity(), PlaceBetActivity.class);
                startActivity(intent);
            }
        });

        return view;
    }

    private void init(){
        layoutManager = new LinearLayoutManager(getActivity().getApplicationContext());
        betsList.setLayoutManager(layoutManager);

        DividerItemDecoration dividerItemDecoration = new DividerItemDecoration(betsList.getContext(),
                layoutManager.getOrientation());
        betsList.addItemDecoration(dividerItemDecoration);

        db = FirebaseFirestore.getInstance();
    }

    private void getBetsList() {
        activity = (MainActivity) getActivity();
        mAuth = activity.getmAuth();
        Query query = db.collection("users/" + mAuth.getUid() + "/bets");

        FirestoreRecyclerOptions<SingleBet> bet = new FirestoreRecyclerOptions.Builder<SingleBet>()
                .setQuery(query, SingleBet.class)
                .build();

        adapter = new FirestoreRecyclerAdapter<SingleBet, BetsHolder>(bet) {
            @Override
            public void onBindViewHolder(BetsHolder holder, int position, SingleBet model) {
                holder.bind(model);
            }

            @Override
            public BetsHolder onCreateViewHolder(ViewGroup group, int i) {
                View view = LayoutInflater.from(group.getContext())
                        .inflate(R.layout.bet_row, group, false);
                return new BetsHolder(view);
            }

            @Override
            public void onError(FirebaseFirestoreException e) {
                Log.e("error", e.getMessage());
            }
        };
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

    public class BetsHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_bet_type) TextView typeText;
        @BindView(R.id.tv_bet_amount) TextView amountText;
        @BindView(R.id.tv_bet_group) TextView groupText;
        @BindView(R.id.btn_trigger_bet) Button triggerButton;

        private final String typeLabel = "Type: ";
        private final String amountLabel = "Amount: $";
        private final String groupLabel = "Group: ";

        public BetsHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(SingleBet bet) {
            typeText.setText(typeLabel + bet.getType());
            amountText.setText(amountLabel + bet.getAmount() + ".00");
            groupText.setText(groupLabel + bet.getGroup());
        }
    }
}
