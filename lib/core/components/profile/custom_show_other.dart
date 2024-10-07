import 'package:app_guest/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShowOther extends StatefulWidget {
  final List<Widget>? listAttributs;
  const CustomShowOther({super.key, this.listAttributs});

  @override
  _CustomShowOtherState createState() => _CustomShowOtherState();
}

class _CustomShowOtherState extends State<CustomShowOther> {
  bool showOtherField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () {
            setState(() {
              showOtherField = !showOtherField;
            });
          },
          label: Text(
            showOtherField ? 'Hide Other' : 'Show Other',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.eerieBlack,
            ),
          ),
          icon: Icon(
              showOtherField ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        ),
        if (showOtherField) ...?widget.listAttributs
      ],
    );
  }
}
