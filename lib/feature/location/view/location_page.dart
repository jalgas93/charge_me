import 'dart:async';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:charge_me/feature/location/widget/booking/success_booking.dart';
import 'package:charge_me/feature/location/widget/filter/filters.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/utils/charge_bottom_sheet.dart';
import '../../../share/utils/location_service.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../dashboard/utils/utils_dashboard.dart';
import '../../home/model/app_lat_long.dart';
import '../../home/model/map_point.dart';
import '../widget/booking/finish_charging.dart';
import '../widget/booking/initial_booking.dart';
import '../widget/booking/search_form_field.dart';
import '../widget/booking/success_charging_up.dart';

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

  List<String> list = [
    'CHAdeMo',
    'CCS 1',
    'CCS 2',
    'Combo 1',
    'Combo 2',
    'GB/T',
    'Type 1',
    'Type 2',
    'J1772 Type 1',
    'Tesla'
  ];
  List<int> list2 = [
    150,
    200,
    250,
    300,
    350,
    400,
    450,
    500,
    550,
    600,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) async {
              mapControllerCompleter.complete(controller);
            },
            mapObjects: _getPlacemarkObjects(context),
          ),
          Positioned(
              top: 32,
              left: 16,
              right: 16,
              child: SearchFormField(
                controller: controller,
              )),
          Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ItemAppBar(
                    icon: 'assets/filter.png',
                    color: AppColorsDark.black,
                    colorIcon: AppColorsDark.white,
                    onPressed: () async {
                      await ChargeBottomSheet.draggableScrollableSheet(
                          context: context,
                          children: [
                            Filters(
                              list: list,
                              list2: list2,
                            )
                          ]);
                    },
                  ),
                  ItemAppBar(
                    icon: 'assets/gps.png',
                    color: AppColorsDark.black,
                    colorIcon: AppColorsDark.white,
                    onPressed: () async {
                      AppLatLong location =
                          await LocationService().getCurrentLocation();
                      _moveToCurrentLocation(location);
                    },
                  ),
                ],
              )),
        ],
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

  /// Метод для генерации объектов маркеров для отображения на карте
  List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
    return _getMapPoints()
        .map(
          (point) => PlacemarkMapObject(
              mapId: MapObjectId('MapObject $point'),
              point:
                  Point(latitude: point.latitude, longitude: point.longitude),
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                      'assets/energy_station_2.png'),
                  scale: 2,
                ),
              ),
              onTap: (_, __) async {
                await ChargeBottomSheet.draggableScrollableSheet(
                    context: context,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: UtilsLocation.processChargingUp,
                          builder: (context, value, child) {
                            switch(value){
                              case BookingStation.initialBooking:
                                return InitialBooking(listConnectors: list);
                              case BookingStation.successBooking:
                                return const SuccessBooking();
                              case BookingStation.successChargingUp:
                                return const SuccessChargingUp();
                              case BookingStation.finishCharging:
                                return const FinishCharging();
                            }
                          })
                    ]);
              }),
        )
        .toList();
  }
}
