import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  ReusableRow({super.key, required this.title, required this.value});
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            value,
          ),
        ],
      ),
    );
  }
}
