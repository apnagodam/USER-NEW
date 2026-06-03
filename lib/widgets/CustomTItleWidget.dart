import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customTitleWidget({required String title}) => Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Container(
            height: 48,
            width: Get.width / 1.5,
            decoration: BoxDecoration(
                color: ColorConstant.maingreen,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF12281B), // Deep green-black
                      Color(0xFF275135), // Your main green
                      Color(0xFF3E7251),
                    ])),
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(
                    title.tr,
                    style: AppStyle.lblbuydetail,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -40,
          bottom: 0,
          top: 0,
          child: Transform.rotate(
            angle: 0.9, // Adjust the angle as needed
            child: Container(
              width: 120,
              height: 190,
              color: Colors.white,
            ),
          ),
        ),
        // Other widgets can be added here...
      ],
    );

Widget customWalletTitle(
        {required String title, Alignment? align = Alignment.centerLeft}) =>
    IntrinsicHeight(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              alignment: align,
              padding: Pad(all: 10),
              width: Get.width,
              decoration: BoxDecoration(
                  color: ColorConstant.maingreen,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFF12281B), // Deep green-black
                        Color(0xFF275135), // Your main green
                        Color(0xFF3E7251),
                      ])),
              child: Text(
                title.tr,
                style: AppStyle.lblbuydetail,
              ),
            ),
          ),
          // Positioned(
          //   right: -60,
          //   bottom: 0,
          //   top: 0,
          //   child: Transform.rotate(
          //     angle: 0.9, // Adjust the angle as needed
          //     child: Container(
          //       width: 120,
          //       height: 190,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // Other widgets can be added here...
        ],
      ),
    );
