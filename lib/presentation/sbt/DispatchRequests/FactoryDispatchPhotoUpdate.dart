import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Factorydispatchphotoupdate extends ConsumerStatefulWidget {
  const Factorydispatchphotoupdate(
      {super.key, required this.sbtOrderId, required this.dispatchRequestId});
  final String? sbtOrderId;
  final String? dispatchRequestId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FactorydispatchphotoupdateState();
}

class _FactorydispatchphotoupdateState
    extends ConsumerState<Factorydispatchphotoupdate> {
  final ImagePicker _imagePicker = ImagePicker();

  // State providers for each image
  final kantaParchiPhotoProvider = StateProvider<File?>((ref) => null);
  final biltyPhotoProvider = StateProvider<File?>((ref) => null);
  final loadTruckPhotoProvider = StateProvider<File?>((ref) => null);
  final truckDriverPhotoProvider = StateProvider<File?>((ref) => null);
  final qualityPhotoProvider = StateProvider<File?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        title: Text(
          AppLocalizations.of(context)!.updateDispatchPhotos,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: Pad(all: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kanta Parchi Photo
            _buildPhotoSection(
              title: AppLocalizations.of(context)!.kantaParchiPhoto,
              provider: kantaParchiPhotoProvider,
              onImageSelected: (file) {
                ref.read(kantaParchiPhotoProvider.notifier).state = file;
              },
            ),
            SizedBox(height: 20),

            // Bilty Photo
            _buildPhotoSection(
              title: AppLocalizations.of(context)!.biltyImage,
              provider: biltyPhotoProvider,
              onImageSelected: (file) {
                ref.read(biltyPhotoProvider.notifier).state = file;
              },
            ),
            SizedBox(height: 20),

            // Load Truck Photo
            _buildPhotoSection(
              title: AppLocalizations.of(context)!.loadTruckPhoto,
              provider: loadTruckPhotoProvider,
              onImageSelected: (file) {
                ref.read(loadTruckPhotoProvider.notifier).state = file;
              },
            ),
            SizedBox(height: 20),

            // Truck Driver Photo
            _buildPhotoSection(
              title: AppLocalizations.of(context)!.truckDriverPhoto,
              provider: truckDriverPhotoProvider,
              onImageSelected: (file) {
                ref.read(truckDriverPhotoProvider.notifier).state = file;
              },
            ),
            SizedBox(height: 20),

            // Quality Photo
            _buildPhotoSection(
              title: AppLocalizations.of(context)!.qualityPhoto,
              provider: qualityPhotoProvider,
              onImageSelected: (file) {
                ref.read(qualityPhotoProvider.notifier).state = file;
              },
            ),
            SizedBox(height: 30),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitPhotos,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.maingreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  AppLocalizations.of(context)!.updatePhotos,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection({
    required String title,
    required StateProvider<File?> provider,
    required Function(File) onImageSelected,
  }) {
    return Container(
      padding: Pad(all: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Consumer(
            builder: (context, ref, child) {
              final selectedImage = ref.watch(provider);
              return Column(
                children: [
                  if (selectedImage != null)
                    GestureDetector(
                      onTap: () => _showImagePreview(context, selectedImage),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(selectedImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 48,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.noImageSelected,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              _pickImage(ImageSource.camera, onImageSelected),
                          icon: Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                          label: Text(AppLocalizations.of(context)!.camera),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.maingreen,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              _pickImage(ImageSource.gallery, onImageSelected),
                          icon: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                          label: Text(AppLocalizations.of(context)!.gallery),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (selectedImage != null) ...[
                    SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () {
                        ref.read(provider.notifier).state = null;
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                      label: Text(
                        AppLocalizations.of(context)!.remove,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(
      ImageSource source, Function(File) onImageSelected) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        onImageSelected(file);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg:
            '${AppLocalizations.of(context)!.failedToPickImage}: ${e.toString()}',
        backgroundColor: Colors.red,
      );
    }
  }

  void _showImagePreview(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            children: [
              InteractiveViewer(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitPhotos() async {
    // Check if at least one image is selected
    final kantaParchi = ref.read(kantaParchiPhotoProvider);
    final bilty = ref.read(biltyPhotoProvider);
    final loadTruck = ref.read(loadTruckPhotoProvider);
    final truckDriver = ref.read(truckDriverPhotoProvider);
    final quality = ref.read(qualityPhotoProvider);

    if (kantaParchi == null &&
        bilty == null &&
        loadTruck == null &&
        truckDriver == null &&
        quality == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.pleaseSelectAtleastOnePhoto,
        backgroundColor: Colors.orange,
      );
      return;
    }

    try {
      // Show loading
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.uploadingPhotos,
        backgroundColor: ColorConstant.maingreen,
      );

      // Call the API to update photos
      final response = await ref.read(updateDispatchPhotosProvider(
        dispatchRequestId: widget.dispatchRequestId ?? '',
        sbtOrderId: widget.sbtOrderId ?? '',
        kantaParchiPhoto: kantaParchi,
        biltyPhoto: bilty,
        loadTruckPhoto: loadTruck,
        truckDriverPhoto: truckDriver,
        qualityPhoto: quality,
      ).future);

      if (response['status'] == '1') {
        ref.invalidate(dispatchListingNewProvider);

        Fluttertoast.showToast(
          msg: response['message'] ??
              AppLocalizations.of(context)!.photosUpdatedSuccessfully,
          backgroundColor: ColorConstant.maingreen,
        );
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } else {
        Fluttertoast.showToast(
          msg: response['message'] ??
              AppLocalizations.of(context)!.failedToUpdatePhotos,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg:
            '${AppLocalizations.of(context)!.errorUpdatingPhotos}: ${e.toString()}',
        backgroundColor: Colors.red,
      );
    }
  }
}
