import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

enum KeyboardType {
  numeric,
  alphanumeric,
}

class KeyboardCustom extends StatefulWidget {
  const KeyboardCustom({
    Key? key,
    this.keyboardType = KeyboardType.alphanumeric,
    required this.controller,
    required this.applyMask,
    this.fontColor = Colors.white,
    this.fontSize = 20.0,
    this.iconColor = Colors.white,
    this.iconSize = 25,
    this.buttonColor = Colors.grey,
    this.backgroundColor = Colors.black,
    this.alphanumericHeight = 0.06,
    this.numericHeight = 0.075,
  }) : super(key: key);

  final KeyboardType keyboardType;
  final TextEditingController controller;
  final String Function(String) applyMask; // Assinatura da função applyMask
  final Color fontColor;
  final double fontSize;
  final Color iconColor;
  final double iconSize;
  final Color buttonColor;
  final Color backgroundColor;
  final double alphanumericHeight;
  final double numericHeight;

  @override
  State<KeyboardCustom> createState() => _KeyboardCustomState();
}

class _KeyboardCustomState extends State<KeyboardCustom> {
  bool _shiftEnabled = false;
  final FocusNode _focusNode = FocusNode();
  late Timer _backspaceTimer;
  late LongPressGestureRecognizer _backspaceLongPressRecognizer;

  @override
  void initState() {
    super.initState();
    _backspaceTimer = Timer(Duration.zero, () {});
    _backspaceLongPressRecognizer = LongPressGestureRecognizer()
      ..onLongPressStart = _startBackspaceTimer
      ..onLongPressEnd = _stopBackspaceTimer;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _backspaceTimer.cancel();
    _backspaceLongPressRecognizer.dispose();
    super.dispose();
  }

  void _startBackspaceTimer(LongPressStartDetails details) {
    _backspaceTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (widget.controller.text.isNotEmpty) {
        setState(() {
          widget.controller.text = widget.controller.text
              .substring(0, widget.controller.text.length - 1);
        });
      }
    });
  }

  void _stopBackspaceTimer(LongPressEndDetails details) {
    _backspaceTimer.cancel();
  }

  Widget buildButton(String tecla) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              String valorAtual = widget.controller.text;
              String valorNovo =
                  _shiftEnabled ? tecla.toUpperCase() : tecla.toLowerCase();
              String valorAtualizado = widget.applyMask(valorAtual + valorNovo);
              widget.controller.text = valorAtualizado;
            });
            _focusNode.requestFocus();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.black, width: 0.25),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              _shiftEnabled ? tecla.toUpperCase() : tecla.toLowerCase(),
              style:
                  TextStyle(fontSize: widget.fontSize, color: widget.fontColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonCustom(IconData icon) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: SizedBox(
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onLongPressStart: _startBackspaceTimer,
            onLongPressEnd: _stopBackspaceTimer,
            child: IconButton(
              onPressed: () {
                if (icon == Icons.backspace) {
                  if (widget.controller.text.isNotEmpty) {
                    widget.controller.text = widget.controller.text
                        .substring(0, widget.controller.text.length - 1);
                  }
                }
                if (icon == Icons.arrow_upward) {
                  setState(() {
                    _shiftEnabled = !_shiftEnabled;
                  });
                }
                _focusNode.requestFocus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.black, width: 0.25),
                ),
              ),
              icon: Icon(
                icon,
                size: widget.iconSize,
                color: widget.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackSpaceCustom(IconData icon) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox(
        height: size.height,
        child: IconButton(
          onPressed: () {
            setState(() {
              widget.controller.text += ' '; // Adiciona um espaço ao texto
            });
            _focusNode.requestFocus(); // Manter o foco no campo de texto
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.black, width: 0.25),
            ),
          ),
          icon: Icon(
            icon,
            size: widget.iconSize,
            color: widget.iconColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      child: SingleChildScrollView(
        child: widget.keyboardType == KeyboardType.alphanumeric
            ? Container(
                padding: const EdgeInsets.all(5),
                color: widget.backgroundColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * widget.alphanumericHeight,
                      child: Row(
                        children: [
                          buildButton('@'),
                          buildButton('1'),
                          buildButton('2'),
                          buildButton('3'),
                          buildButton('4'),
                          buildButton('5'),
                          buildButton('6'),
                          buildButton('7'),
                          buildButton('8'),
                          buildButton('9'),
                          buildButton('0'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.alphanumericHeight,
                      child: Row(
                        children: [
                          buildButton('q'),
                          buildButton('w'),
                          buildButton('e'),
                          buildButton('r'),
                          buildButton('t'),
                          buildButton('y'),
                          buildButton('u'),
                          buildButton('i'),
                          buildButton('o'),
                          buildButton('p'),
                          buildButton('-'),
                          buildButtonCustom(Icons.backspace),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.alphanumericHeight,
                      child: Row(
                        children: [
                          buildButton('a'),
                          buildButton('s'),
                          buildButton('d'),
                          buildButton('f'),
                          buildButton('g'),
                          buildButton('h'),
                          buildButton('j'),
                          buildButton('k'),
                          buildButton('l'),
                          buildButton('ç'),
                          buildButton('/'),
                          buildButtonCustom(Icons.keyboard_return),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.alphanumericHeight,
                      child: Row(
                        children: [
                          buildButtonCustom(Icons.arrow_upward),
                          buildButton('z'),
                          buildButton('x'),
                          buildButton('c'),
                          buildButton('v'),
                          buildButton('b'),
                          buildButton('n'),
                          buildButton('m'),
                          buildButton(','),
                          buildButton('.'),
                          buildButton(':'),
                          buildButtonCustom(Icons.arrow_upward),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.alphanumericHeight,
                      child: Row(
                        children: [
                          buildButton('.com'),
                          buildButton('.br'),
                          SizedBox(
                              width: size.width * 0.45,
                              child: buildBackSpaceCustom(Icons.space_bar)),
                          buildButton('_'),
                          buildButton('&'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black.withAlpha(110),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * widget.numericHeight,
                      child: Row(
                        children: [
                          buildButton('1'),
                          buildButton('2'),
                          buildButton('3'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.numericHeight,
                      child: Row(
                        children: [
                          buildButton('4'),
                          buildButton('5'),
                          buildButton('6'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.numericHeight,
                      child: Row(
                        children: [
                          buildButton('7'),
                          buildButton('8'),
                          buildButton('9'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * widget.numericHeight,
                      child: Row(
                        children: [
                          buildButton(','),
                          buildButton('0'),
                          buildButtonCustom(Icons.backspace),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
