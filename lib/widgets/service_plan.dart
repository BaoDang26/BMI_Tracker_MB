import 'package:flutter/material.dart';

import 'widgets.dart';

class ServicePlan extends StatelessWidget {
  const ServicePlan({
    Key? key,
    required this.benefitList,
    required this.planName,
    this.isPromoted = false,
    this.isPopular = false,
    required this.price,
    this.promotedPrice = 9,
  }) : super(key: key);

  final List<String> benefitList;
  final String planName;
  final bool isPromoted;
  final bool isPopular;
  final double price;
  final int promotedPrice;

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
                  Text(
                    planName,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      isPopular
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                        child: Text(
                          'Off \$$promotedPrice',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              //price
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$$price',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '/month',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: textColor),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
                  onPressed: () {},
                  text: 'Choose $planName',
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
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          b,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: textColor),
                        ),
                      ],
                    );
                  },
                ).toList(),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            child: Text(
              'Show all',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.greenAccent),
            ),
          )
        ],
      ),
    );
  }
}
