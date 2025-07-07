import 'dart:convert';

import 'package:charge_me/core/provider/websocket_provider.dart';
import 'package:charge_me/feature/location/bloc/websocket/websocket_bloc.dart';
import 'package:charge_me/feature/location/model/stations.dart';
import 'package:charge_me/feature/location/view/connector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/app_user.dart';
import '../../../core/logging/log.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/throw_error.dart';
import '../utils/utils_location.dart';

class Workflow extends StatelessWidget {
  const Workflow({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return WebsocketProvider(
      child: WorkflowContainer(station: station),
    );
  }
}

class WorkflowContainer extends StatefulWidget {
  const WorkflowContainer({super.key, required this.station});

  final Station station;

  @override
  State<WorkflowContainer> createState() => _WorkflowContainerState();
}

class _WorkflowContainerState extends State<WorkflowContainer> {

  WebsocketBloc get _bloc => BlocProvider.of<WebsocketBloc>(context);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('print----------');
  }
  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    List<Connector>? connector =
        Provider.of<ConnectorProviderData>(context, listen: false).connector;
    print("state ${websocketBloc.state}");
    return BlocConsumer<WebsocketBloc, WebsocketState>(
      bloc: _bloc,
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
            connectWebSocket: () async {
              Log.i('connectWebSocket');
            },
            connectorSuccess: (data) async {
              Log.i('connectorSuccess listener $data');
            },
            bookingSuccess: (data) async {
              Log.i('bookingSuccess listener $data');
            },
            bookingCancelSuccess: (data) {
              Log.i('bookingCancelSuccess listener $data');
            },
            queueSuccess: (data) {
              Log.i('queueSuccess listener $data');
            },
            chargingSuccess: (data) async {
              Log.i('chargingSuccess listener $data');
            },
            finishSuccess: (data) async {
              Log.i('finishSuccess listener $data ');
            },
            orElse: () {});
      },
  builder: (context, state) {
    return Column(
      children: [
        CustomButton(
            onTap: () async {
              _bloc.add(WebsocketEvent.booking(
                message: jsonEncode({
                  "action": "StartBooking",
                  "messageId": "StartBooking",
                  "payload": {
                    "status": BookingStation.booking.name,
                    "phone": AppUser.userModel?.phone,
                    "userId": AppUser.userModel?.userId,
                    "connectorId":
                    "${connector?[UtilsLocation.index.value].connectorId}",
                    "timestamp": DateTime.now().toIso8601String(),
                    "chargerId": widget.station.externalId
                  }
                }),
              ));
            },
            radius: 25,
            text: 'Продолжить'),
        ConnectorPage(station: widget.station),
      ],
    );
  },
);
  }
}
