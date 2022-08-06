// ignore_for_file: constant_identifier_names

enum Gender { FEMALE, MALE }

enum ProgrammingLanguage { DART, JAVASCRIPT, KOTLIN, SWIFT }

class Settings {
  final String Username;
  final Gender gender;
  final Set<ProgrammingLanguage> programmingLanguages;
  final bool isEmployed;
  Settings({
    required this.Username,
    required this.gender,
    required this.programmingLanguages,
    required this.isEmployed,
  });
}
