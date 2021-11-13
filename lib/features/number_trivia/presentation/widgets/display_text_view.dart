import 'package:flutter/material.dart';

class DisplayTextView extends StatelessWidget {
  final String value;
  const DisplayTextView({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
          child: Text(
        value,
        style: Theme.of(context).textTheme.headline4,
      )),
    );
  }
}
