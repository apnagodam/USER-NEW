import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/Bookwarehousescreen.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/constants.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Findwarehousescreen extends ConsumerStatefulWidget {
  Findwarehousescreen({super.key, this.isAppBarVisible});
  bool? isAppBarVisible = false;
  @override
  ConsumerState<Findwarehousescreen> createState() =>
      _FindwarehousescreenState();
}

class _FindwarehousescreenState extends ConsumerState<Findwarehousescreen>
    with TickerProviderStateMixin {
  Position? userPosition;
  LocationPermission? locationPermission;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  double? _selectedDistance; // km filter

  final List<double?> _distanceOptions = [null, 100, 300, 500];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }

    if (locationPermission == LocationPermission.deniedForever ||
        locationPermission == LocationPermission.denied) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      userPosition = position;
    });
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371; // km
    double dLat = _deg2rad(lat2 - lat1);
    double dLon = _deg2rad(lon2 - lon1);
    double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) => deg * (pi / 180);

  List<dynamic> _filterTerminals(List<dynamic>? terminals) {
    if (terminals == null) return [];

    List<dynamic> filtered = List.from(terminals);

    if (_searchQuery.isNotEmpty) {
      filtered =
          filtered.where((terminal) {
            final name = terminal.name?.toString().toLowerCase() ?? "";
            final address = terminal.address?.toString().toLowerCase() ?? "";
            return name.contains(_searchQuery) ||
                address.contains(_searchQuery);
          }).toList();
    }

    if (_selectedDistance != null && userPosition != null) {
      filtered =
          filtered.where((terminal) {
            final dist = _calculateDistance(
              userPosition!.latitude,
              userPosition!.longitude,
              num.parse("${terminal.latitude ?? 0.0}").toDouble(),
              num.parse("${terminal.longitude ?? 0.0}").toDouble(),
            );
            return dist <= _selectedDistance!;
          }).toList();
    }

    return filtered;
  }

  Widget _highlightText(
    String text, {
    TextStyle style = const TextStyle(color: Colors.black),
  }) {
    if (_searchQuery.isEmpty) return Text(text, style: style);

    final lowerText = text.toLowerCase();
    final query = _searchQuery.toLowerCase();
    final startIndex = lowerText.indexOf(query);

    if (startIndex == -1) return Text(text, style: style);

    final endIndex = startIndex + query.length;

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: text.substring(0, startIndex)),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: style.copyWith(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: text.substring(endIndex)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          widget.isAppBarVisible == true
              ? AppBar(
                title: Text(AppLocalizations.of(context)!.findWarehouses),
                backgroundColor: ColorConstant.maingreen,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFF12281B), // Deep green-black
                        Color(0xFF275135), // Your main green
                        Color(0xFF3E7251),
                      ],
                    ),
                  ),
                ),
              )
              : null,
      body: ref
          .watch(warehouseDataProvider)
          .when(
            data: (whData) {
              final finalList = _filterTerminals(whData.terminals);

              return ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.maingreen,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFF12281B), // Deep green-black
                          Color(0xFF275135), // Your main green
                          Color(0xFF3E7251),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.search,
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        // Filter Chips with Animation
                        SizedBox(
                          height: 45,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            itemCount: _distanceOptions.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final dist = _distanceOptions[index];
                              final isSelected = _selectedDistance == dist;
                              return GestureDetector(
                                onTap: () {
                                  setState(() => _selectedDistance = dist);
                                },
                                child: AnimatedScale(
                                  scale: isSelected ? 1.1 : 1.0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOutBack,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient:
                                          isSelected
                                              ? LinearGradient(
                                                colors: [
                                                  Colors.amber.shade500,
                                                  Colors.amber.shade500
                                                      .withOpacity(0.85),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                              : const LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ],
                                              ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: ColorConstant.maingreen,
                                        width: 1.5,
                                      ),
                                      boxShadow:
                                          isSelected
                                              ? [
                                                BoxShadow(
                                                  color: ColorConstant.maingreen
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]
                                              : [],
                                    ),
                                    child: Text(
                                      dist == null
                                          ? 'All'
                                          : 'Nearby ${dist.toInt()} km',
                                      style: TextStyle(
                                        fontWeight:
                                            isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  finalList.isEmpty
                      ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.nowarehousesfound,
                        ),
                      )
                      : ListView.builder(
                        padding: const Pad(all: 0),
                        itemCount: finalList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final terminal = finalList[index];
                          return TweenAnimationBuilder(
                            duration: Duration(
                              milliseconds: 300 + (index * 50),
                            ),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder:
                                (context, value, child) => Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, (1 - value) * 20),
                                    child: child,
                                  ),
                                ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(12),
                              child: Card(
                                elevation: 5,
                                margin: Pad(all: 10),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // Image with fixed height
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Container(
                                              width: Get.width * 0.3,
                                              height: 120,
                                              color: Colors.grey[200],
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${BASEURL}resources/assets/upload/warehouses/${terminal.image}",
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, _, __) =>
                                                        const Icon(
                                                          Icons.warehouse,
                                                          size: 40,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),

                                          // Text
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  terminal.name ?? '',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(17),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                _highlightText(
                                                  "${terminal.address ?? ''}",
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color:
                                                          ColorConstant
                                                              .maingreen,
                                                      size: Adaptive.sp(16),
                                                    ),
                                                    titleWidget(
                                                      text:
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.locateOnMap,
                                                      callback: () {
                                                        MapsLauncher.launchQuery(
                                                          "${terminal?.address ?? ""}",
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Text.rich(
                                                  TextSpan(
                                                    text:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.capacity,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${terminal.capacityInMt} MT",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevarmDivider(),
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: SizedBox(
                                        width: Get.width,
                                        child: simpleButton(
                                          text:
                                              AppLocalizations.of(
                                                context,
                                              )!.msgBook,
                                          callback: () {
                                            if (ref
                                                    .watch(
                                                      authProvider.notifier,
                                                    )
                                                    .loginStatus ==
                                                AuthStatus.loggedIn) {
                                              Get.to(
                                                Bookwarehousescreen(
                                                  terminal: terminal,
                                                  commdity: whData.commodites,
                                                ),
                                              );
                                            } else {
                                              showLoginBottomsheet(context);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                ],
              );
            },
            error:
                (e, s) => const Center(child: Text("Error loading warehouses")),
            loading: () => _loader(),
          ),
    );
  }

  _loader() => Skeletonizer(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        // Filter Chips with Animation
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            itemCount: _distanceOptions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 5),
            itemBuilder: (context, index) {
              final dist = _distanceOptions[index];
              final isSelected = _selectedDistance == dist;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedDistance = dist);
                },
                child: AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorConstant.maingreen,
                        width: 1.5,
                      ),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: ColorConstant.maingreen.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                              : [],
                    ),
                    child: Text(
                      dist == null ? 'All' : 'Nearby ${dist.toInt()} km',
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected
                                ? ColorConstant.maingreen
                                : Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder:
              (context, index) => ListTile(
                title: Text(AppLocalizations.of(context)!.loading),
                leading: Icon(Icons.warehouse),
                subtitle: Text(AppLocalizations.of(context)!.loading),
                trailing: Text(AppLocalizations.of(context)!.loading),
              ),
        ),
      ],
    ),
  );
}
