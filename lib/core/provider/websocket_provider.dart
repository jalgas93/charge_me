import 'dart:convert';

import 'package:charge_me/feature/location/model/stations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../feature/location/bloc/websocket/websocket_bloc.dart';

class ConnectorProviderData {
  final List<Connector>? connector;

  ConnectorProviderData({
    this.connector,
  });
}

class WebsocketProvider extends StatefulWidget {
  const WebsocketProvider({super.key, required this.child});

  final Widget child;

  @override
  State<WebsocketProvider> createState() => _WebsocketProviderState();
}

class _WebsocketProviderState extends State<WebsocketProvider> {
  List<Connector>? connector;

  WebsocketBloc get _bloc => BlocProvider.of<WebsocketBloc>(context);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
       loadBalances();
    });
  }

  void loadBalances() {
    _bloc.add(
        WebsocketEvent.connector(message: jsonEncode({"action": "Connector"})));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, WebsocketState state) {
        return state.maybeWhen(connectorSuccess: (data) {
          connector = ConnectorList.fromJson(data).payload;
          return Provider<ConnectorProviderData>(
            create: (_) => ConnectorProviderData(connector: connector!),
            child: widget.child,
          );
        }, bookingSuccess: (data) {
          return Provider<ConnectorProviderData>(
            create: (_) => ConnectorProviderData(connector: connector!),
            child: widget.child,
          );
        }, orElse: () {
          return const SizedBox.shrink();
        });
      },
    );
  }
}
