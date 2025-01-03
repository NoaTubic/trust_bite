import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_app_bar.dart';
import 'package:food_safety/theme/fonts.dart';
import 'package:gap/gap.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EducationalContentSection extends StatelessWidget {
  final List<Map<String, String>> labels = [
    {
      "label": "Healthy eating",
      "url":
          "https://www.foodafactoflife.org.uk/14-16-years/healthy-eating-14-16-years/"
    },
    {
      "label": "Cooking",
      "url":
          "https://www.foodafactoflife.org.uk/14-16-years/cooking-14-16-years/"
    },
    {
      "label": "Food science",
      "url":
          "https://www.foodafactoflife.org.uk/14-16-years/food-science-14-16-years/"
    },
    {
      "label": "Consumer awareness",
      "url":
          "https://www.foodafactoflife.org.uk/14-16-years/consumer-awareness-14-16-years/"
    },
    {
      "label": "Where food comes from",
      "url":
          "https://www.foodafactoflife.org.uk/14-16-years/where-food-comes-from-14-16-years/"
    },
  ];

  EducationalContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Educational content',
          style: context.appTextStyles.headingsBold,
        ),
        Gap(AppSizes.smallSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: AppSizes.smallSpacing,
          children: List.generate(
            labels.length,
            (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewPage(url: labels[index]["url"]!),
                    ),
                  );
                },
                child: Text(
                  labels[index]["label"]!,
                  style: context.appTextStyles.normalText,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: Handle loading progress
          },
          onPageStarted: (String url) {
            // Optional: Handle page start
          },
          onPageFinished: (String url) {
            // Optional: Handle page finish
          },
          onHttpError: (HttpResponseError error) {
            // Optional: Handle HTTP errors
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://restricted-domain.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
