import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  bool _isFetching = false;
  String? _error;

  Position? get currentPosition => _currentPosition;
  bool get isFetching => _isFetching;
  String? get error => _error;

  Future<void> fetchCurrentLocation() async {
    _isFetching = true;
    _error = null;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _error = 'Location services are disabled.';
        _isFetching = false;
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = 'Location permissions are denied';
          _isFetching = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = 'Location permissions are permanently denied';
        _isFetching = false;
        notifyListeners();
        return;
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}