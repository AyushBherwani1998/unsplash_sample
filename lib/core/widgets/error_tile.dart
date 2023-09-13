import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_sample/core/utils/string_constants.dart';

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
      leading: const Icon(CupertinoIcons.restart),
      title: const Text(errorText),
      subtitle: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: onTap,
    );
  }
}
