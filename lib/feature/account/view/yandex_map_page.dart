import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../home/model/app_lat_long.dart';
import '../../../share/utils/location_service.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../model/yandex_address/response_result.dart';
import '../widget/address_info.dart';

@RoutePage(name: "YandexMapPageRoute")
class YandexMapPage extends StatefulWidget {
  const YandexMapPage({super.key});

  @override
  State<YandexMapPage> createState() => _YandexMapPageState();
}

class _YandexMapPageState extends State<YandexMapPage> {
  final mapControllerCompleter = Completer<YandexMapController>();

  //late AccountSetupBloc _bloc;
  //late AccountSetupRepository _repository;
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  List<SearchItem> searchList = [];
  Timer? _debounce;
  CameraPosition? _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    // _repository = AccountSetupRepository();
    //_bloc = AccountSetupBloc(repository: _repository);
    // _bloc.add(const AccountSetupEvent.addLocation());
    _initPermission().ignore();
  }

  @override
  void dispose() {
    // _bloc.close();
    // _debounce?.cancel();
    _addressController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void submit() async {
    //  _bloc.add(const AccountSetupEvent.addLocation());
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
      _addressController.text = await getAddressFromPoint(
            Point(
              latitude: location.lat,
              longitude: location.long,
            ),
          ) ??
          '';
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong location) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: location.lat,
            longitude: location.long,
          ),
          zoom: 17,
        ),
      ),
    );
  }

  void _onCameraPositionChanged(CameraPosition position, _, __) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () async {
      _addressController.text = await getAddressFromPoint(
            Point(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
            ),
          ) ??
          '';
      setState(() {});
    });

    _currentCameraPosition = position;
  }

  //Поиск по тексту
/*  void _search() async {
    final query = _queryController.text;

    print('Search query: $query');
    searchList.clear();

    final resultWithSession = await YandexSearch.searchByText(
      searchText: query,
      geometry: Geometry.fromBoundingBox(const BoundingBox(
        southWest:
        Point(latitude: 41.38531385190352, longitude: 69.24249890765117),
        northEast:
        Point(latitude: 41.19074450355697, longitude: 69.25048804582741),
      )),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );

    final data = await resultWithSession.$2;
    print(data);
    setState(() {
      searchList.addAll(data.items ?? []);
    });
  }*/
  //Поиск по геопозиций
  Future<String?> getAddressFromPoint(Point point) async {
    try {
      final resultWithSession = await YandexSearch.searchByPoint(
        point: point,
        searchOptions: const SearchOptions(
          searchType: SearchType.geo, // Геокодинг
          resultPageSize: 1,
        ),
      );

      final response = await resultWithSession.$2;

      if (response.items != null && response.items!.isNotEmpty) {
        final topItem = response.items!.first;
        return topItem.name; // или .description
      } else {
        return 'Адрес не найден';
      }
    } catch (e) {
      print('Ошибка при получении адреса: $e');
      return null;
    }
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
            onCameraPositionChanged: _onCameraPositionChanged,
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
/*          Positioned(
            right: 16,
            left: 16,
            top: context.screenSize.width / 3.5,
            child: SearchInfo(
                controller: _queryController,
            onEditingComplete: (){
              _search();
            },
            ),
          ),*/
          Positioned(
            right: 16,
            left: 16,
            bottom: context.screenSize.width / 4,
            child: AddressInfo(address: _addressController.text),
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
                        context.router.maybePop(ResponseResult(
                          address: _addressController.text,
                          point: value.target,
                        ));
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
