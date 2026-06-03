import 'package:dotted_border/dotted_border.dart';
import 'package:elevarm_icons/elevarm_icons.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';

class ElevarmThumbnailImageInput extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;
  final double deleteButtonOffset;

  const ElevarmThumbnailImageInput({
    this.size = 76.0,
    this.deleteButtonOffset = 4.0,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: deleteButtonOffset + 1.0,
        right: deleteButtonOffset + 1.0,
      ),
      child: Material(
        color:
            onTap != null ? ElevarmColors.primary100 : ElevarmColors.neutral100,
        borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
          child: DottedBorder(
            padding: EdgeInsets.zero,
            color: onTap != null
                ? ElevarmColors.primary
                : ElevarmColors.neutral200,
            dashPattern: const [2.0],
            borderType: BorderType.RRect,
            radius: const Radius.circular(ElevarmBorderRadius.sm),
            child: SizedBox(
              height: size,
              width: size,
              child: ElevarmIcon(
                ElevarmIconsOutline.image_plus,
                color: onTap != null
                    ? ElevarmColors.primary
                    : ElevarmColors.neutral200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
