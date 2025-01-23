import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:intl/intl.dart';

class ExpirationDateTrackerCalendar extends StatefulWidget {
  const ExpirationDateTrackerCalendar({super.key});

  @override
  _ExpirationDateTrackerCalendarState createState() =>
      _ExpirationDateTrackerCalendarState();
}

class _ExpirationDateTrackerCalendarState
    extends State<ExpirationDateTrackerCalendar> {
  final DateTime today = DateTime.now();
  late DateTime focusedDate;

  @override
  void initState() {
    super.initState();
    focusedDate = today;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with Month and Year
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    focusedDate = DateTime(
                      focusedDate.year,
                      focusedDate.month - 1,
                      1,
                    );
                  });
                },
              ),
              Text(
                DateFormat.yMMMM().format(focusedDate),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    focusedDate = DateTime(
                      focusedDate.year,
                      focusedDate.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
        ),
        // Calendar Grid
        SizedBox(
          height: 280,
          child: Container(
            padding: EdgeInsets.all(AppSizes.normalSpacing),
            decoration: BoxDecoration(
              color: const Color(0xFFEBE6E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Weekday labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    final day = DateFormat.E().format(
                      DateTime(2022, 1, index + 3),
                    );
                    return Text(
                      day,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                // Dates Grid
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: daysInMonth(focusedDate),
                    itemBuilder: (context, index) {
                      final date = DateTime(
                        focusedDate.year,
                        focusedDate.month,
                        index + 1,
                      );
                      final isToday = date.day == today.day &&
                          date.month == today.month &&
                          date.year == today.year;

                      return Container(
                        decoration: BoxDecoration(
                          color:
                              isToday ? Colors.green[200] : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  fontWeight: isToday
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isToday ? Colors.green : Colors.black,
                                ),
                              ),
                              if (isToday)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 20,
                                  color: Colors.green,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int daysInMonth(DateTime date) {
    // final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDayOfMonth = firstDayNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }
}
