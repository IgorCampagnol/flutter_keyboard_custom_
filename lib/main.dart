import 'package:flutter/material.dart';
import 'package:flutter_keyboard_custom/custom_text_field.dart';
import 'package:flutter_keyboard_custom/keyboard_custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            SizedBox(
              width: 400,
              child: CustomTextField(icon: Icons.abc, controller: controller),
            ),
            const SizedBox(
              height: 300,
            ),
            KeyboardCustom(
              controller: controller,
              applyMask: applyNameMask,
            ),
          ],
        ),
      ),
    );
  }

  String applyNameMask(String value) {
    String maskedValue = value;
    return maskedValue;
  }
}
