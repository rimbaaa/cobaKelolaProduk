import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cobaKelolaProduk/src/constants/enum.dart';

import '../constants/color.dart';
import '../utils/utils.dart';
import '../widgets/lazytoast/lazytoast.dart';

// variables
TextStyle? _defaultTextStyle;
IconType _defaultIconType = IconType.tablerIcon;
double _defaultSpace = 20.0;
double _defaultRadius = 7.0;

// lazy ui
class LazyUi {
  // get default text style
  static TextStyle get font =>
      _defaultTextStyle ??
      GoogleFonts.nunitoSans(fontSize: 15.5, color: LzColors.black);

  // get default icon type
  static IconType get iconType => _defaultIconType;

  // get default spacing
  static double get space => _defaultSpace;

  // get default radius
  static double get radius => _defaultRadius;

  // initialize configurations
  static config(
      {AppTheme theme = AppTheme.light,
      TextStyle? defaultTextStyle,
      IconType icon = IconType.tablerIcon,
      double? space,
      double? radius,
      bool alwaysPortrait = false}) {
    // set app theme
    switch (theme) {
      case AppTheme.dark:
        Utils.setSystemUI(navBarColor: Colors.black);
        break;

      case AppTheme.light:
        Utils.setSystemUI(navBarColor: Colors.white);
        break;
      default:
        Utils.setSystemUI();
    }

    if (alwaysPortrait) {
      Utils.orientation(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }

    // set default text style
    _defaultTextStyle = defaultTextStyle;

    // set default icon type
    _defaultIconType = icon;

    // set default spacing
    _defaultSpace = space ?? _defaultSpace;

    // set default radius
    _defaultRadius = radius ?? _defaultRadius;
  }

  // builder
  static Widget builder(BuildContext context, Widget? widget,
      {double maxScalingFontSize = 1.1, bool useLazyToast = true}) {
    double fontDeviceSize = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor:
              fontDeviceSize > maxScalingFontSize ? maxScalingFontSize : 1.0,
        ),
        child: useLazyToast
            ? LzToastOverlay(child: widget)
            : widget ?? const SizedBox.shrink());
  }
}
