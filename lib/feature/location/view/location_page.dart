import 'dart:async';
import 'package:charge_me/feature/location/bloc/location_bloc.dart';
import 'package:charge_me/feature/location/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/logging/log.dart';
import '../../../core/provider/websocket_provider.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../share/utils/charge_bottom_sheet.dart';
import '../../../share/utils/location_service.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/throw_error.dart';
import '../../home/model/app_lat_long.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../widget/booking/search_form_field.dart';
import 'booking_page.dart';
import 'charging_page.dart';
import 'finish_charging.dart';
import 'connector_page.dart';

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

  List<Connector>? connector;


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
                    stationId: station.externalId ?? 'STS_1'));
                await ChargeBottomSheet
                    .draggableScrollableSheet(
                    context: context, children: [
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
                          connectorSuccess: (data) async {
                            Log.i('connectorSuccess listener $data');
                          },
                          bookingSuccess: (data) async {
                            Log.i('bookingSuccess listener $data');
                          },
                          bookingCancelSuccess: (data){
                            Log.i('bookingCancelSuccess listener $data');
                          },
                          chargingSuccess: (data) async {
                            Log.i('chargingSuccess listener $data');
                          },
                          finishSuccess: (data) async {
                            Log.i('finishSuccess listener $data ');
                          },
                          orElse: () {});
                    },
                    builder: (context, WebsocketState state) {
                      return state.maybeWhen(
                          connectorSuccess: (data) {
                            connector = ConnectorList.fromJson(data).payload;
                        return Provider<ConnectorProviderData>(
                          create: (_) => ConnectorProviderData(connector: connector),
                          child: ConnectorPage(
                            station: station,
                          ),
                        );
                      }, bookingSuccess: (data) {
                        return Provider<ConnectorProviderData>(
                          create: (_) => ConnectorProviderData(connector: connector),
                          builder: (context,child){
                            return BookingPage(
                              station: station,
                            );
                          },
                        );
                      }, chargingSuccess: (data) {
                            var response = StartTransaction.fromJson(data).payload;
                        return Provider<ConnectorProviderData>(
                          create: (_) => ConnectorProviderData(connector: connector),
                          builder: (context,child){
                            return ChargingPage(
                              station: station,
                              payloadStartTransaction: response!,
                            );
                          },
                        );
                      }, finishSuccess: (data){
                            var response = StopTransaction.fromJson(data).payload;
                        return Provider<ConnectorProviderData>(
                          create: (_) => ConnectorProviderData(connector: connector),
                          builder: (context,child){
                            return ResultPage(
                              station: station,
                              stopTransaction:response,
                              onTap: (){
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                          },
                          orElse: () {
                        return const SizedBox.shrink();
                      });
                    },
                  )
                ]).then((value){
                  _websocketBloc.add(const WebsocketEvent.disconnectedWebSocket());});
              }),
        )
        .toList();
  }
}