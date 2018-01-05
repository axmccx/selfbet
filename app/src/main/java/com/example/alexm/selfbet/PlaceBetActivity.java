package com.example.alexm.selfbet;

import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GetTokenResult;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PlaceBetActivity extends AppCompatActivity {

    @BindView(R.id.input_bet_amount) EditText betAmount;
    @BindView(R.id.btn_bet_submit) Button submit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_place_bet);
        ButterKnife.bind(this);

        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String groupName = "Test2";
                String type = "mock";
                String amount = betAmount.getText().toString();
                placeBet(groupName, type, amount);
                finish();
            }
        });
    }

    protected void placeBet(final String groupName, final String type, final String amount) {
        FirebaseUser mUser = FirebaseAuth.getInstance().getCurrentUser();

        mUser.getToken(true).addOnCompleteListener(new OnCompleteListener<GetTokenResult>() {
            public void onComplete(@NonNull Task<GetTokenResult> task) {
                if (task.isSuccessful()) {
                    String idToken = task.getResult().getToken();
                    new CloudFuncHTTP(getApplicationContext())
                            .execute(idToken, CloudFuncHTTP.PLACE_BET_FUNC, groupName, type, amount);
                } else {
                    Toast.makeText(getApplicationContext(), "AUTH ERROR", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
