// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/blog_model.dart';

class BlogCard extends StatefulWidget {
  final bool isActive;
  final BlogModel blog;
  final void Function()? onDetailClick;
  final void Function()? onMessageClick;
  const BlogCard({
    Key? key,
    required this.blog,
    this.isActive = false,
    this.onDetailClick,
    this.onMessageClick,
  }) : super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
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
                        image: DecorationImage(
                          image: NetworkImage(widget.blog.blogPhoto!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    // Positioned(
                    //   left: 35,
                    //   child: Container(
                    //     width: 15,
                    //     height: 15,
                    //     decoration: BoxDecoration(
                    //       color: widget.isActive
                    //           ? Colors.green
                    //           : Colors.transparent,
                    //       borderRadius: BorderRadius.circular(30),
                    //       border: Border.all(
                    //           color: widget.isActive
                    //               ? Colors.white
                    //               : Colors.transparent,
                    //           width: 13),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  widget.blog.blogName ?? "Quoc Dung",
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
                            onPressed: widget.onDetailClick,
                            child: SizedBox(
                              width: 50,
                              height: 20,
                              child: Center(
                                child: Text(
                                  'Details',
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
                        const SizedBox(width: 15),
                        // IconButton(
                        //   onPressed: widget.onMessageClick,
                        //   icon: Icon(
                        //     Icons.messenger_outline_outlined,
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     // Text(
                    //     //   'Make plan',
                    //     //   style: Theme.of(context).textTheme.bodySmall,
                    //     // ),
                    //     Text(
                    //       '\ ${widget.blog.tag}',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyLarge!
                    //           .copyWith(
                    //               fontWeight: FontWeight.bold,
                    //               color: Theme.of(context).primaryColor),
                    //     )
                    //   ],
                    // )
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
