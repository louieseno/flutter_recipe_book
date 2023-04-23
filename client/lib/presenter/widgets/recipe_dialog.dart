import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/presenter/widgets/cached_image.dart';
import 'package:client/presenter/widgets/footer_button.dart';
import 'package:flutter/material.dart';

class RecipeDialog {
  static Widget _getIngredientsWidget(List<String> strings) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((item) {
          final int idx = strings.indexOf(item) + 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "$idx. $item",
              style: RecipeStyle.ingredientStyle,
            ),
          );
        }).toList());
  }

  static Future<void> showDetails({
    required BuildContext context,
    required EdamamRecipe recipe,
    bool showFooter = true,
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
                if (showFooter) ...[
                  Padding(
                    padding: RecipeStyle.footerButtonPadding,
                    child: FooterButton(
                      onTap: () => print('add bookmark'),
                      label: 'Add Recipe',
                    ),
                  ),
                  Padding(
                    padding: RecipeStyle.footerButtonPadding,
                    child: FooterButton(
                      onTap: () => Navigator.pop(context),
                      color: Colors.redAccent,
                      label: 'Close',
                    ),
                  )
                ]
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
            title: const Text("Delete My Recipe",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
            content: RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.black, fontSize: 14, height: 1.5),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Are you sure you want to delete\n",
                  ),
                  TextSpan(
                      text: "${recipe.label} recipe ?",
                      style: const TextStyle(fontWeight: FontWeight.w700))
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
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const labelStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
  static const imageMargin = EdgeInsets.only(top: 20.0);
  static const imagePadding = EdgeInsets.all(8.0);
  static const dialogPadding =
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 100.0);
  static const footerButtonPadding =
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0);
}
