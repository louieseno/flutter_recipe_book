import 'package:client/presenter/screens/online_recipes/online_recipes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FooterButton extends StatelessWidget {
  final void Function() onTap;
  final Color? color;
  final String? label;
  final IconData? iconData;

  const FooterButton({
    required this.onTap,
    this.color = Colors.purple,
    this.label = 'Save Changes',
    this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnlineRecipesController>();
    return Obx(() => Material(
          color: controller.isSaving.value ? Colors.purple[200] : color,
          child: InkWell(
            onTap: () {
              if (!controller.isSaving.value) {
                onTap();
              }
            },
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconData != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          iconData,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    Text(
                      label!,
                      style: FooterButtonStyle.saveButtonTextStyle,
                    ),
                    if (controller.isSaving.value)
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class FooterButtonStyle {
  static const saveButtonTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
}
