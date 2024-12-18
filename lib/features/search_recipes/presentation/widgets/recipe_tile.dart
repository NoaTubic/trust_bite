import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

class RecipeTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? content;

  const RecipeTile({
    super.key,
    required this.title,
    this.subtitle,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.smallSpacing),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppSizes.normalCircularBorderRadius,
          border: Border.all(
              color: context.appColors.primary!.withOpacity(0.7), width: 2.5),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: subtitle != null ? Text(subtitle!) : null,
            children: content != null ? [content!] : [],
          ),
        ),
      ),
    );
  }
}
