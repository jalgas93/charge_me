import 'dart:async';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../share/utils/charge_bottom_sheet.dart';
import '../../../share/utils/location_service.dart';
import '../../dashboard/utils/utils_dashboard.dart';
import '../../home/model/app_lat_long.dart';
import '../../home/model/map_point.dart';
import '../../home/widget/station.dart';
import '../../home/widget/station_other.dart';
import '../widget/search_form_field.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  void dispose() {
    controller.dispose();
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
/*      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        onPressed: () async {
          AppLatLong location = await LocationService().getCurrentLocation();
          _moveToCurrentLocation(location);
        },
        child: const Icon(Icons.map),
      ),*/
      body: LayoutBuilder(
        builder: (context,constraints){
          return Stack(
            children: [
              YandexMap(
                onMapCreated: (controller) async {
                  mapControllerCompleter.complete(controller);
                },
                mapObjects: _getPlacemarkObjects(context),
              ),
              Positioned(
                top: 32,
                right: 16,
                left: 16,
                  child: SearchFormField(
                    controller: controller,
                  )),
              Positioned(
                  top: context.screenSize.height/3,
                  right: 16,
                  child: Column(
                    children: [
                      Container(
                        height: context.screenSize.width / 7,
                        width: context.screenSize.width / 7,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryColor),
                        child: IconButton(
                          onPressed: (){},
                          icon: Image.asset('assets/setting.png'),
                        ),
                      ),
                      16.height,
                      Container(
                        height: context.screenSize.width / 7,
                        width: context.screenSize.width / 7,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryColor),
                        child: IconButton(
                          onPressed: (){},
                          icon: Image.asset('assets/setting.png'),
                        ),
                      ),
                      32.height,
                      Container(
                        height: context.screenSize.width / 7,
                        width: context.screenSize.width / 7,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryColor),
                        child: IconButton(
                          onPressed: (){},
                          icon: Image.asset('assets/setting.png'),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: context.screenSize.width / 7,
                        width: context.screenSize.width / 7,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black),
                        child: IconButton(
                          onPressed: (){},
                          icon: Image.asset('assets/setting.png'),
                        ),
                      ),
                      Container(
                        height: context.screenSize.width / 7,
                        width: context.screenSize.width / 7,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black),
                        child: IconButton(
                          onPressed: (){},
                          icon: Image.asset('assets/setting.png'),
                        ),
                      )
                    ],
                  )),
            ],
          );
        },
      ),
    );
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
/*
  Container(
                          height: context.screenSize.width / 7,
                          width: context.screenSize.width / 7,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryColor),
                          child: IconButton(
                            onPressed: (){},
                            icon: Image.asset('assets/setting.png'),
                          ),
                        )
 */
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
                'assets/item_location.png'
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
}
