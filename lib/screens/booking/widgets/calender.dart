import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:helperhive/constants/toast.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTabBoking extends StatefulWidget {
  const CalendarTabBoking({super.key});

  @override
  State<CalendarTabBoking> createState() => _CalendarTabBokingState();
}

class _CalendarTabBokingState extends State<CalendarTabBoking> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  CalendarFormat format = CalendarFormat.week;
  bool isSelected = true;
  void isSelectedDateOk(DateTime selectedDate, DateTime focusedDate) {
    if (selectedDate
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      isSelected = false;
    } else {
      isSelected = true;
    }
  }

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
                pageJumpingEnabled: false,
                calendarFormat: format,
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
                firstDay: DateTime.now().subtract(
                  const Duration(days: 1460),
                ),
                lastDay: DateTime.now().add(
                  const Duration(days: 1460),
                ),
                focusedDay:
                    focusedDate, // You can replace this with your viewModel.selectedDate if needed
                selectedDayPredicate: (date) => isSameDay(
                    selectedDate, date), // Replace with your predicate
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
                  isSelectedDateOk(selectedDay, focusedDay);
                  if (!isSelected) {
                    toastMessage(
                        context: context,
                        message: 'Please select a valid date',
                        position: DelightSnackbarPosition.top,
                        messageColor: Colors.red,
                        leadingIcon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ));
                  } else {
                    setState(() {
                      selectedDate = selectedDay;
                      focusedDate = focusedDay;
                    });
                  }
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
                      setState(() {
                        if (format != CalendarFormat.month) {
                          format = CalendarFormat.month;
                        } else {
                          format = CalendarFormat.week;
                        }
                      });
                    },
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      size: 32,
                      color: Colors.blue,
                    ),
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
