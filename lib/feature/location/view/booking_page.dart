import 'package:auto_route/annotations.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../share/widgets/circle_container.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_success_booking.dart';
import '../widget/booking/item_title.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
    this.station,
    this.onTapCancel,
    this.onTapCharging,
    required this.connector,
  });

  final List<Connector> connector;
  final Station? station;
  final Function()? onTapCancel;
  final Function()? onTapCharging;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>  with SingleTickerProviderStateMixin{
  AnimationController? _animationController;
  int levelClock = 3 * 60;


  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTitle(
                title: widget.station?.location?.city ?? '',
                description: widget.station?.location?.address ?? '',
                stationId: widget.station?.externalId ?? '',
                connectorId: '# ${widget.connector[UtilsLocation.index.value].connectorId}',
                type: widget.connector[UtilsLocation.index.value].type ?? '',
                maxPower: '${widget.connector[UtilsLocation.index.value].maxPower} kBT',
              ),
              16.height,
              ItemSuccessBooking(
                type: widget.connector[UtilsLocation.index.value].type??'',
                price: widget.connector[UtilsLocation.index.value].costPerKwh ?? 0,
                costBookingMinutes: widget.connector[UtilsLocation.index.value].costBookingMinutes ?? 0,
                levelClock: levelClock,
                animation: _animationController!,
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: widget.onTapCancel,
                      child: CircleContainer(
                        color: AppColorsDark.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text('Отменить бронь',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColorsDark.green3,
                            )),
                      ),
                    ),
                  ),
                  8.width,
                  Flexible(
                    child: GestureDetector(
                      onTap: widget.onTapCharging,
                      child: CircleContainer(
                        color: AppColorsDark.green1,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/power_socket.png',
                              color: AppColorsDark.white,
                            ),
                            8.width,
                            Text('Зарядиться',
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(color: AppColorsDark.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
