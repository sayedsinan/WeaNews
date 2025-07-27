import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Colors.white,
        padding: padding,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
