import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String? message;
  const CustomLoader({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        if (message != null && message != '')
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          )
      ],
    );
  }
}
