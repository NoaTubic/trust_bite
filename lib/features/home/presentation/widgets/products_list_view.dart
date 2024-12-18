import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/theme/fonts.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ProductListView extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image':
          'https://target.scene7.com/is/image/Target/GUEST_1729533f-5012-4e0e-800a-afd6f62914b8?wid=1200&hei=1200&qlt=80&fmt=pjpeg',
      'name': 'Chicken Breast',
      'description': 'Chicken Breast Small Pack',
      'daysLeft': '0'
    },
    {
      'image':
          'https://target.scene7.com/is/image/Target/GUEST_1729533f-5012-4e0e-800a-afd6f62914b8?wid=1200&hei=1200&qlt=80&fmt=pjpeg',
      'name': 'Chicken Breast',
      'description': 'Chicken Breast Small Pack',
      'daysLeft': '5'
    },
  ];

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEBE6E0),
                borderRadius: AppSizes.normalCircularBorderRadius,
              ),
              child: ListTile(
                leading: Image.network(
                  product['image'] ?? '',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  product['name'] ?? '',
                  style: context.appTextStyles.headingsBold!
                      .copyWith(fontSize: FontSizes.s16),
                ),
                subtitle: Text(product['description'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 1.5,
                      color: Colors.grey.shade400, // Vertical divider
                      margin: const EdgeInsets.only(right: 12),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'days left',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          product['daysLeft'] ?? '0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16), // Spacing between columns
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('E')
                              .format(DateTime.now())
                              .toLowerCase(), // Weekday in lowercase
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          DateFormat('d')
                              .format(DateTime.now()), // Day of the month
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Gap(AppSizes.normalSpacing),
    );
  }
}
