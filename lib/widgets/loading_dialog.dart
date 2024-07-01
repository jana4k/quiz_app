import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
                SizedBox(height: 20),
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  void initialize(BuildContext context) {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _showConnectivitySnackBar(result, context);
      },
    );
  }

  void _showConnectivitySnackBar(
      ConnectivityResult result, BuildContext context) {
    final isConnected = result != ConnectivityResult.none;
    final snackBar = SnackBar(
      content: Text(
          isConnected ? 'Connected to the Internet' : 'No Internet Connection'),
      backgroundColor:
          isConnected ? const Color(0xff2100a6) : const Color(0xffE21FD0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void dispose() {
    _subscription.cancel();
  }
}
