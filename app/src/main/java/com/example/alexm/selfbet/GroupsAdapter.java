package com.example.alexm.selfbet;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

public class GroupsAdapter extends RecyclerView.Adapter<GroupsAdapter.ViewHolder> {
    private List<String> groupList;

    public class ViewHolder extends RecyclerView.ViewHolder {
        public TextView txtHeader;
        public TextView txtFooter;
        public View layout;

        public ViewHolder(View v) {
            super(v);
            txtHeader = v.findViewById(R.id.groupName);
            txtFooter = v.findViewById(R.id.secondLine);
        }
    }

//    public void add(int position, String item) {
//        groupList.add(position, item);
//        notifyItemInserted(position);
//    }
//
//    public void remove(int position) {
//        groupList.remove(position);
//        notifyItemRemoved(position);
//    }

    public GroupsAdapter(List<String> g) {
        groupList = g;
    }

    @Override
    public GroupsAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(parent.getContext());
        View v = inflater.inflate(R.layout.group_row, parent, false);
        ViewHolder vh = new ViewHolder(v);
        return vh;
    }

    @Override
    public void onBindViewHolder(GroupsAdapter.ViewHolder holder, int position) {
        final String name = groupList.get(position);
        holder.txtHeader.setText(name);
    }

    @Override
    public int getItemCount() {
        return groupList.size();
    }
}
