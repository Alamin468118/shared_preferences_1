import 'package:flutter/material.dart';
import 'package:shared_preferences_by_kilo_loco/model/model.dart';
import 'package:shared_preferences_by_kilo_loco/preferences_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _preferencesServices = PreferencesServices();
  final _usernameController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguages = Set<ProgrammingLanguage>();
  var _isEmployed = false;

  @override
  void initState() {
    super.initState();
    populateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
          ),
          RadioListTile(
            title: const Text("FEMALE"),
            value: Gender.FEMALE,
            groupValue: _selectedGender,
            onChanged: (newValue) => setState(() => _selectedGender),
          ),
          RadioListTile(
            title: const Text("MALE"),
            value: Gender.MALE,
            groupValue: _selectedGender,
            onChanged: (newValue) => setState(() => _selectedGender),
          ),
          CheckboxListTile(
              title: Text('Dart'),
              value: _selectedLanguages.contains(ProgrammingLanguage.DART),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.DART)
                      ? _selectedLanguages.remove(ProgrammingLanguage.DART)
                      : _selectedLanguages.add(ProgrammingLanguage.DART);
                });
              }),
          CheckboxListTile(
              title: Text('JAVASCRIPT'),
              value:
                  _selectedLanguages.contains(ProgrammingLanguage.JAVASCRIPT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.JAVASCRIPT)
                      ? _selectedLanguages
                          .remove(ProgrammingLanguage.JAVASCRIPT)
                      : _selectedLanguages.add(ProgrammingLanguage.JAVASCRIPT);
                });
              }),
          CheckboxListTile(
              title: Text('KOTLIN'),
              value: _selectedLanguages.contains(ProgrammingLanguage.KOTLIN),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.KOTLIN)
                      ? _selectedLanguages.remove(ProgrammingLanguage.KOTLIN)
                      : _selectedLanguages.add(ProgrammingLanguage.KOTLIN);
                });
              }),
          CheckboxListTile(
              title: Text('SWIFT'),
              value: _selectedLanguages.contains(ProgrammingLanguage.SWIFT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.SWIFT)
                      ? _selectedLanguages.remove(ProgrammingLanguage.SWIFT)
                      : _selectedLanguages.add(ProgrammingLanguage.SWIFT);
                });
              }),
          SwitchListTile(
            title: Text('Is Employed'),
            value: _isEmployed,
            onChanged: (newValue) => setState(() => _isEmployed = newValue),
          ),
          TextButton(onPressed: _saveSettings, child: Text('Save Settings')),
        ],
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
        Username: _usernameController.text,
        gender: _selectedGender,
        programmingLanguages: _selectedLanguages,
        isEmployed: _isEmployed);
    print(newSettings);
    _preferencesServices.saveSettings(newSettings);
  }

  void populateFields() async {
    final settings = await _preferencesServices.getSettings();
    setState(() {
      _usernameController.text = settings.Username;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.programmingLanguages;
      _isEmployed = settings.isEmployed;
    });
  }
}
