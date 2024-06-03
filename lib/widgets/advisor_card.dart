// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/advisor_model.dart';

class AdvisorCard extends StatefulWidget {
  final bool isActive;
  final AdvisorModel advisor;
  final void Function()? onBlogClick;
  final void Function()? onMessageClick;
  final void Function()? onBookClick;
  const AdvisorCard({
    Key? key,
    required this.advisor,
    this.isActive = false,
    this.onBlogClick,
    this.onMessageClick,
    this.onBookClick,
  }) : super(key: key);

  @override
  State<AdvisorCard> createState() => _AdvisorCardState();
}

class _AdvisorCardState extends State<AdvisorCard> {
  bool _customIcon = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://www.avatarfitness.co.uk/wp-content/uploads/Jacob-pdf.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Positioned(
                      left: 35,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: widget.isActive
                              ? Colors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: widget.isActive
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 13),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  widget.advisor.fullName.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                )
              ],
            ),
            trailing: Icon(
              _customIcon ? Icons.close_rounded : Icons.add_circle,
              color: Theme.of(context).primaryColor,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 35,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 10,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            onPressed: widget.onBlogClick,
                            child: SizedBox(
                              width: 50,
                              height: 20,
                              child: Center(
                                child: Text(
                                  'Blogs',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: widget.onMessageClick,
                          icon: Icon(
                            Icons.messenger_outline_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: widget.onBookClick,
                          icon: Icon(
                            Icons.book_online_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Phone Number',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '\ ${widget.advisor.phoneNumber}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
            onExpansionChanged: (value) {
              setState(
                () {
                  _customIcon = value;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
