import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/utils/image_constant.dart';

class CircleImageView extends StatelessWidget {
  final double? radius;
  final String? image;

  const CircleImageView({this.radius, this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: CachedNetworkImage(
        imageUrl: image!,
        fit: BoxFit.fitWidth,
        placeholder: (context, url) =>
            const CircularProgressIndicator(color: Colors.transparent),
        errorWidget: (context, url, error) => ClipOval(
          child: Image.asset(
            ImageConstant.imgnoimage,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
