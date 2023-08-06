import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';

class DetailsTile extends StatelessWidget {
  final ImageDetails imageDetails;

  const DetailsTile({super.key, required this.imageDetails});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          imageDetails.description,
          style: textTheme.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            const Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              imageDetails.likes.toString(),
              style: textTheme.bodySmall,
            )
          ],
        )
      ],
    );
  }
}
