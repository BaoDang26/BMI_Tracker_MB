import 'package:flutter/material.dart';

class NotiCard extends StatelessWidget {
  const NotiCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 7,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  ),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Congratilations!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: 250,
                      child: Text(
                          'You have complete today meals and lose 300kcal!'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
