import 'dart:async';
import 'dart:ui';

import 'package:charge_me/modules/app_common/utils/charge_bottom_sheet.dart';
import 'package:charge_me/modules/dashboard/utils/utils_dashboard.dart';
import 'package:charge_me/modules/home/widget/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../app_common/utils/location_service.dart';
import '../model/app_lat_long.dart';
import '../model/map_point.dart';
import '../widget/station_other.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mapControllerCompleter = Completer<YandexMapController>();

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = MetroLocation();
    try {
      //  location = await LocationService().getCurrentLocation();
      location = const AppLatLong(lat: 41.326928, long: 69.327526);
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        onPressed: () async {
          AppLatLong location = await LocationService().getCurrentLocation();
          _moveToCurrentLocation(location);
        },
        child: const Icon(Icons.map),
      ),
      body: YandexMap(
        onMapCreated: (controller) async {
          mapControllerCompleter.complete(controller);
        },
        mapObjects: _getPlacemarkObjects(context),
      ),
    );
  }
}

/// Метод для генерации точек на карте
List<MapPoint> _getMapPoints() {
  return const [
    MapPoint(name: 'jalgas1', latitude: 41.326680, longitude: 69.327475),
    MapPoint(name: 'jalgas2', latitude: 41.327567, longitude: 69.326915),
    MapPoint(name: 'jalgas3', latitude: 41.326836, longitude: 69.326400),
    MapPoint(name: 'jalgas4', latitude: 41.327110, longitude: 69.328197),
  ];
}

/// Метод для генерации объектов маркеров для отображения на карте
List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
  return _getMapPoints()
      .map(
        (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject $point'),
            point: Point(latitude: point.latitude, longitude: point.longitude),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'assets/map_point.png',
                ),
                scale: 2,
              ),
            ),
            onTap: (_, __) async {
              await ChargeBottomSheet.draggableScrollableSheet(
                  context: context,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: UtilsDashboard.change,
                        builder: (context, value, child) {
                          return value ? const StationOther() : const Station();
                        })
                  ]);
            }),
      )
      .toList();
}
