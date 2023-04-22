
import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget passedWidget;
  final Widget failedWidget;
  const ConditionalWidget({
    required this.condition,
    required this.passedWidget,
    required this.failedWidget,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  condition ? passedWidget : failedWidget;
  }
}