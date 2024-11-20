import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/image_assets.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onFacebookSignIn;
  final VoidCallback? onAppleSignIn;

  const SocialLoginSection({
    super.key,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onAppleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppSizes.largeSpacing, bottom: AppSizes.mediumSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SocialButton(icon: ImageAssets.facebook),
          SizedBox(width: AppSizes.xlSpacing),
          SocialButton(icon: ImageAssets.google),
          SizedBox(width: AppSizes.xlSpacing),
          SocialButton(icon: ImageAssets.apple),
        ],
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final void Function()? onPressed;
  const SocialButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(icon),
    );
  }
}
