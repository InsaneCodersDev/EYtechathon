import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            // colors: [Color(0x000000), Color(0xBB923CB5)],
            colors: [
              Colors.teal[200],
              Colors.grey[900],
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }
}
