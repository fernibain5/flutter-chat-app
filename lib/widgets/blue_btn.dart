import 'package:flutter/material.dart';

class BlueBtn extends StatelessWidget {
  final void Function()? onPressedHandler;
  final String text;

  const BlueBtn({
    Key? key,
    required this.onPressedHandler,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressedHandler,
      child: Container(
        height: 55,
        width: double.infinity,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        elevation: 2,
        primary: Colors.blue,
      ),
    );
  }
}
