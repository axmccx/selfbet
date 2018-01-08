package com.example.alexm.selfbet;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.firebase.ui.firestore.FirestoreRecyclerAdapter;
import com.firebase.ui.firestore.FirestoreRecyclerOptions;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GetTokenResult;

import butterknife.BindView;
import butterknife.ButterKnife;


public class FSRecyclerAdapter extends FirestoreRecyclerAdapter<SingleBet, FSRecyclerAdapter.BetsHolder> {

    public FSRecyclerAdapter(FirestoreRecyclerOptions<SingleBet> bet){
        super(bet);
    }

    @Override
    protected void onBindViewHolder(BetsHolder holder, int position, SingleBet model) {
        holder.bind(model);
    }

    @Override
    public FSRecyclerAdapter.BetsHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.bet_row, parent, false);
        return new BetsHolder(view);
    }


    public class BetsHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        @BindView(R.id.tv_bet_type) TextView typeText;
        @BindView(R.id.tv_bet_amount) TextView amountText;
        @BindView(R.id.tv_bet_group) TextView groupText;
        @BindView(R.id.btn_trigger_bet) Button triggerButton;

        private final String typeLabel = "Type: ";
        private final String amountLabel = "Amount: $";
        private final String groupLabel = "Group: ";

        BetsHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
            triggerButton.setOnClickListener(this);
        }

        public void bind(SingleBet bet) {
            typeText.setText(typeLabel + bet.getType());
            amountText.setText(amountLabel + bet.getAmount() + ".00");
            groupText.setText(groupLabel + bet.getGroup());
        }

        @Override
        public void onClick(View view) {
            int position = getAdapterPosition();
            String betId = getSnapshots().getSnapshot(position).getId();
            Log.d("Bet trigger", " button pressed, betID: " + betId);
            triggerBet(view.getContext(), betId);
        }

        private void triggerBet(final Context context, final String betId) {
            FirebaseUser mUser = FirebaseProvider.getAuth().getCurrentUser();
            mUser.getIdToken(true).addOnCompleteListener(new OnCompleteListener<GetTokenResult>() {
                public void onComplete(@NonNull Task<GetTokenResult> task) {
                    if (task.isSuccessful()) {
                        String idToken = task.getResult().getToken();
                        new CloudFuncHTTP(context).execute(idToken, CloudFuncHTTP.TRIGGER_BET_FUNC, betId);
                    } else {
                        Toast.makeText(context, "AUTH ERROR", Toast.LENGTH_SHORT).show();
                    }
                }
            });
        }
    }
}
