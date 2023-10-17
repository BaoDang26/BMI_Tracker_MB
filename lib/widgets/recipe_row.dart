import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/food_details/food_detail_screen.dart';

class RecipesRow extends StatelessWidget {
  const RecipesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 240,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FoodDetailScreen();
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 170,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfDLQkEi-UgkZ30hfBkp0gAhlsasZLBqvL4A&usqp=CAU'),
                                ),
                              ),
                            ),
                            Text(
                              'Cucumber Gazpacho',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Icon(Icons.timelapse),
                                const SizedBox(width: 7),
                                Text('10 minutes')
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.people),
                                const SizedBox(width: 7),
                                Text('3 servings')
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.local_fire_department),
                                const SizedBox(width: 7),
                                Text('374 kcal')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
