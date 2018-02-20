package com.example.alexm.selfbet;

import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GetTokenResult;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PlaceBetActivity extends AppCompatActivity {

    @BindView(R.id.input_bet_amount) EditText betAmount;
    @BindView(R.id.btn_bet_submit) Button submit;
    @BindView(R.id.group_spinner) Spinner choosenGroup;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_place_bet);
        ButterKnife.bind(this);

        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String groupName = choosenGroup.getSelectedItem().toString();
                String type = "mock";
                String amount = betAmount.getText().toString();
                placeBet(groupName, type, amount);
                finish();
            }
        });

        ArrayAdapter<String> adapter = new ArrayAdapter<>(this,
                android.R.layout.simple_spinner_dropdown_item, FirebaseProvider.getGroupList());
        choosenGroup.setAdapter(adapter);
    }

    protected void placeBet(final String groupName, final String type, final String amount) {
        // procedure to use the IdToken. How could I reuse this with the same procedure
        // in the joingroup and creategroup classes. (Anything that needs the tokenID to call
        // a cloud function?
        FirebaseUser mUser = FirebaseProvider.getAuth().getCurrentUser();
        mUser.getIdToken(true).addOnCompleteListener(new OnCompleteListener<GetTokenResult>() {
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
