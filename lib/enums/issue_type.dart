import 'package:flutter/material.dart';

enum IssueType {
  easy,
  moderate,
  complex;

  @override
  String toString() {
    return switch (this) {
      IssueType.easy => "Easy",
      IssueType.moderate => "Moderate",
      IssueType.complex => "Complex",
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
    default:
      throw Exception('Unexpected issue type: $issue');
  }
}
