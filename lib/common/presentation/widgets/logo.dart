import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/common/presentation/app_sizes.dart';
import 'package:food_safety/common/presentation/build_context_extensions.dart';
import 'package:food_safety/common/presentation/image_assets.dart';

class Logo extends StatelessWidget {
  final double? size;
  final Color? color;

  const Logo({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: SvgPicture.asset(ImageAssets.logo,
          width: size ?? AppSizes.logoSize,
          height: size ?? AppSizes.logoSize,
          colorFilter: ColorFilter.mode(
            color ?? context.appColors.background!,
            BlendMode.srcIn,
          )),
    );
  }
}
