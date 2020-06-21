import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const AppErrorWidget({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.black45,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}