import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/find_my_tm/model/tm_model.dart';
import 'package:apnagodam/presentation/find_my_tm/provider/find_my_tm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Rajasthan, India state centroid — the map opens centered here.
const LatLng _rajasthanCenter = LatLng(27.0238, 74.2179);
const double _defaultZoom = 6.2;
const double _focusZoom = 12;

class FindMyTmScreen extends ConsumerStatefulWidget {
  const FindMyTmScreen({super.key});

  @override
  ConsumerState<FindMyTmScreen> createState() => _FindMyTmScreenState();
}

class _FindMyTmScreenState extends ConsumerState<FindMyTmScreen> {
  final _searchController = TextEditingController();
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _focusOnTm(TmModel tm) async {
    ref.read(selectedTmProvider.notifier).state = tm;
    final controller = _mapController;
    if (controller == null) return;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(tm.latitude, tm.longitude),
          zoom: _focusZoom,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tmListAsync = ref.watch(tmListProvider);
    final filteredAsync = ref.watch(filteredTmListProvider);
    final selectedTm = ref.watch(selectedTmProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.findMyTm),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) =>
                  ref.read(tmSearchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchTmByName,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(tmSearchQueryProvider.notifier).state = '';
                          setState(() {});
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onSubmitted: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: tmListAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text(
                  AppLocalizations.of(context)!.somethingWentWrong,
                ),
              ),
              data: (allTms) {
                final markers = allTms.map((tm) {
                  final isSelected = selectedTm?.id == tm.id;
                  return Marker(
                    markerId: MarkerId(tm.id),
                    position: LatLng(tm.latitude, tm.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      isSelected
                          ? BitmapDescriptor.hueGreen
                          : BitmapDescriptor.hueRed,
                    ),
                    infoWindow: InfoWindow(
                      title: tm.name,
                      snippet:
                          '${tm.city} • ${tm.phone} • ${tm.coverageRadiusKm.toStringAsFixed(0)} km coverage',
                    ),
                    onTap: () => _focusOnTm(tm),
                  );
                }).toSet();

                final circles = allTms.map((tm) {
                  final isSelected = selectedTm?.id == tm.id;
                  return Circle(
                    circleId: CircleId(tm.id),
                    center: LatLng(tm.latitude, tm.longitude),
                    radius: tm.coverageRadiusKm * 1000,
                    strokeWidth: isSelected ? 3 : 1,
                    strokeColor: isSelected
                        ? ColorConstant.maingreen
                        : ColorConstant.maingreen.withValues(alpha: 0.5),
                    fillColor: isSelected
                        ? ColorConstant.maingreen.withValues(alpha: 0.18)
                        : ColorConstant.maingreen.withValues(alpha: 0.06),
                    consumeTapEvents: true,
                    onTap: () => _focusOnTm(tm),
                  );
                }).toSet();

                return Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: _rajasthanCenter,
                        zoom: _defaultZoom,
                      ),
                      markers: markers,
                      circles: circles,
                      myLocationButtonEnabled: false,
                      onMapCreated: (controller) =>
                          _mapController = controller,
                    ),
                    filteredAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (filtered) {
                        final query =
                            ref.watch(tmSearchQueryProvider).trim();
                        if (query.isEmpty) return const SizedBox.shrink();
                        return Positioned(
                          top: 0,
                          left: 16,
                          right: 16,
                          child: _TmSearchResults(
                            results: filtered,
                            onSelect: (tm) {
                              _searchController.text = tm.name;
                              _focusOnTm(tm);
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TmSearchResults extends StatelessWidget {
  final List<TmModel> results;
  final ValueChanged<TmModel> onSelect;

  const _TmSearchResults({required this.results, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 260),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: results.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalizations.of(context)!.noTmFound,
                style: const TextStyle(color: Colors.grey),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: results.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tm = results[index];
                return ListTile(
                  dense: true,
                  leading: Icon(Icons.location_on, color: ColorConstant.maingreen),
                  title: Text(tm.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    '${tm.city} • ${tm.coverageRadiusKm.toStringAsFixed(0)} km coverage',
                  ),
                  onTap: () => onSelect(tm),
                );
              },
            ),
    );
  }
}
