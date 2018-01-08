package com.example.alexm.selfbet;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;


// This class is for making http calls to run firebase cloud functions. App context is
// passed when created.
//
// It requires the following parameters:
//  - the users tokenID
//  - Which function to run
//  - the functions parameter(s)

public class CloudFuncHTTP extends AsyncTask<String, String, String> {

    private HttpURLConnection urlConnection;

    private static final String baseURL = "https://us-central1-selfbet-489b2.cloudfunctions.net/";
    private static Context mContext;

    static final String CREATE_GROUP_FUNC = "createGroup";    // needs one parameter
    static final String JOIN_GROUP_FUNC = "joinGroup";        // needs one parameter
    static final String PLACE_BET_FUNC = "placeBet";        // needs three parameters
    static final String TRIGGER_BET_FUNC = "triggerBet";


    CloudFuncHTTP(Context context) {
        mContext = context;
    }

    private String urlBuilder(String... strings) {
        String func = strings[1];
        StringBuilder out = new StringBuilder();
        switch (func) {
            case CREATE_GROUP_FUNC:
                if (strings.length == 3) {
                    out.append(baseURL);
                    out.append(CREATE_GROUP_FUNC);
                    out.append("/");
                    out.append(strings[2]);
                }
                break;

            case JOIN_GROUP_FUNC:
                if (strings.length == 3) {
                    out.append(baseURL);
                    out.append(JOIN_GROUP_FUNC);
                    out.append("/");
                    out.append(strings[2]);
                }
                break;

            case PLACE_BET_FUNC:
                if (strings.length == 5) {
                    out.append(baseURL);
                    out.append(PLACE_BET_FUNC);
                    out.append("/");
                    out.append(strings[2]);
                    out.append("/");
                    out.append(strings[3]);
                    out.append("/");
                    out.append(strings[4]);
                }
                break;

            case TRIGGER_BET_FUNC:
                if (strings.length == 3) {
                    out.append(baseURL);
                    out.append(TRIGGER_BET_FUNC);
                    out.append("/");
                    out.append(strings[2]);
                }
                break;

            default:
                throw new RuntimeException("Unknown cloud function");
        }

        if (out.toString().isEmpty()) {
            throw new RuntimeException("Wrong number of params for " + func);
        } else {
            return out.toString();
        }
    }

    @Override
    protected String doInBackground(String... strings) {
        String result = null;
        try {
            String tokenID = strings[0];
            String urlString = urlBuilder(strings);
            URL url = new URL(urlString);
            urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestProperty("Authorization", tokenID);

            int responseCode = urlConnection.getResponseCode();
            if(responseCode == HttpsURLConnection.HTTP_OK){
                result = readStream(urlConnection.getInputStream());
                Log.v("httpRequest Result:", result);
            }
        } catch(Exception e) {
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
        Toast.makeText(mContext, result, Toast.LENGTH_SHORT).show();
        super.onPostExecute(result);
    }

    private String readStream(InputStream is) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line;
        String TAG = "CloudFuncHTTP";
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