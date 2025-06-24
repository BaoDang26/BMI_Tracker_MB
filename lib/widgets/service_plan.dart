import 'package:flutter/material.dart';
import 'package:flutter_health_menu/util/num_utils.dart';
import 'package:flutter_health_menu/util/size_utils.dart';

import 'widgets.dart';

class ServicePlan extends StatelessWidget {
  const ServicePlan({
    Key? key,
    required this.benefitList,
    required this.planName,
    this.isPromoted = false,
    this.isPopular = false,
    required this.price,
    required this.onPressed,
    this.promotedPrice = 9,
    this.duration = 0,
  }) : super(key: key);

  final List<String> benefitList;
  final String planName;
  final bool isPromoted;
  final bool isPopular;
  final double price;
  final int promotedPrice;
  final int duration;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Color textColor = isPopular ? Colors.white : Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isPopular
            ? Colors.blueAccent
            : Theme.of(context).primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // plan name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.h,
                    child: Text(
                      planName,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      isPopular
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.h, vertical: 5.v),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.greenAccent,
                              ),
                              child: Text(
                                'Most Popular',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 10.v),
                      isPromoted
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 5.v),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: Text(
                                'Off $promotedPrice VND',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.greenAccent,
                                    ),
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
              // price
              Container(
                margin: EdgeInsets.only(top: 15.v),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${price.formatWithThousandSeparator()} VND',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      // '/month',
                      '/${duration} days',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: textColor),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              isPromoted
                  ? Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Monthly Fee',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: textColor),
                        )
                      ],
                    )
                  : Container(),
              isPromoted
                  ? Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Annual payment (save 25%)',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: textColor),
                        )
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: CustomElevatedButton(
                  onPressed: onPressed,
                  text: 'CHOOSE THIS PACKAGE',
                ),
              ),

              //mapping list benefit
              Column(
                children: benefitList.map(
                  (b) {
                    return Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Color.fromARGB(255, 233, 233, 26),
                          size: 30.adaptSize,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            b,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: textColor),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              )
            ],
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     elevation: 0,
          //     backgroundColor: Colors.black,
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //   ),
          //   child: Text(
          //     'Show all',
          //     style: Theme.of(context)
          //         .textTheme
          //         .bodyMedium!
          //         .copyWith(color: Colors.greenAccent),
          //   ),
          // )
        ],
      ),
    );
  }
}
