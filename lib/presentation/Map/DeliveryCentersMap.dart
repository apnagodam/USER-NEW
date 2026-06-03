import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customMarkerProvider =
    FutureProvider.family<BitmapDescriptor, Map<String, dynamic>>(
        (ref, data) async {
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final size = Size(150, 150); // Adjusted size for circular markers

  // Draw a circular background with a white border
  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), size.width / 2, paint);

  final innerCirclePaint = Paint()
    ..color = Colors.blueAccent // Inner circle color
    ..style = PaintingStyle.fill;
  canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2 - 5,
      innerCirclePaint); // Inner circle with padding

  // Use default values if `text` or `imageUrl` are not provided
  final imageUrl = data['imageUrl'] ?? 'https://via.placeholder.com/150';

  // Draw the image
  // Adjusted image rendering to ensure it fits within the circular marker
  final image = NetworkImage(imageUrl).resolve(ImageConfiguration());
  final completer = Completer<ui.Image>();
  image.addListener(
    ImageStreamListener(
      (ImageInfo info, bool _) {
        completer.complete(info.image);
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        completer.completeError(error, stackTrace);
      },
    ),
  );
  final uiImage = await completer.future;

  // Draw a pin below the circular marker
  final pinPaint = Paint()
    ..color = Colors.blueAccent
    ..style = PaintingStyle.fill;
  final pinPath = Path()
    ..moveTo(
        size.width / 2, size.height) // Start at the bottom center of the circle
    ..lineTo((size.width / 2) - 10, size.height + 20) // Left point of the pin
    ..lineTo((size.width / 2) + 10, size.height + 20) // Right point of the pin
    ..close();
  canvas.drawPath(pinPath, pinPaint);

  // Draw the circular marker
  canvas.drawCircle(
    Offset(size.width / 2, size.height / 2),
    size.width / 2,
    Paint()..color = Colors.white,
  );

  // Clip the image to a circle
  final clipPath = Path()
    ..addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - 5,
    ));

  canvas.save();
  canvas.clipPath(clipPath);
  canvas.drawImageRect(
    uiImage,
    Rect.fromLTWH(0, 0, uiImage.width.toDouble(), uiImage.height.toDouble()),
    Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 5),
    Paint(),
  );
  canvas.restore();

  final picture = pictureRecorder.endRecording();
  final imageBytes =
      await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await imageBytes.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
});

class DeliveryCentersMap extends ConsumerWidget {
  final List<Map<String, dynamic>> markersData;

  const DeliveryCentersMap({super.key, required this.markersData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Centers Map'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        trafficEnabled: true,
        indoorViewEnabled: true,
        mapType: MapType
            .normal, // Set to hybrid to show labels with satellite imagery
        initialCameraPosition: CameraPosition(
          target: markersData.isNotEmpty
              ? markersData.first['location']
              : LatLng(0, 0), // Default position if no locations
          zoom: 10,
        ),
        markers: markersData.map((data) {
          final customMarkerAsync = ref.watch(customMarkerProvider(data));

          return customMarkerAsync.when(
            data: (customMarker) => Marker(
              markerId: MarkerId(data['location'].toString()),
              position: data['location'],
              icon: customMarker,
              infoWindow: InfoWindow(
                title: data['text'] ?? 'No Title',
                snippet: 'Tap for more details',
                onTap: () {
                  // Perform an action when the info window is tapped
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Details for: ${data['text'] ?? 'Unknown'}')),
                  );
                },
              ),
            ),
            loading: () => Marker(
              markerId: MarkerId(data['location'].toString()),
              position: data['location'],
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
            error: (err, stack) => Marker(
              markerId: MarkerId(data['location'].toString()),
              position: data['location'],
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          );
        }).toSet(),
      ),
    );
  }
}
