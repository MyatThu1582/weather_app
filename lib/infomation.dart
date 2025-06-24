import 'package:flutter/material.dart';
class Infomations extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const Infomations({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            icon,
            size: 35,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w100
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
              style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 168, 168, 167),
              fontWeight: FontWeight.bold
              ),
          ),
        ],
      ),
    );
  }
}