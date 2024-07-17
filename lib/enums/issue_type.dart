import 'package:flutter/material.dart';

enum IssueType {
  easy,
  moderate,
  complex;

  @override
  String toString() {
    return switch (this) {
      IssueType.easy => "Easy",
      IssueType.moderate => "Moderste",
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
