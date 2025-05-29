import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/logging/log.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../home/model/app_lat_long.dart';
import '../../home/model/map_point.dart';
import '../../../share/utils/location_service.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../account_repository.dart';
import '../bloc/account_setup_bloc.dart';
import '../widget/address_info.dart';

@RoutePage(name: "YandexMapPageRoute")
class YandexMapPage extends StatefulWidget {
  const YandexMapPage({super.key});

  @override
  State<YandexMapPage> createState() => _YandexMapPageState();
}

class _YandexMapPageState extends State<YandexMapPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  late AccountSetupBloc _bloc;
  late AccountSetupRepository _repository;
  CameraPosition? _userLocation;
  String address = 'null';

  @override
  void initState() {
    super.initState();
    _repository = AccountSetupRepository();
    _bloc = AccountSetupBloc(repository: _repository);
    _bloc.add(const AccountSetupEvent.geocode());
    _initPermission().ignore();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void submit() async {
    _bloc.add(const AccountSetupEvent.geocode());
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
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong,) async {
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
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) async {
              mapControllerCompleter.complete(controller);
            },
            onMapTap: (point) async {
              showDialog(
                context: context,
                builder: (ctx) =>
                    AlertDialog(
                      title: Text("Адрес"),
                      content: Text(address),
                    ),
              );
              MapPoint(
                name: '',
                latitude: point.latitude,
                longitude: point.longitude,
              );
            },
            onUserLocationAdded: (view) async {
              // получаем местоположение пользователя
              _userLocation = await (await mapControllerCompleter.future)
                  .getUserCameraPosition();
              // если местоположение найдено, центрируем карту относительно этой точки
              if (_userLocation != null) {
                (await mapControllerCompleter.future).moveCamera(
                  CameraUpdate.newCameraPosition(
                    _userLocation!.copyWith(zoom: 10),
                  ),
                  animation: const MapAnimation(
                    type: MapAnimationType.linear,
                    duration: 0.3,
                  ),
                );
              }
              // меняем внешний вид маркера - делаем его непрозрачным
              return view.copyWith(
                pin: view.pin.copyWith(
                  opacity: 1,
                ),
              );
            },
            onCameraPositionChanged: (cameraPosition, reason, finished) {
              print(cameraPosition.target.latitude);
              print(cameraPosition.target.longitude);
            },
          ),
          const Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Icon(
              Icons.location_on,
              color: AppColorsDark.green1,
              size: 40,
            ),
          ),
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
          BlocConsumer<AccountSetupBloc, AccountSetupState>(
            bloc: _bloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context,AccountSetupState state) {
              state.maybeWhen(
                  successGeocode: (state){
                    Log.i('Address LOG ${state.response.geoObjectCollection}');
                  },
                  orElse: (){});
              return Positioned(
                right: 16,
                left: 16,
                bottom: context.screenSize.width / 4,
                child: const AddressInfo(),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Align(
              alignment: Alignment.center,
              child: CustomButton(
                  width: context.screenSize.width / 1.2,
                  onTap: () async {
                    (await mapControllerCompleter.future)
                        .getCameraPosition()
                        .then((value) async {
                      if (context.mounted) {
                        // _targetPoint = value.target;
                        context.router.maybePop(value.target);
                      }
                    });
                  },
                  text: 'Добавить местоположение'),
            ),
          )
        ],
      ),
    );
  }
}
