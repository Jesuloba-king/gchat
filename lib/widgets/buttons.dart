import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import 'app_loader.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.textColor,
    this.borderColor,
    this.buttonColor,
    this.text,
    this.ontap,
    this.isFocused = false,
    this.padding,
    this.height,
    this.width,
    this.loading = false,
    this.borderRadius,
  });

  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final String? text;
  final bool isFocused;
  final bool loading;
  final void Function()? ontap;
  final double? padding, width, height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : ontap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        width: width ?? double.infinity,
        height: height ?? 55,
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? AppColors.appThemeColor, width: 1),
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          color: buttonColor ?? AppColors.appThemeColor,
        ),
        child: loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  AppLoader(size: 20, color: Colors.white),
                ],
              )
            : Text(
                text ?? 'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.imagePath,
    required this.text,
    this.onTap,
    required this.trailing,
    this.textColor,
  });

  final String imagePath;
  final String text;
  final Color? textColor;
  final Function()? onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // contentPadding: EdgeInsets.all(2),
        onTap: onTap,
        leading: SvgPicture.asset(
          imagePath,
          height: 40,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        trailing: trailing);
  }
}

class ProfileWidgetTitle extends StatelessWidget {
  const ProfileWidgetTitle({
    super.key,
    required this.categoryHeading,
  });

  final String categoryHeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 15, bottom: 8),
      child: Row(
        children: [
          Text(
            categoryHeading,
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class GChatText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  const GChatText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontStyle,
      this.fontWeight,
      this.fontColor,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: 1.0,
        fontFamily: "Inter",
        color: fontColor ?? AppColors.textColor,
      ),
    );
  }
}
