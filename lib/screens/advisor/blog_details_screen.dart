// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_health_menu/controllers/blog_controller.dart';
import 'package:flutter_health_menu/models/blog_model.dart';
import 'package:flutter_health_menu/screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final IngredientModel viewIngredient = Get.arguments[0];
    // final FoodModel viewFood = Get.arguments[0];
    final BlogModel viewBlog = Get.arguments[0];
     // final foodController = Get.put(FoodController());

    // final ingredientController = Get.put(IngredientController());

    return Scaffold(
      appBar: AppBar(
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         Get.to(const FeedbackScreen());
        //       },
        //       icon: const Icon(
        //         Icons.feedback,
        //       ),
        //     ),
        //   ],
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const FeedbackScreen());
            },
            icon: const Icon(
              Icons.feedback,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! Name
              Text(
                viewBlog.blogName ?? 'Orange Cake',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //! photo
                  image: DecorationImage(
                    image: NetworkImage(viewBlog.blogPhoto ??
                        'https://i.ytimg.com/vi/XowvxiGYsRI/maxresdefault.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: DishInfo(
              //     kcal: "${viewFood.foodCalorios}",
              //     servings: '1',
              //     time: "${viewFood.foodtimeProcess}'",
              //   ),
              // ),
              // Text(
              //   '#${viewBlog.tag!}',
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),

              Text(
                'Content',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 55,
              //     child: ListView.builder(
              //       itemCount: 5,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return Row(
              //           children: [
              //             Container(
              //               width: 55,
              //               decoration: BoxDecoration(
              //                 color: const Color(0xffd7ecb6),
              //                 borderRadius: BorderRadius.circular(40),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   '39 g Carbs',
              //                   textAlign: TextAlign.center,
              //                   style: Theme.of(context).textTheme.bodySmall,
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(width: 15),
              //           ],
              //         );
              //       },
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    viewBlog.blogContent!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),

              // Text(
              //   'Ingredients',
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: ListView.builder(
              //     // width: double.infinity,
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: ingredientController.ingredientList.length,
              //     itemBuilder: (context, index) {
              //       return Text(
              //         ingredientController
              //             .ingredientList[index].ingredients!.ingredientName!,
              //         style: Theme.of(context).textTheme.bodyLarge,
              //       );
              //     },
              //     // child: Text(
              //     //   viewIngredient.ingredientName!,
              //     //   style: Theme.of(context).textTheme.bodyLarge,

              //     // ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: ListView.builder(
              //     itemCount: viewFood.recipes!.length,
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return Text(ingredients[index]
              //           // viewFood.recipes![index].ingredients!.ingredientName!
              //           );
              //     },
              //   ),
              // ),
              Text(
                'Pratice Video',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse('${viewBlog.link}'));
                      },
                      child: Text(
                        'Link Video',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              // fontSize: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    )),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //     width: double.infinity,
              //     child: Text(
              //       '# ${viewBlog.tag!}',
              //       style: Theme.of(context).textTheme.bodyLarge,
              //     ),
              //   ),
              // ),

              // Text(
              //   'Link processing video',
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //       width: double.infinity,
              //       child:
              //           // Text(
              //           //   viewFood.foodProcessingVideo!,
              //           //   style: Theme.of(context).textTheme.bodyLarge,
              //           // ),
              //           TextButton(
              //         onPressed: () {
              //           launchUrl(Uri.parse('${viewFood.foodProcessingVideo}'));
              //         },
              //         child: Text(
              //           'Link Video',
              //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //                 color: Theme.of(context).primaryColor,
              //                 // fontSize: FontStyle.italic,
              //                 decoration: TextDecoration.underline,
              //               ),
              //         ),
              //       )),
              // ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: ListView.builder(
              //     itemCount: steps.length,
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         contentPadding: EdgeInsets.zero,
              //         title: Text(
              //           'Step ${steps[index].step}',
              //           style: Theme.of(context).textTheme.titleMedium,
              //         ),
              //         subtitle: Text(
              //           steps[index].desc,
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Text(
              //   'Comments',
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: ListView.builder(
              //     itemCount: 5,
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return const Column(
              //         children: [
              //           CommentBox(
              //               userImage:
              //                   'https://images.unsplash.com/photo-1546961329-78bef0414d7c?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              //               commentText:
              //                   'This is a really loooooooooooooooooooooooong instructions that is used as a placeholder!'),
              //           SizedBox(height: 10),
              //         ],
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
