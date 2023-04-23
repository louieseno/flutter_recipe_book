import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/presenter/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class RecipeDialog {
  static Widget _getIngredientsWidget(List<String> strings) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((item) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Row(children: [
                const Text('\u2022 ', style: TextStyle(fontSize: 25)),
                Expanded(
                  child: Text(
                    item,
                    style: RecipeStyle.ingredientStyle,
                  ),
                )
              ]));
        }).toList());
  }

  static Future<void> showDetails({
    required BuildContext context,
    required EdamamRecipe recipe,
    bool showAddFooter = true,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: RecipeStyle.dialogPadding,
          elevation: 16,
          child: Center(
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: RecipeStyle.imageMargin,
                        padding: RecipeStyle.imagePadding,
                        child: CachedImage(
                          url: recipe.image,
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Center(
                          child: Text(
                            recipe.label,
                            style: RecipeStyle.labelStyle,
                          ),
                        ),
                      ),
                      _getIngredientsWidget(recipe.ingredients)
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (showAddFooter) ...[
                        InkWell(
                          onTap: () => print('press'),
                          child: Padding(
                            padding: RecipeStyle.footerButtonPadding,
                            child: RichText(
                              text: const TextSpan(
                                style: RecipeStyle.footerButtonAddText,
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.bookmark_add,
                                      size: 16,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Add Recipe",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: RecipeStyle.footerButtonPadding,
                          child: Text(
                            'Close',
                            style: RecipeStyle.footerButtonCloseText,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showDeletePrompt({
    required BuildContext context,
    required EdamamRecipe recipe,
    required void Function() confirmedDelete,
  }) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Delete My Recipe",
              style: RecipeStyle.deleteTitleTextStyle,
            ),
            content: RichText(
              text: TextSpan(
                style: RecipeStyle.deleteRichTextStyle,
                children: <TextSpan>[
                  const TextSpan(
                    text: "Are you sure you want to delete\n",
                  ),
                  TextSpan(
                    text: "${recipe.label} recipe ?",
                    style: RecipeStyle.richTextBold,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Yes",
                    style: TextStyle(color: Colors.redAccent)),
                onPressed: () {
                  confirmedDelete();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class RecipeStyle {
  static const ingredientStyle =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);
  static const labelStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
  static const imageMargin = EdgeInsets.only(top: 20.0);
  static const imagePadding = EdgeInsets.all(8.0);
  static const dialogPadding =
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 120.0);
  static const footerButtonPadding = EdgeInsets.all(15.0);
  static const footerButtonCloseText =
      TextStyle(color: Colors.red, fontSize: 16);
  static const footerButtonAddText =
      TextStyle(color: Colors.purple, fontSize: 16);
  static const richTextBold = TextStyle(fontWeight: FontWeight.w700);
  static const deleteTitleTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w900);
  static const deleteRichTextStyle =
      TextStyle(color: Colors.black, fontSize: 16, height: 1.5);
}
