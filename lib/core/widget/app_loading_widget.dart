import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  final String loadingMessage;

  const AppLoadingWidget({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
          ),
        ],
      ),
    );
  }
}