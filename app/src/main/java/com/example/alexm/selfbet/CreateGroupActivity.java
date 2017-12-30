package com.example.alexm.selfbet;

import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
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

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

import butterknife.BindView;
import butterknife.ButterKnife;

public class CreateGroupActivity extends AppCompatActivity {
    @BindView(R.id.input_group_name) TextView input;
    @BindView(R.id.btn_group_submit) Button submit;

    private String cloudFunc = "https://us-central1-selfbet-489b2.cloudfunctions.net/createGroup?groupName=";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_group);
        ButterKnife.bind(this);

        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String groupName = input.getText().toString();
                createGroup(groupName);
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

    protected void createGroup(final String groupName) {
        FirebaseUser mUser = FirebaseAuth.getInstance().getCurrentUser();

        mUser.getToken(true).addOnCompleteListener(new OnCompleteListener<GetTokenResult>() {
            public void onComplete(@NonNull Task<GetTokenResult> task) {
                if (task.isSuccessful()) {
                    String idToken = task.getResult().getToken();
                    new httpResquest().execute(idToken, groupName);
                } else {
                    Toast.makeText(getApplicationContext(), "AUTH ERROR", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    public class httpResquest extends AsyncTask<String, String, String> {

        HttpURLConnection urlConnection;
        private String TAG = "httpRequest";

        @Override
        protected String doInBackground(String... strings) {
            String result = null;

            try {
                URL url = new URL(cloudFunc + strings[1]);
                urlConnection = (HttpURLConnection) url.openConnection();
                urlConnection.setRequestProperty("Authorization", strings[0]);

                int responseCode = urlConnection.getResponseCode();
                if(responseCode == HttpsURLConnection.HTTP_OK){
                    result = readStream(urlConnection.getInputStream());
                    Log.v("httpRequest Result:", result);
                }
            } catch( Exception e) {
                e.printStackTrace();
            }
            finally {
                if (urlConnection != null) {
                    urlConnection.disconnect();
                }
            }
            return result;
        }

        @Override
        protected void onPostExecute(String result) {
            Toast.makeText(getApplicationContext(), result, Toast.LENGTH_SHORT).show();
            super.onPostExecute(result);
        }

        private String readStream(InputStream is) {   //static if it were on its own class
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            StringBuilder sb = new StringBuilder();
            String line;
            try {
                while ((line = reader.readLine()) != null) {
                    sb.append(line).append("\n");
                }
            } catch (IOException e) {
                Log.e(TAG, "IOException", e);
            } finally {
                try {
                    is.close();
                } catch (IOException e) {
                    Log.e(TAG, "IOException", e);
                }
            }
            return sb.toString();
        }
    }
}
