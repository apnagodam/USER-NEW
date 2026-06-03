import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';

errorBottomSheet(BuildContext context, String text) => showBarModalBottomSheet(
    context: context,
    builder: (context) => SafeArea(
            child: Padding(
          padding: Pad(all: 10),
          child: ColumnSuper(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: Adaptive.inches(1),
              color: ColorConstant.red500,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold),
            )
          ]),
        )));
