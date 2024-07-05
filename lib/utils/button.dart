import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key? key,
    required this.iconData,
    required this.onClicked,
    required final this.index,
  }) : super(key: key) {
    // TODO: implement ButtonWidget
    throw UnimplementedError();
  }

  final IconData iconData;
  final VoidCallback onClicked;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(4, 97, 147, 1),
        elevation: 0,
      ),
      onPressed: ((index == 0 && iconData == Icons.arrow_back) ||
              (index == 2172 && iconData == Icons.arrow_forward))
          ? null
          : onClicked,
      child: Icon(iconData),
    );
  }
}
