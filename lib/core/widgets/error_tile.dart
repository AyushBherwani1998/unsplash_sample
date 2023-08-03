import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  final VoidCallback onTap;
  final String message;

  const ErrorTile({
    super.key,
    required this.onTap,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message),
      onTap: onTap,
    );
  }
}
