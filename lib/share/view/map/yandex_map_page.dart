import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../feature/home/model/app_lat_long.dart';
import '../../../feature/home/model/map_point.dart';
import '../../utils/location_service.dart';
import '../../widgets/app_bar_container.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/item_app_bar.dart';

@RoutePage(name: "YandexMapPageRoute")
class YandexMapPage extends StatefulWidget {
  const YandexMapPage({super.key});

  @override
  State<YandexMapPage> createState() => _YandexMapPageState();
}

class _YandexMapPageState extends State<YandexMapPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> _mapObjects = [];

  // Координаты маркера (Москва)
  final Point _targetPoint = Point(
    latitude: 41.183600,
    longitude: 69.164800,
  );

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
      location = await LocationService().getCurrentLocation();
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

  /// Метод для генерации точек на карте
  List<MapPoint> _getMapPoints() {
    return const [
      MapPoint(name: 'jalgas1', latitude: 41.326680, longitude: 69.327475),

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
            direction: 90,
            isDraggable: true,
            onDragStart: (_) => print('Drag start'),
            onDrag: (_, Point point) =>
                print('Drag at point $point'),
            onDragEnd: (_) => print('Drag end'),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    'assets/location_1.png'),
                scale: 1.5,
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
              onMapCreated: (controller) async {
                mapControllerCompleter.complete(controller);
              },
              mapObjects: _getPlacemarkObjects(context)),
          Positioned(
            left: 16,
            top: 36,
            child: ItemAppBar(
              icon: 'assets/back.png',
              color: AppColorsDark.black,
              colorIcon: AppColorsDark.white,
              onPressed: () {
                context.router.popForced();
              },
            ),
          ),
          Positioned(
            right: 16,
            bottom: context.screenSize.width / 1.5,
            child: ItemAppBar(
              icon: 'assets/gps.png',
              color: AppColorsDark.black,
              colorIcon: AppColorsDark.white,
              onPressed: () async {
                AppLatLong location =
                    await LocationService().getCurrentLocation();
                _moveToCurrentLocation(location);
              },
            ),
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: context.screenSize.width / 4,
            child: Container(
              height: context.screenSize.width / 2.5,
              width: context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                  color: AppColorsDark.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Информация о местоположении',
                      style: context.textTheme.titleSmall
                          ?.copyWith(color: AppColorsDark.darkStyleText)),
                  16.height,
                  Row(
                    children: [
                      const ItemAppBar(
                        color: AppColorsDark.whiteSecondary,
                        icon: 'assets/icon_pin.png',
                      ),
                      16.width,
                      Flexible(
                        child: Text(
                          'Jl. Cisangkuy, Citarum, Kec. Bandung Wetan, Kota Bandung, Jawa Barat 40115',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: AppColorsDark.darkStyleText),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Align(
              alignment: Alignment.center,
              child: CustomButton(
                  width: context.screenSize.width / 1.2,
                  onTap: () {
                    context.router.push(const AccountSetupLocationRoutePage());
                  },
                  text: 'Добавить местоположение'),
            ),
          )
        ],
      ),
    );
  }
}
