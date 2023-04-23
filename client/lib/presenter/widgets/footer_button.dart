import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  final void Function() onTap;
  final Color? color;
  final String? label;

  const FooterButton({
    required this.onTap,
    this.color = Colors.purple,
    this.label = 'Save Changes',
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
