import 'dart:async';
import 'dart:convert';
import 'package:charge_me/feature/location/bloc/location_bloc.dart';
import 'package:charge_me/feature/location/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/logging/log.dart';
import '../../../core/network/http/websocket_client.dart';
import '../../../core/network/http/websocket_new.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../share/utils/charge_bottom_sheet.dart';
import '../../../share/utils/location_service.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/throw_error.dart';
import '../../home/model/app_lat_long.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/search_form_field.dart';
import 'booking_page.dart';
import 'charging_page.dart';
import 'initial_page.dart';

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
  late WebsocketBloc _websocketBloc;
  late WebSocketService _webSocketService;
  List<Station>? listStation;
  final WebSocketManager _wsManager = WebSocketManager();
  List<Connector>? connector;

  @override
  void initState() {
    super.initState();
    _repository = LocationRepository();
    _webSocketService = WebSocketService();
    _bloc = LocationBloc(repository: _repository);
    //_websocketBloc = WebsocketBloc(webSocketService: _webSocketService);
    _websocketBloc = BlocProvider.of<WebsocketBloc>(context);
    _bloc.add(const LocationEvent.started());
    _initPermission().ignore();
  }

  @override
  void dispose() {
    _bloc.close();
    //_websocketBloc.close();
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
      location = const AppLatLong(lat: 41.300439, long: 69.268644);
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

  WebsocketBloc get websocketBloc => BlocProvider.of<WebsocketBloc>(context);

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
                          /*           await ChargeBottomSheet.draggableScrollableSheet(
                              context: context,
                              children: [
                                */ /*        Filters(
                              list: list,
                              list2: list2,
                            )*/ /*
                              ]);*/
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
          (station) => PlacemarkMapObject(
              mapId: MapObjectId('MapObject $station'),
              point: Point(
                  latitude: station.location!.latitude!,
                  longitude: station.location!.longitude!),
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image:
                      BitmapDescriptor.fromAssetImage('assets/location_1.png'),
                  scale: 2,
                ),
              ),
              onTap: (_, __) async {
                _websocketBloc.add(WebsocketEvent.connect(
                    stationId: station.externalId ?? ''));
                _websocketBloc.add(WebsocketEvent.sendWebSocketMessage(
                    message: jsonEncode({"action": "Connector"})));
                await ChargeBottomSheet
                    .draggableScrollableSheet(context: context, children: [
                  BlocConsumer<WebsocketBloc, WebsocketState>(
                    bloc: _websocketBloc,
                    listener: (context, WebsocketState state) {
                      state.maybeWhen(
                          errorWebSocket: (error) {
                            ThrowError.showMessage(
                                errMessage: error.toString(), context: context);
                          },
                          disconnectWebSocket: () {
                            ThrowError.showMessage(
                                errMessage: 'Disconnected', context: context);
                          },
                          connectWebSocket: () async {
                            Log.i('connectWebSocket');
                          },
                          receivedWebSocketMessage: (data) async {
                            connector = ConnectorList.fromJson(data).payload;
                            Log.i('receivedWebSocketMessage litener');
                          },
                          orElse: () {});
                    },
                    builder: (context, WebsocketState state) {
                      return state.maybeWhen(connectWebSocket: () {
                        Log.i('connectWebSocket');
                        return Container(
                          height: 500,
                          color: Colors.white,
                        );
                      }, disconnectWebSocket: () {
                        return Container(
                          height: 500,
                          color: Colors.grey,
                        );
                      }, receivedWebSocketMessage: (data) {
                        return InitialPage(
                          connector: connector!,
                          station: station,
                          onTap: () async {
                            _websocketBloc.add(const WebsocketEvent.booking());
                            /*        UtilsLocation.setChargingUp =
                                    BookingStation.booking;
                                await WebSocketManager().transmit(
                                    jsonEncode({"action": "Connector"}));*/
                            // await WebSocketManager()
                            //     .transmit(jsonEncode({"action": "StartBooking"}));
                          },
                        );
                      }, bookingSuccess: () {
                        return BookingPage(
                          station: station,
                          connector: connector!,
                          onTapCancel: () async {
                            UtilsLocation.setChargingUp =
                                BookingStation.connect;
                            /*         await WebSocketManager()
                                                .transmit(jsonEncode({"action": "StopBooking"}));*/
                          },
                          onTapCharging: () async {
                            _websocketBloc.add(const WebsocketEvent.charging());
                            /*     UtilsLocation.setChargingUp =
                                    BookingStation.charging;*/
                            /*         await WebSocketManager()
                                                .transmit(jsonEncode({"action": "StartTransaction"}));*/
                          },
                        );
                      }, chargingSuccess: () {
                        return ChargingPage(
                          station: station,
                          connector: connector!,
                          onTapFinish: () async {
                            UtilsLocation.setChargingUp = BookingStation.finish;
                          },
                        );
                      }, orElse: () {
                        return Container(
                          height: 500,
                          color: Colors.yellow,
                        );
                      });
                    },
                  )
                ]);
              }),
        )
        .toList();
  }
}

/*

            _wsManager.connect(stationId: station.externalId ?? '').then((value)async{
                  await WebSocketManager()
                      .transmit(jsonEncode({"action": "Connector"}));
                });
                if (context.mounted) {
                  await ChargeBottomSheet.draggableScrollableSheet(context: context, children: [
                    StreamBuilder(
                      stream: _wsManager.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Waiting for the stream
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}"); // Show error message
                        } else if (snapshot.hasData) {
                          Log.i("snapshot data ${snapshot.data}");
                          if (ConnectorList.fromJson(snapshot.data).action ==
                              "Connector") {
                           var connector = ConnectorList.fromJson(snapshot.data).payload;
                             return ValueListenableBuilder(
                                  valueListenable:
                                  UtilsLocation.processChargingUp,
                                  builder: (context, value, child) {
                                    switch (value) {
                                      case BookingStation.connect:
                                        return InitialPage(
                                          connector: connector!,
                                          station: station,
                                          onTap: () async{
                                            UtilsLocation.setChargingUp =
                                                BookingStation.booking;
                                            await WebSocketManager()
                                                .transmit(jsonEncode({"action": "Connector"}));
                                            // await WebSocketManager()
                                            //     .transmit(jsonEncode({"action": "StartBooking"}));
                                          },
                                        );
                                      case BookingStation.booking:
                                        return BookingPage(
                                          station: station,
                                          connector: connector!,
                                          onTapCancel: ()async {
                                            UtilsLocation.setChargingUp =
                                                BookingStation.connect;
                                   /*         await WebSocketManager()
                                                .transmit(jsonEncode({"action": "StopBooking"}));*/
                                          },
                                          onTapCharging: () async{
                                            UtilsLocation.setChargingUp =
                                                BookingStation.charging;
                                   /*         await WebSocketManager()
                                                .transmit(jsonEncode({"action": "StartTransaction"}));*/
                                          },
                                        );
                                      case BookingStation.charging:
                                        return ChargingPage(
                                          station: station,
                                          connector: connector!,
                                          onTapFinish: () async{
                                            UtilsLocation.setChargingUp =
                                                BookingStation.finish;
                                          },
                                        );
                                      case BookingStation.finish:
                                        return ResultPage(
                                          station: station,
                                          connector: connector!,
                                        );
                                      default:
                                        return const SizedBox.shrink();
                                    }
                                  });

                          }// Show the latest value
                        } else {
                          return const Text("No data available"); // Handle any other cases
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ]).then((value) {
                    WebSocketManager().disconnect();
                  });
                }
 */
