// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      widget.blog.blogName!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              // "https://prod-ne-cdn-media.puregym.com/media/819394/gym-workout-plan-for-gaining-muscle_header.jpg?quality=80" ??
                              widget.blog.blogPhoto!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      widget.blog.blogContent!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 10,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          onPressed: () {
                            launchUrl(Uri.parse('${widget.blog.link}'));
                          },
                          child: SizedBox(
                            width: 30.h,
                            height: 20.v,
                            child: Center(
                              child: Text(
                                'Link',
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
                      )
                      // Container(
                      //     width: 70,
                      //     child: TextButton(
                      // onPressed: () {
                      //   launchUrl(Uri.parse('${widget.blog.link}'));
                      // },
                      //       child: Text(
                      //         'Link',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .titleMedium!
                      //             .copyWith(
                      //               // color: Theme.of(context).primaryColor,
                      //               // fontSize: FontStyle.italic,
                      //               decoration: TextDecoration.underline,
                      //             ),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
              ],
            ),
            // trailing: Icon(
            //   _customIcon ? Icons.close_rounded : Icons.add_circle,
            //   color: Theme.of(context).primaryColor,
            // ),
            // children: [
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             SizedBox(
            //               height: 35,
            //               child: OutlinedButton(
            //                 style: OutlinedButton.styleFrom(
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(5),
            //                     side: BorderSide(
            //                       color: Theme.of(context).primaryColor,
            //                       width: 10,
            //                       style: BorderStyle.solid,
            //                     ),
            //                   ),
            //                 ),
            //                 onPressed: widget.onDetailClick,
            //                 child: SizedBox(
            //                   width: 50,
            //                   height: 20,
            //                   child: Center(
            //                     child: Text(
            //                       'Details',
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .labelLarge!
            //                           .copyWith(
            //                               color: Theme.of(context).primaryColor,
            //                               fontWeight: FontWeight.bold),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(width: 15),
            //             // IconButton(
            //             //   onPressed: widget.onMessageClick,
            //             //   icon: Icon(
            //             //     Icons.messenger_outline_outlined,
            //             //     color: Theme.of(context).primaryColor,
            //             //   ),
            //             // ),
            //           ],
            //         ),
            //         // Column(
            //         //   crossAxisAlignment: CrossAxisAlignment.end,
            //         //   children: [
            //         //     // Text(
            //         //     //   'Make plan',
            //         //     //   style: Theme.of(context).textTheme.bodySmall,
            //         //     // ),
            //         //     Text(
            //         //       '\ ${widget.blog.tag}',
            //         //       style: Theme.of(context)
            //         //           .textTheme
            //         //           .bodyLarge!
            //         //           .copyWith(
            //         //               fontWeight: FontWeight.bold,
            //         //               color: Theme.of(context).primaryColor),
            //         //     )
            //         //   ],
            //         // )
            //       ],
            //     ),
            //   )
            // ],
            // onExpansionChanged: (value) {
            //   setState(
            //     () {
            //       _customIcon = value;
            //     },
            //   );
            // },
          ),
        ),
      ),
    );
  }
}
