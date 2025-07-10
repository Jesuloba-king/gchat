import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.color, this.size});
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
          color: color ?? AppColors.appThemeColor, size: size ?? 50),
    );
  }
}
