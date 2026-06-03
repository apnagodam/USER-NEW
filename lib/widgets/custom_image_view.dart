import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:elevarm_icons/elevarm_icons.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';

import '../core/utils/image_constant.dart';

class CommonCachedImage extends StatelessWidget {
  String? image;
  double? height = 35;
  double? width = 35;
  BoxFit? boxFit = BoxFit.fill;

  CommonCachedImage({
    this.image,
    this.height,
    this.width,
    this.boxFit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image!,
      fit: BoxFit.fill,
      height: height,
      width: width,
      imageBuilder:
          (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: boxFit),
            ),
          ),
      placeholder:
          (context, url) =>
              const CircularProgressIndicator(color: Colors.transparent),
      errorWidget:
          (context, url, error) => DottedBorder(
            padding: Pad(all: 10),
            child: Center(child: ElevarmIcon(ElevarmIconsOutline.image_01)),
          ),
    );
  }
}
