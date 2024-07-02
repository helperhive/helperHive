// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stacked/stacked.dart';
// import 'package:table_calendar/table_calendar.dart';


// // error while changing the date
// class CalendarTabView extends ViewModelWidget<AttendanceViewModel> {
//   const CalendarTabView({super.key});

//   @override
//   Widget build(BuildContext context, AttendanceViewModel viewModel) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         !viewModel.isLoading
//             ? Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 2),
//                     child: TableCalendar(
//                       key: key,
//                       pageJumpingEnabled: false,
//                       calendarFormat: CalendarFormat.week,
//                       headerStyle: HeaderStyle(
//                         formatButtonVisible: false,
//                         formatButtonShowsNext: false,
//                         titleCentered: false,
//                         titleTextStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_22.copyWith(
//                             color: const Color(0xFF1F2937),
//                           ),
//                         ),
//                         leftChevronVisible: false,
//                         rightChevronVisible: false,
//                         headerMargin: const EdgeInsets.only(bottom: 16.0),
//                         headerPadding: const EdgeInsets.only(bottom: 8.0),
//                       ),
//                       currentDay: DateTime.now(),
//                       firstDay: viewModel.isMember
//                           ? DateTime.now()
//                           : DateTime.now().subtract(const Duration(days: 364)),
//                       lastDay: DateTime.now().add(
//                         const Duration(days: 1460),
//                       ),
//                       focusedDay: viewModel.selectedDate!,
//                       selectedDayPredicate: (date) =>
//                           isSameDay(viewModel.selectedDate, date),
//                       startingDayOfWeek: StartingDayOfWeek.monday,
//                       daysOfWeekStyle: DaysOfWeekStyle(
//                         weekdayStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_16.copyWith(
//                             color: const Color(0xFF4B5563),
//                             letterSpacing: 0.50,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                       onDaySelected: (selectedDay, focusedDay) {
//                         viewModel.onDaySelected(selectedDay, focusedDay);
//                       },
//                       calendarStyle: CalendarStyle(
//                         defaultTextStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_16.copyWith(
//                             color: const Color(0xFF1F2937),
//                             letterSpacing: 0.50,
//                           ),
//                         ),
//                         outsideTextStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_16.copyWith(
//                             color: const Color(0xFF1F2937),
//                             letterSpacing: 0.50,
//                           ),
//                         ),
//                         weekendTextStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_16.copyWith(
//                             color: const Color(0xFF1F2937),
//                             letterSpacing: 0.50,
//                           ),
//                         ),
//                         todayTextStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_16.copyWith(
//                             color: const Color(0xFFE7319D),
//                             letterSpacing: 0.50,
//                           ),
//                         ),
//                         todayDecoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: mainColor,
//                             width: 1.0,
//                           ),
//                         ),
//                         selectedTextStyle: GoogleFonts.dmSans(
//                           textStyle: Styles.t500_16.copyWith(
//                             color: const Color(0xFFE7319D),
//                             letterSpacing: 0.50,
//                           ),
//                         ),
//                         isTodayHighlighted: true,
//                         selectedDecoration: const BoxDecoration(
//                           color: Color(0xFFFEE7F0),
//                           shape: BoxShape.circle,
//                           // borderRadius: BorderRadius.all(Radius.circular(8)),
//                         ),
//                         // markerDecoration: BoxDecoration(
//                         //   color: const Color(0xFFFCA5B1), // Pink color
//                         //   shape: BoxShape.circle,
//                         //   borderRadius: BorderRadius.circular(8.0),
//                         // ),
//                         // markerMargin:
//                         //     const EdgeInsets.symmetric(horizontal: 1.0),
//                         // markerSizeScale: 1,
//                         outsideDaysVisible: false,
//                       ),
//                       // calendarBuilders: CalendarBuilders(
//                       //   prioritizedBuilder: (context, day, focusedDay) {
//                       //     // for (DateTime d in widget.toHighlight) {
//                       //     if (day.day == focusedDay.day &&
//                       //         day.month == focusedDay.month &&
//                       //         day.year == focusedDay.year) {
//                       //       return Stack(
//                       //         children: [
//                       //           Positioned(
//                       //             top: 0,
//                       //             right: 0,
//                       //             child: Container(
//                       //               decoration: const BoxDecoration(
//                       //                 color: Colors.blue,
//                       //                 borderRadius: BorderRadius.all(
//                       //                   Radius.circular(8.0),
//                       //                 ),
//                       //               ),
//                       //               child: Center(
//                       //                 child: Text(
//                       //                   '${day.day}',
//                       //                   style: const TextStyle(
//                       //                       color: Colors.white),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       );
//                       //       // }
//                       //     }
//                       //     return null;
//                       //   },
//                       // ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 24,
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             // showCalendarDialog(context, viewModel);

//                             viewModel.showAttendanceDialog();
//                           },
//                           child: SvgPicture.asset(
//                             AssetUtil.icLightCalendarSvg,
//                             width: 24.0,
//                             height: 24.0,
//                             colorFilter: const ColorFilter.mode(
//                                 greenColor, BlendMode.srcIn),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             : const SizedBox(width: 10, height: 10),
//       ],
//     );
//   }

//   void showCalendarDialog(BuildContext context, AttendanceViewModel viewModel) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final helperService = locator<HelperService>();
//         return AlertDialog(
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
//           content: SizedBox(
//             // height: 300,
//             width: helperService.getWidth(0.8, context),
//             // padding: const EdgeInsets.all(4),
//             child: AbsorbPointer(
//               // absorbing:
//               // viewModel.attendanceStatusValue == AttendanceStatus.present,
//               child: CalendarDatePicker2(
//                 config: CalendarDatePicker2Config(
//                   currentDate: DateTime.now(),
//                   calendarType: CalendarDatePicker2Type.multi,
//                   selectedDayHighlightColor: Colors.grey,
//                   selectedDayTextStyle: GoogleFonts.dmSans(
//                     color: const Color(0xFFE7319D),
//                     fontSize: 17.0,
//                   ),
//                   selectedRangeHighlightColor: const Color(0xFFFFE9F6),
//                   selectedRangeDayTextStyle: GoogleFonts.dmSans(
//                     color: const Color(0xFFE7319D),
//                     fontSize: 16.0,
//                   ),
//                   dayBuilder: ({
//                     required DateTime date,
//                     BoxDecoration? decoration,
//                     bool? isDisabled,
//                     bool? isSelected,
//                     bool? isToday,
//                     TextStyle? textStyle,
//                   }) {
//                     bool isDateAvailable =
//                         !viewModel.attendanceMap.containsKey(date);

//                     if (!isDateAvailable) {
//                       if (isSelected!) {
//                         textStyle = GoogleFonts.dmSans(
//                           color: const Color(0xFF374151),
//                           fontSize: 16.0,
//                         );
//                       }
//                       return CustomEventCalendarWidget(
//                         date: date,
//                         isDisabled: isDisabled,
//                         isSelected: isSelected,
//                         isToday: isToday,
//                         textStyle: textStyle,
//                         attendanceStatus: viewModel.attendanceMap[
//                             date], // Provide the appropriate attendance status here
//                       );
//                     }

//                     if (viewModel.attendanceMap.containsKey(date)) {
//                       isDisabled = true;
//                     }
//                     // Determine if there's an event on this date
//                     bool? hasEvent = isSelected;

//                     // Return widget if there's an event, else return null
//                     if (hasEvent!) {
//                       if (!viewModel.dates.contains(date)) {
//                         viewModel.addDate(date);
//                       }

//                       return CustomEventCalendarWidget(
//                         date: date,
//                         isDisabled: isDisabled,
//                         isSelected: isSelected,
//                         isToday: isToday,
//                         textStyle: textStyle,
//                         attendanceStatus: viewModel
//                             .attendanceStatusValue, // Provide the appropriate attendance status here
//                       );
//                     } else {
//                       return null;
//                     }
//                   },
//                   lastMonthIcon: SvgPicture.asset(
//                     AssetUtil.icArrowLeftSquareSvg,
//                     width: 26,
//                     height: 26,
//                   ),
//                   nextMonthIcon: SvgPicture.asset(
//                     AssetUtil.icArrowRightSquareSvg,
//                     width: 26,
//                     height: 26,
//                   ),
//                   dayTextStyle: GoogleFonts.dmSans(
//                     color: const Color(0xFF374151),
//                     fontSize: 16.0,
//                   ),
//                   weekdayLabelTextStyle: GoogleFonts.dmSans(
//                     color: const Color(0xFF1F2937),
//                     fontSize: 16.0,
//                   ),
//                   yearTextStyle: GoogleFonts.dmSans(
//                     color: const Color(0xFF111827),
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 value: viewModel.dates,
//                 // onValueChanged: viewModel.onDatesChanged,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }