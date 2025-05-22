import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class TopLocation extends StatelessWidget {
  const TopLocation({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: constraints.maxWidth / 1.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10 // Set fixed height for each item
            ),
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
            //  context.router.push(const DescriptionPageRoute());
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: 16,
              ),
              decoration:  const BoxDecoration(
                color: AppColorsDark.whiteSecondary,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: constraints.maxWidth / 2,
                        width: constraints.maxWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/IMG_3.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          left: 8,
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColorsDark.lightGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Text(
                              '#1',
                              style: context.textTheme.titleSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Jakarta', style: context.textTheme.titleSmall),
                ],
              ),
            ),
          );
        });
  }
}
