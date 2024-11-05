extension FirstName on String {
  String get firstName => split(' ').first;
}

extension LastName on String {
  String get lastName => split(' ').last;
}

extension Initials on String {
  String get initials => split(' ').map((e) => e[0]).join();
}
