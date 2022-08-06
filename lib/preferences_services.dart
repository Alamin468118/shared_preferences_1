import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_by_kilo_loco/model/model.dart';

// save in shared preferences
class PreferencesServices {
  Future saveSettings(Settings settings) async {
    // technically we use future here because we are using async await
    // save

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', settings.Username);
    await preferences.setBool('isEmployed', settings.isEmployed);
    await preferences.setInt(
        'gender',
        settings.gender
            .index); // the reason why we use index is because we declare gender in enum in model.dart
    await preferences.setStringList(
        'programmingLanguages',
        settings.programmingLanguages
            .map((e) => e.index.toString())
            .toList()); //this one is because we use set in model.dart, so we need to convert it to list, and then convert it to string list

    print('saved Settings');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final username = preferences.getString('username');
    final isEmployed = preferences.getBool('isEmployed');
    final gender = Gender.values[preferences.getInt('gender') ??
        0]; // to ensure that we get the correct value, we use ?? 0. and not null
    final programmingLanguagesIndices =
        preferences.getStringList('programmingLanguages');
    // final programmingLanguages = programmingLanguagesIndices!
    //     .map((e) => ProgrammingLanguage.values[int.parse(e)])
    //     .toSet();
    final programmingLanguages = programmingLanguagesIndices!
        .map((e) => ProgrammingLanguage.values
            .firstWhere((element) => element.toString() == e))
        .toSet();

    return Settings(
      Username: username ?? '',
      gender: gender,
      isEmployed: isEmployed ?? false,
      programmingLanguages: programmingLanguages,
    );
  }
}
