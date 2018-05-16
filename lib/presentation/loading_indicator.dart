import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 200.0,
      height: 70.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: Center(
            child: Row(
              children: <Widget>[
                Padding( padding: EdgeInsets.all(5.0),),
                CircularProgressIndicator(),
                Padding( padding: EdgeInsets.all(15.0)),
                Text("Authenticating..."),
              ],
            )
          ),
        ),
      ),
    );
  }
}