import 'package:client/presenter/screens/online_recipes/online_recipes_controller.dart';
import 'package:client/presenter/screens/online_recipes/online_recipes_styles.dart';
import 'package:client/presenter/widgets/cached_image.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
import 'package:client/services/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRecipesScreen extends GetView<OnlineRecipesController> {
  static const route = '/recipe';
  const OnlineRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Recipes"),
      ),
      body: Center(
        child: Obx(
          () => ConditionalWidget(
            condition: controller.isFetching.value,
            passedWidget: const CircularProgressIndicator(),
            failedWidget: Padding(
              padding: OnlineRecipeStyles.containerPadding,
              child: Column(
                children: [
                  TextField(
                    controller: controller.searchTextController,
                    decoration: OnlineRecipeStyles.searchBoxstyle,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.edamamMasterList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: OnlineRecipeStyles.listPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedImage(
                                      url: controller
                                          .edamamMasterList[index].image,
                                    ),
                                    Padding(
                                      padding: OnlineRecipeStyles.labelPadding,
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        spacing: 5,
                                        children: [
                                          Text(
                                            controller
                                                .edamamMasterList[index].label,
                                            style:
                                                OnlineRecipeStyles.labelStyle,
                                          ),
                                          Text(
                                            controller.edamamMasterList[index]
                                                .dishType
                                                .toTitleCase(),
                                            style: OnlineRecipeStyles
                                                .dishTypeStyle,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: OnlineRecipeStyles
                                                  .ingredientsStyle,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "${controller.edamamMasterList[index].ingredients.length}",
                                                    style: OnlineRecipeStyles
                                                        .ingedientsTotalStyle),
                                                const TextSpan(
                                                    text: ' Ingredients')
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon:
                                      const Icon(Icons.bookmark_add, size: 20),
                                  onPressed: () => print('bookmark click'),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: OnlineRecipeStyles.saveButtonStyle,
                    child: Material(
                      color: Colors.purple,
                      child: InkWell(
                        onTap: () {
                          //print('called on tap');
                        },
                        child: const SizedBox(
                          height: kBottomNavigationBarHeight,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Save Changes',
                              style: OnlineRecipeStyles.saveButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
