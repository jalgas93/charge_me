import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/location/location_repository.dart';
import 'package:charge_me/feature/location/model/stations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/logging/log.dart';

part 'location_event.dart';

part 'location_state.dart';

part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _repository;

  LocationBloc({required LocationRepository repository})
      : _repository = repository,
        super(const LocationState.initial()) {
    on<LocationEvent>((event, emit) => _location(event, emit));
  }

  Future<void> _location(
    LocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    await event.map(started: (event) async {
      emit(const LocationState.loading());
      try {
        final dynamic response = await _repository.getStations();
        Log.i(response);
        emit(LocationState.successLocation(
            list: Stations
                .fromJson(response)
                .list ?? []));
      } catch (e) {
        emit(LocationState.error(error: e));
      }
    });
  }
}
