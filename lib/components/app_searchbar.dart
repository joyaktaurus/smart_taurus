
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_theme.dart';

class MASearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? textFieldOnchanged;
  final ValueChanged<String?>? dropDownOnchanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction textInputAction;
  final VoidCallback suffixIconBtnFn;
  final String? searchTypeChosenValue;
  final VoidCallback? goToQRScan;
  final VoidCallback searchFn;
  final bool isQrCode;
  final String? hintText;
  const MASearchBar(
      {Key? key,
      required this.controller,
      this.textFieldOnchanged,
      this.onFieldSubmitted,
      required this.textInputAction,
      required this.suffixIconBtnFn,
      this.searchTypeChosenValue,
      this.dropDownOnchanged,
      this.goToQRScan,
      this.isQrCode = true,
      required this.searchFn,
        this.hintText,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       // width: Get.width * .9,
        height: Get.height * .07,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0XFFCDD4D9),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(45.0),
          ),
            boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      color: Colors.grey.shade300,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 10,
                    ),
                  ],
        ),
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                cursorColor: Colors.white,
                onChanged: textFieldOnchanged,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: onFieldSubmitted,
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: suffixIconBtnFn,
                          icon: const Icon(Icons.close))
                      : null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 0, bottom: 12, top: 5, right: 0),
                  hintText: hintText//16
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.11,
              margin: const EdgeInsets.all(0),
              child: TextButton(
                onPressed: searchFn,
                child:  Icon(Icons.search, color: MyTheme.myBlueDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
