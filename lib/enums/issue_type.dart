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
