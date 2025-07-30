import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/feature/location/bloc/location_bloc.dart';
import 'package:charge_me/feature/location/location_repository.dart';
import 'package:charge_me/feature/location/widget/booking/button_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/helpers/app_user.dart';
import '../../../core/logging/log.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../_app/utils/charge_bottom_sheet.dart';
import '../../_app/utils/location_service.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../_app/widgets/throw_error.dart';
import '../../home/model/app_lat_long.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/item_title.dart';
import '../widget/search_form_field.dart';
import '../widget/connector/connectors.dart';

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
  List<Station>? listStation;

  List<Connector>? connectors;
  Connector? connector;
  PayloadStartTransaction? payloadStartTransaction;
  Transaction? transaction;
  CheckResponse? checkResponse;
  int? indexContainer;
  var text;

  @override
  void initState() {
    super.initState();
    _repository = LocationRepository();
    _bloc = LocationBloc(repository: _repository);
    _websocketBloc = BlocProvider.of<WebsocketBloc>(context);
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
            },
          );
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
                        onPressed: () async {},
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
                    stationId: station.externalId ?? 'STS_1'));
                await ChargeBottomSheet
                    .draggableScrollableSheet(context: context, children: [
                  BlocConsumer<WebsocketBloc, WebsocketState>(
                    bloc: _websocketBloc,
                    listener: (context, WebsocketState state) {
                      state.maybeWhen(
                          errorWebSocket: (error) {
                            ThrowError.showNotify(
                                errMessage: error.toString(), context: context);
                          },
                          disconnectWebSocket: () {
                            ThrowError.showMessage(
                                errMessage: 'Disconnected', context: context);
                          },
                          connectorSuccess: (data) async {
                            Log.i('connectorSuccess listener $data');
                            print('userId ${AppUser.userModel?.userId}');
                            connectors = ConnectorList.fromJson(data).payload;
                          },
                          bookingSuccess: (data) async {
                            Log.i('bookingSuccess listener $data');
                            context.router.push(BookingRoutePage(
                              connector: connector,
                              station: station,
                              active: checkResponse?.check?.active,
                            ));
                          },
                          queueSuccess: (data) {
                            Log.i('queueSuccess listener $data');
                            checkResponse = CheckResponse.fromJson(data);
                          },
                          checkSuccess: (data) {
                            Log.i('checkSuccess listener $data');
                            checkResponse = CheckResponse.fromJson(data);
                          },
                          chargingSuccess: (data) async {
                            Log.i('chargingSuccess listener $data');
                            var payloadStartTransaction =
                                StartTransaction.fromJson(data).payload;
                            context.router.replace(
                                ChargingRoutePage(
                              payloadStartTransaction: payloadStartTransaction!,
                              station: station,
                              connector: connector,
                            ));
                          },
                          finishSuccess: (data) async {
                            Log.i('finishSuccess listener $data ');
                            var stopTransaction =
                                StopTransaction.fromJson(data).payload;
                            context.router.replace(FinishRoutePage(
                              station: station,
                              stopTransaction: stopTransaction,
                              connector: connector,
                            ));
                          },
                          orElse: () {});
                    },
                    builder: (context, WebsocketState state) {
                      final isLoading = state == const WebsocketState.loadingWebSocket();
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ItemTitle(
                                  title: '${station.location?.city}',
                                  description: '${station.location?.address}',
                                  descriptionSupplement:
                                      'Время работы с 00:00 - 24:00',
                                  stationId: '${station.externalId}',
                                  connector: connector,
                                ),
                                8.height,
                                const Divider(),
                                8.height,
                                Text(
                                  'Типы зарядных устройств',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                8.height,
                                if (connectors != null)
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    height: constraints.maxWidth / 2.5,
                                    child: ListView.separated(
                                      itemCount: connectors!.length,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            connector = connectors?[index];
                                            text = text == connectors?[index].type
                                                ? 'CCS2'
                                                : connectors?[index].type;
                                            websocketBloc
                                                .add(WebsocketEvent.check(
                                              message: jsonEncode({
                                                "action": "Check",
                                                "messageId": "check",
                                                "payload": {
                                                  "message": "check",
                                                  "userId":
                                                      AppUser.userModel?.userId,
                                                  "connectorId":
                                                      "${connector?.connectorId}"
                                                }
                                              }),
                                            ));
                                          },
                                          child: ConnectorPage(
                                            connector: connectors![index],
                                            text: text,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, int index) {
                                        return const SizedBox(width: 8);
                                      },
                                    ),
                                  ),
                                ButtonContainer(
                                  isLoading: isLoading,
                                  connector: connector,
                                  station: station,
                                  queue: checkResponse?.check?.queue,
                                  active: checkResponse?.check?.active,
                                ),
                                16.height
                              ],
                            );
                          },
                        ),
                      );
                    },
                  )
                ]).then((value) {
                  connector ==null;
                });
              }),
        )
        .toList();
  }
}
