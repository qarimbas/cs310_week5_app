import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(176, 190, 197, 0.5),
      child: Center(
        child: SpinKitWave(
          color: Colors.deepOrange,
          size: 12,
        ),
      ),
    );
  }
}
