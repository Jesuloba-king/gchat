// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {super.key,
      this.controller,
      this.onTap,
      this.heightPadding,
      this.width,
      required this.labelText,
      this.suffixIcon,
      this.initalValue,
      this.enabled,
      this.maxLines,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.readOnly = false,
      this.maxLength,
      this.suffix,
      this.backgroundColor,
      this.borderWidth,
      this.onChanged,
      this.textColor,
      this.prefixIcon,
      this.focusNode,
      this.textInputAction,
      this.helperText,
      this.autovalidateMode,
      this.textCapitalization = TextCapitalization.none});

  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final double? heightPadding;
  final double? width;
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initalValue;
  final bool? enabled;
  final int? maxLines;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final bool obscureText, readOnly;
  final int? maxLength;
  final Widget? suffix;
  final Color? backgroundColor;
  final double? borderWidth;
  final Color? textColor;
  final FocusNode? focusNode;
  AutovalidateMode? autovalidateMode;
  final String? helperText;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focusNode,
        maxLength: maxLength,
        obscureText: obscureText,
        readOnly: readOnly,
        autovalidateMode: autovalidateMode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        validator: validator,
        maxLines: maxLines ?? 1,
        enabled: enabled,
        initialValue: initalValue,
        onTap: onTap,
        onChanged: onChanged,
        cursorColor: AppColors.grey,
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          // suffix: suffix,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          helperText: helperText,
          errorStyle: const TextStyle(fontSize: 13),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          counterText: '',
          hintText: labelText,
          contentPadding: EdgeInsets.symmetric(
              vertical: heightPadding ?? 15, horizontal: 8),
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),

          errorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.red,
              width: borderWidth ?? 1,
            ),
          ),
        ));
  }
}

//chat field
class ChatTextField extends StatelessWidget {
  ChatTextField(
      {super.key,
      this.controller,
      this.onTap,
      this.heightPadding,
      this.width,
      required this.labelText,
      this.suffixIcon,
      this.initalValue,
      this.enabled,
      this.maxLines,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.readOnly = false,
      this.maxLength,
      this.suffix,
      this.backgroundColor,
      this.borderWidth,
      this.onChanged,
      this.textColor,
      this.prefixIcon,
      this.focusNode,
      this.textInputAction,
      this.helperText,
      this.autovalidateMode,
      this.textCapitalization = TextCapitalization.none});

  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final double? heightPadding;
  final double? width;
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initalValue;
  final bool? enabled;
  final int? maxLines;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final bool obscureText, readOnly;
  final int? maxLength;
  final Widget? suffix;
  final Color? backgroundColor;
  final double? borderWidth;
  final Color? textColor;
  final FocusNode? focusNode;
  AutovalidateMode? autovalidateMode;
  final String? helperText;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focusNode,
        maxLength: maxLength,
        obscureText: obscureText,
        readOnly: readOnly,
        autovalidateMode: autovalidateMode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        validator: validator,
        maxLines: maxLines ?? 1,
        enabled: enabled,
        initialValue: initalValue,
        onTap: onTap,
        onChanged: onChanged,
        cursorColor: AppColors.grey,
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          // suffix: suffix,
          isDense: true,
          filled: true,
          fillColor: Color(0xffF2F2F2),
          helperText: helperText,
          errorStyle: const TextStyle(fontSize: 13),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          counterText: '',
          hintText: labelText,
          contentPadding: EdgeInsets.symmetric(
              vertical: heightPadding ?? 15, horizontal: 8),
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xffF2F2F2),
              width: borderWidth ?? 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xffF2F2F2),
              width: borderWidth ?? 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xffF2F2F2),
              width: borderWidth ?? 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xffF2F2F2),
              width: borderWidth ?? 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.red,
              width: borderWidth ?? 1,
            ),
          ),
        ));
  }
}
