import 'dart:async';
import 'dart:convert';
import 'package:charge_me/feature/location/bloc/location_bloc.dart';
import 'package:charge_me/feature/location/location_repository.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:charge_me/feature/location/widget/booking/success_booking.dart';
import 'package:charge_me/feature/location/widget/filter/filters.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/logging/log.dart';
import '../../../core/network/http/websocket_client.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../share/utils/charge_bottom_sheet.dart';
import '../../../share/utils/constant/config_app.dart';
import '../../../share/utils/location_service.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/throw_error.dart';
import '../../dashboard/utils/utils_dashboard.dart';
import '../../home/model/app_lat_long.dart';
import '../../home/model/map_point.dart';
import '../model/stations.dart';
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
  late LocationBloc _bloc;
  late LocationRepository _repository;
  List<Station>? listStation;
  final WebSocketManager _wsManager = WebSocketManager();

  @override
  void initState() {
    super.initState();
    _repository = LocationRepository();
    _bloc = LocationBloc(repository: _repository);
    _bloc.add(const LocationEvent.started());
    _initPermission().ignore();
  }

  @override
  void dispose() {
    _bloc.close();
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
    const defLocation = AlmataLocation();
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
      body: BlocConsumer<LocationBloc, LocationState>(
        bloc: _bloc,
        listener: (context, LocationState state) {
          state.mapOrNull(
              successLocation: (response) {},
              error: (e) {
                ThrowError.showNotify(context: context, errMessage: "$e");
              });
        },
        builder: (context, state) {
          state.maybeWhen(
              successLocation: (response) {
                print('success');
                listStation = response;
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              orElse: () {});
          return Stack(
            children: [
              YandexMap(
                onMapCreated: (controller) async {
                  mapControllerCompleter.complete(controller);
                },
                mapObjects: _getPlacemarkObjects(context, listStation ?? []),
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
                                /*        Filters(
                              list: list,
                              list2: list2,
                            )*/
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
          );
        },
      ),
    );
  }

  /// Метод для генерации объектов маркеров для отображения на карте
  List<PlacemarkMapObject> _getPlacemarkObjects(
      BuildContext context, List<Station> list) {
    return list
        .map(
          (point) => PlacemarkMapObject(
              mapId: MapObjectId('MapObject $point'),
              point: Point(
                  latitude: point.location!.latitude!,
                  longitude: point.location!.longitude!),
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image:
                      BitmapDescriptor.fromAssetImage('assets/location_1.png'),
                  scale: 2,
                ),
              ),
              onTap: (_, __) async {
                print("externalId ${point.externalId}");
                var result =
                    _wsManager.connect(stationId: point.externalId ?? '');
                await result.then((value) {
                  WebSocketManager().transmit(
                    jsonEncode({
                      "action": "StatusNotification",
                      "messageId": "123",
                      "payload": {
                        "status": "Charging",
                        "timestamp": "2025-03-27T22:07:09",
                        "chargerId": "STS_001",
                        "energyConsumed": 0
                      }
                    }),
                  );
                });
                if(context.mounted){
                  await ChargeBottomSheet.draggableScrollableSheet(
                      context: context,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: UtilsLocation.processChargingUp,
                            builder: (context, value, child) {
                              switch (value) {
                                case BookingStation.initialBooking:
                                  return InitialBooking(
                                    stream: _wsManager.stream,
                                    station: point,
                                  );
                                case BookingStation.successBooking:
                                  return const SuccessBooking();
                                case BookingStation.successChargingUp:
                                  return const SuccessChargingUp();
                                case BookingStation.finishCharging:
                                  return const FinishCharging();
                              }
                            })
                      ]).then((value) {
                    WebSocketManager().disconnect();
                  });
                }
              }),
        )
        .toList();
  }
}
