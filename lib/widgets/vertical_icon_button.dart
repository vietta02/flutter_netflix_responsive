import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const VerticalIconButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function(),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
