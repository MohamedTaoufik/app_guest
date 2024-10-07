import 'package:app_guest/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDowButton extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? hintStyle;
  final TextStyle? valueStyle;

  final String? hintText;
  final String? selectedValue;
  final List<String>? list;
  final void Function(String?)? onChanged;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  const CustomDropDowButton(
      {super.key,
      this.contentPadding,
      this.focusedBorder,
      this.enabledBorder,
      this.hintStyle,
      this.selectedValue,
      required this.list,
      this.onChanged,
      this.suffixIcon,
      this.backgroundColor,
      this.hintText,
      this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        hint: Center(
          child: Text(hintText!, style: hintStyle ??
              TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.eerieBlack,
              ),),
        ),
        decoration: InputDecoration(
          //uses less vertical space
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 18.h,
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.blue,
                  width: 1,
                ),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.veryLightGrey,
                  width: 1,
                ),
              ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        

          fillColor: backgroundColor ?? AppColors.moreLightGrey,
          filled: true,
        ),
        
        // Initial Value
        value: selectedValue,

        // Down Arrow Icon
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.eerieBlack,
        ),

        // Array list of items
        items: list!.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: valueStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.eerieBlack,
                  ),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: onChanged);
  }
}
