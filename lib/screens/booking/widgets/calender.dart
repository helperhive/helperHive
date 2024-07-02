import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTabBoking extends StatelessWidget {
  const CalendarTabBoking({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TableCalendar(
                key: key,
                pageJumpingEnabled: false,
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  formatButtonShowsNext: false,
                  titleCentered: false,
                  titleTextStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  headerMargin: const EdgeInsets.only(bottom: 16.0),
                  headerPadding: const EdgeInsets.only(bottom: 8.0),
                ),
                currentDay: DateTime.now(),
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(
                  const Duration(days: 1460),
                ),
                focusedDay: DateTime
                    .now(), // You can replace this with your viewModel.selectedDate if needed
                selectedDayPredicate: (date) => isSameDay(
                    DateTime.now(), date), // Replace with your predicate
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFF4B5563),
                      letterSpacing: 0.50,
                      fontSize: 15,
                    ),
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  // Implement your onDaySelected logic here
                },
                calendarStyle: CalendarStyle(
                  defaultTextStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFF1F2937),
                      letterSpacing: 0.50,
                    ),
                  ),
                  outsideTextStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFF1F2937),
                      letterSpacing: 0.50,
                    ),
                  ),
                  weekendTextStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFF1F2937),
                      letterSpacing: 0.50,
                    ),
                  ),
                  todayTextStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFFE7319D),
                      letterSpacing: 0.50,
                    ),
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green, // Replace with your mainColor
                      width: 1.0,
                    ),
                  ),
                  selectedTextStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: Color(0xFFE7319D),
                      letterSpacing: 0.50,
                    ),
                  ),
                  isTodayHighlighted: true,
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFFFEE7F0),
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
              ),
            ),
            Positioned(
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement your onTap logic here
                    },
                    child: const Icon(Icons.calendar_view_week_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
