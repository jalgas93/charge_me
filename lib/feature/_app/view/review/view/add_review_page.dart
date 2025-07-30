import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../widget/add_description.dart';
import '../widget/rating_form.dart';

@RoutePage(name: "AddReviewPageRoute")
class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double rating = 1.0;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hi, how was your', style: context.textTheme.titleLarge),
          Text('lorem ipsum dolor sit amet',
              style: context.textTheme.bodyMedium),
          16.height,
          const RatingForm(),
          32.height,
          AddDescription(controller: controller),
          16.height,
          CustomButton(onTap: () async {}, text: "Отправить")
        ],
      ),
    );
  }
}
