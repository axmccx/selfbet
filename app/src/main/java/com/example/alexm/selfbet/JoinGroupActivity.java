package com.example.alexm.selfbet;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GetTokenResult;

import butterknife.BindView;
import butterknife.ButterKnife;

public class JoinGroupActivity extends AppCompatActivity {
    @BindView(R.id.input_group_name) TextView input;
    @BindView(R.id.btn_group_submit) Button submit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_group);
        ButterKnife.bind(this);

        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String groupName = input.getText().toString();
                joinGroup(groupName);
                finish();
            }
        });

        input.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if ((event != null && (event.getKeyCode() == KeyEvent.KEYCODE_ENTER)) || (actionId == EditorInfo.IME_ACTION_DONE)) {
                    submit.performClick();
                }
                return false;
            }
        });
    }

    protected void joinGroup(final String groupName) {
        FirebaseUser mUser = FirebaseAuth.getInstance().getCurrentUser();

        mUser.getToken(true).addOnCompleteListener(new OnCompleteListener<GetTokenResult>() {
            public void onComplete(@NonNull Task<GetTokenResult> task) {
                if (task.isSuccessful()) {
                    String idToken = task.getResult().getToken();
                    new CloudFuncHTTP(getApplicationContext()).execute(idToken, CloudFuncHTTP.JOIN_GROUP_FUNC, groupName);
                } else {
                    Toast.makeText(getApplicationContext(), "AUTH ERROR", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
