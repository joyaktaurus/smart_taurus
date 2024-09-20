import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_theme.dart';

class MAResultEmpty extends StatelessWidget {
  final String msg;
  final Color textColorReceived;
  final Widget? buttnWidget;
  const MAResultEmpty(
      {Key? key,
      required this.msg,
      this.textColorReceived = Colors.black,
       this.buttnWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      margin:  EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             SizedBox(
              width: 10,
            ),
            Image(
              image: AssetImage('assets/images/no_data.png'),
              height: Get.height * .20,
              width: Get.width * .40,
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: MyTheme.regularTextStyle(color: textColorReceived,fontSize:14,fontWeight: FontWeight.w500)
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
