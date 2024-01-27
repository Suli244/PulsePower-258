import 'package:flutter/material.dart';
import 'package:pulsepower_258/style/app_colors.dart';


class InputBordersSmartBudget {
  static OutlineInputBorder outlineBordercolorWhiteWidth1Radius10 =
      OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColorsPulsePower.colorWhite.withOpacity(0),
      width: 0,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(26),
    ),
  );

  static OutlineInputBorder outlineBorderColorGreenWidth2Radius10 =
      OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColorsPulsePower.colorWhite.withOpacity(0),
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(26),
    ),
  );
  static OutlineInputBorder outlineBordercolorF68080Width2Radius10 =
      OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColorsPulsePower.colorWhite,
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(
        10,
      ),
    ),
  );

  static const UnderlineInputBorder unOutlineBordercolorWhiteWidth1 =
      UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColorsPulsePower.colorWhite,
      width: 1,
    ),
  );
  static const UnderlineInputBorder unOutlineBorderColorGreenWidth2 =
      UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
      width: 2,
    ),
  );
  static const UnderlineInputBorder unOutlineBordercolorF68080Width2 =
      UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColorsPulsePower.colorWhite,
      width: 2,
    ),
  );
}
