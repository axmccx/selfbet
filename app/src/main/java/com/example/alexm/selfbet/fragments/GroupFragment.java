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
import android.widget.TextView;

import com.example.alexm.selfbet.CreateGroupActivity;
import com.example.alexm.selfbet.FirebaseProvider;
import com.example.alexm.selfbet.GroupsAdapter;
import com.example.alexm.selfbet.JoinGroupActivity;
import com.example.alexm.selfbet.R;
import com.getbase.floatingactionbutton.FloatingActionButton;
import com.getbase.floatingactionbutton.FloatingActionsMenu;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GroupFragment extends Fragment implements Observer {

    @BindView(R.id.groups_act_menu) FloatingActionsMenu menuMultipleActions;
    @BindView(R.id.create_group_act) FloatingActionButton createGroup;
    @BindView(R.id.join_group_act) FloatingActionButton joinGroup;
    @BindView(R.id.tv_joinGroupNotice) TextView groupMembership;
    @BindView(R.id.rv_groups) RecyclerView groupList;

    private RecyclerView.Adapter groupsAdapter;

    public static GroupFragment newInstance() {
        return new GroupFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivity().setTitle(R.string.title_group);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_group, container, false);
        ButterKnife.bind(this, view);

        init();

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

        groupsAdapter = new GroupsAdapter(FirebaseProvider.getGroupList());
        groupsAdapter.notifyDataSetChanged();
        groupList.setAdapter(groupsAdapter);
        return view;
    }

    private void init() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity().getApplicationContext());
        groupList.setLayoutManager(layoutManager);

        DividerItemDecoration dividerItemDecoration = new DividerItemDecoration(groupList.getContext(),
                layoutManager.getOrientation());
        groupList.addItemDecoration(dividerItemDecoration);

        if (!(FirebaseProvider.getGroupList().isEmpty())) {
            groupMembership.setVisibility(View.GONE);
            groupMembership.setVisibility(View.INVISIBLE);
        }
    }

    @Override
    public void update(Observable observable, Object o) {
        groupsAdapter = new GroupsAdapter(FirebaseProvider.getGroupList());
        groupsAdapter.notifyDataSetChanged();
        groupList.setAdapter(groupsAdapter);

        if (!(FirebaseProvider.getGroupList().isEmpty())) {
            groupMembership.setVisibility(View.INVISIBLE);
        } else {
            groupMembership.setVisibility(View.VISIBLE);
        }
    }
}