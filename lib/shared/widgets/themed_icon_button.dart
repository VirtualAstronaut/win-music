import 'package:flutter/material.dart';

class ThemedIconButton extends StatelessWidget {
  const ThemedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon.icon,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
