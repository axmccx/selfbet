package com.example.alexm.selfbet.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.alexm.selfbet.CreateGroupActivity;
import com.example.alexm.selfbet.JoinGroupActivity;
import com.example.alexm.selfbet.LoginActivity;
import com.example.alexm.selfbet.MainActivity;
import com.example.alexm.selfbet.R;
import com.getbase.floatingactionbutton.FloatingActionButton;
import com.getbase.floatingactionbutton.FloatingActionsMenu;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.EventListener;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreException;

import java.lang.reflect.Array;
import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GroupFragment extends Fragment {

    @BindView(R.id.groups_act_menu) FloatingActionsMenu menuMultipleActions;
    @BindView(R.id.create_group_act) FloatingActionButton createGroup;
    @BindView(R.id.join_group_act) FloatingActionButton joinGroup;
    @BindView(R.id.tv_groupMembership) TextView groupMembership;

    public static final String GROUP_KEY= "memberOfGroups";
    private View view;
    private MainActivity activity;
    private FirebaseAuth mAuth;
    private FirebaseFirestore mFirestore;
    private DocumentReference mDocRef;

    public static GroupFragment newInstance() {
        GroupFragment fragment = new GroupFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_group);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_group, container, false);
        ButterKnife.bind(this, view);

        createGroup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), CreateGroupActivity.class);
                startActivity(intent);
            }
        });

        joinGroup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), JoinGroupActivity.class);
                startActivity(intent);
            }
        });

        activity = (MainActivity) getActivity();
        mAuth = activity.getmAuth();

        if (mAuth.getCurrentUser() != null) {
            mFirestore = FirebaseFirestore.getInstance();
            mDocRef = mFirestore.document("users/" + mAuth.getUid());

            mDocRef.addSnapshotListener(activity, new EventListener<DocumentSnapshot>() {
                @Override
                public void onEvent(DocumentSnapshot documentSnapshot, FirebaseFirestoreException e) {
                if (documentSnapshot != null && documentSnapshot.exists()) {
                    ArrayList<String> userBalance = (ArrayList<String>) documentSnapshot.get(GROUP_KEY);
                    if (userBalance != null) {
                        groupMembership.setText("You are a member of the following groups: \n \n");
                        for (String group: userBalance) {
                            groupMembership.append(group);
                        }
                    }
                }
                }
            });
        }
        return view;
    }
}

