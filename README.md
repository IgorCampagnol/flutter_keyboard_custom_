# KeyboardCustom Widget


The `KeyboardCustom` widget is a customizable virtual keyboard designed for Flutter applications. It allows users to input text through a custom keyboard interface. This widget provides flexibility in terms of keyboard type, button appearance, and text manipulation functionalities.

## Features

* Supports both alphanumeric and numeric keyboard types.
* Customizable button colors, font colors, and sizes.
* Option to apply a mask to the input text.
* Shift functionality for uppercase letters.
* Backspace functionality with long-press support.
* Easy integration with existing text controllers.

## Usage

To use the KeyboardCustom widget in your Flutter application, follow these steps:

1- Import the keyboard_custom.dart file into your Dart code.

```
import 'package:flutter_application_1/keyboard_custom.dart';
```
2- Create a TextEditingController to manage the input text.
```dart
TextEditingController _textController = TextEditingController();
```
3- Instantiate the KeyboardCustom widget and pass the text controller as a parameter.
```dart
KeyboardCustom(
  controller: _textController,
  // Other parameters can be customized as needed
)
```
## Parameters

* `keyboardType`: Specifies the type of keyboard (alphanumeric or numeric).
* `Default`  is alphanumeric.
* `controller` : Required parameter. Text controller for managing the input text.
* `applyMask`: Function to apply a mask to the input text. Signature: String Function(String)?.
* `fontColor`: Color of the text displayed on buttons. Default is Colors.white.
* `fontSize`: Font size of the text displayed on buttons. Default is 20.0.
* `iconColor`: Color of icon buttons. Default is Colors.white.
* `iconSize`: Size of icon buttons. Default is 25.
* `buttonColor`: Background color of the buttons. Default is Colors.grey.
* `backgroundColor`: Background color of the keyboard. Default is Colors.black.
* `alphanumericHeight`: Height ratio of the alphanumeric keyboard rows. Default is 0.06.
* `numericHeight` : Height ratio of the numeric keyboard rows. Default is 0.075.
## Example
```dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/keyboard_custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: KeyboardCustom(
        controller: TextEditingController(),
      ),
    );
  }
}
```
Feel free to customize the parameters according to your application's requirements to provide a seamless user input experience.






