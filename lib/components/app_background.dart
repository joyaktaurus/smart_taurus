import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(77, 82, 225, 1),
      // Set Scaffold background color to RGBA(6, 6, 6, 1)
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[

            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
