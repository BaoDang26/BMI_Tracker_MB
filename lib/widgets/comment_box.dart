// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentBox extends StatelessWidget {
  final String? userImage;
  final String commentText;
  const CommentBox({
    Key? key,
    this.userImage,
    required this.commentText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage == null
                ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png'
                : userImage!),
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffd7ecb6),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selena Hathaway',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    RatingBar.builder(
                      initialRating: 2,
                      minRating: 1,
                      itemSize: 25,
                      direction: Axis.horizontal,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
                Text(commentText)
              ],
            ),
          ),
        )
      ],
    );
  }
}
