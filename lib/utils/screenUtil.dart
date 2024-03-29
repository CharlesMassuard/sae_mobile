import 'package:flutter/cupertino.dart';

class ScreenUtil {
  final BuildContext context;

  ScreenUtil(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;

  double responsiveFontSizeShort() {
    if (screenWidth < 350) {
      return 20;
    } else if (screenWidth < 600) {
      return 25;
    } else {
      return 30;
    }
  }

  double responsiveFontSizeMedium() {
    if (screenWidth < 350) {
      return 15;
    } else if (screenWidth < 600) {
      return 20;
    } else {
      return 25;
    }
  }

  double responsiveFontSizeLong() {
    if (screenWidth < 350) {
      return 10;
    } else if (screenWidth < 600) {
      return 15;
    } else {
      return 20;
    }
  }
}