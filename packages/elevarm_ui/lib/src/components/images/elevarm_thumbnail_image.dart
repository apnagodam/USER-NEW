import 'package:elevarm_icons/elevarm_icons.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';

class ElevarmThumbnailImage extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onDelete;
  final VoidCallback? onError;
  final VoidCallback? onTap;
  final ImageProvider image;
  final double size;
  final double deleteButtonOffset;

  const ElevarmThumbnailImage({
    required this.image,
    this.isLoading = false,
    this.size = 76.0,
    this.deleteButtonOffset = 4.0,
    this.onDelete,
    this.onError,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + deleteButtonOffset,
      width: size + deleteButtonOffset,
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Material(
              color: ElevarmColors.primary200,
              borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
                child: Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading) _buildLoadingOverlay(context),
          if (onError != null) _buildErrorOverlay(context),
          if (onDelete != null) _buildDeleteButton(context),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: ElevarmColors.primary200.withAlpha(125),
          borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
        ),
        child: const Center(
          child: SizedBox(
            height: 16.0,
            width: 16.0,
            child: CircularProgressIndicator(
              color: ElevarmColors.white,
              strokeWidth: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Positioned(
      top: 0.0,
      right: 0.0,
      child: Material(
        color: ElevarmColors.danger600,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onDelete,
          customBorder: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: 24.0,
            width: 24.0,
            child: const ElevarmIcon(
              ElevarmIconsOutline.trash_01,
              color: ElevarmColors.white,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorOverlay(BuildContext context) {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      child: Material(
        color: ElevarmColors.danger200.withAlpha(200),
        borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
        child: InkWell(
          onTap: onError,
          borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
            ),
            child: const Center(
              child: ElevarmIcon(
                ElevarmIconsOutline.refresh_cw_01,
                size: 16.0,
                color: ElevarmColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
