import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSocialButton(Icons.facebook, onFacebookSignIn),
        const SizedBox(width: AppSizes.normalSpacing),
        _buildSocialButton(Icons.g_mobiledata, onGoogleSignIn, size: 40),
        const SizedBox(width: AppSizes.normalSpacing),
        _buildSocialButton(Icons.apple, onAppleSignIn),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback? onPressed,
      {double? size = 28}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size),
      color: Colors.black,
    );
  }
}
