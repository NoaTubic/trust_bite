import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailsPage extends HookConsumerWidget {
  static const String routeName = '/product-details';
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = WebViewController();

    useEffect(() {
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              controller.runJavaScript(
                '''
                document.querySelector('.upper-nav').style.display = 'none';
                document.querySelector('.topbarsticky').style.display = 'none';
                document.querySelector('#prodNav').style.display = 'none';
                var mobileElement = document.getElementById('mobile-app-top-banner'); 
                  if (mobileElement) {
                    mobileElement.style.display = 'none';
                  }
                ''',
              );
            },
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        ..loadRequest(
          Uri.parse(
              'https://world.openfoodfacts.org/product/80895237/nutella-ferrero'),
        );
      return null;
    }, []);
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: WebViewWidget(controller: controller),
    );
  }
}
