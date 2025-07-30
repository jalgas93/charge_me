import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/review_utils.dart';

class RatingForm extends StatelessWidget {
  const RatingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: 1,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: AppColorsDark.yellow3,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Image.asset('assets/star_review.png',
              color: AppColorsDark.yellow2,),
          onRatingUpdate: (value) {
            ReviewUtils.setChangeRating = value;
          },
        ),
        16.width,
        ValueListenableBuilder(
          valueListenable: ReviewUtils.changeRating,
          builder: (context, value, child) {
            return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('$value',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColorsDark.white,
                    )));
          },
        ),
      ],
    );
  }
}
