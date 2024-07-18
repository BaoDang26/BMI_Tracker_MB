import 'package:flutter/material.dart';

class ActivityIcon extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;
  final VoidCallback onPressed;

  const ActivityIcon({
    Key? key,
    this.icon,
    this.emoji,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: icon != null
                ? Icon(icon, size: 30, color: Colors.black)
                : Text(
                    emoji ?? '',
                    style: const TextStyle(fontSize: 30),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  color: Colors.black,
                ),
            label),
      ],
    );
  }
}
