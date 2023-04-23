import 'package:flutter/material.dart';

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
    return Material(
      color: color,
      child: InkWell(
        onTap: onTap,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FooterButtonStyle {
  static const saveButtonTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
}
