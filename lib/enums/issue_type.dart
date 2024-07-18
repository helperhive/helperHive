import 'package:flutter/material.dart';

enum IssueType {
  easy,
  moderate,
  complex,
  notKnown;

  @override
  String toString() {
    return switch (this) {
      IssueType.easy => "Easy",
      IssueType.moderate => "Moderate",
      IssueType.complex => "Complex",
      IssueType.notKnown => "Not Known",
    };
  }
}

Color getIssueColor(IssueType issue) {
  switch (issue) {
    case IssueType.easy:
      return Colors.green;
    case IssueType.moderate:
      return Colors.orange;
    case IssueType.complex:
      return Colors.red;
    case IssueType.notKnown:
      return Colors.blue;
    default:
      throw Exception('Unexpected service: $issue');
  }
}

IconData getIssueIcon(IssueType issue) {
  switch (issue) {
    case IssueType.easy:
      return Icons.check_circle_outline;
    case IssueType.moderate:
      return Icons.warning;
    case IssueType.complex:
      return Icons.error;
    case IssueType.notKnown:
      return Icons.help_outline;
    default:
      throw Exception('Unexpected issue type: $issue');
  }
}
