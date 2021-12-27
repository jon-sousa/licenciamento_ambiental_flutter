import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  static late final SharedPreferences _pref;
  static SharedPreferenceRepository? repository;

  SharedPreferenceRepository._(SharedPreferences pref) {
    _pref = pref;
  }

  static Future<SharedPreferenceRepository?> getInstance() async {
    var pref = await SharedPreferences.getInstance();

    repository ??= SharedPreferenceRepository._(pref);

    return repository;
  }

  void setToken(String token) {
    _pref.setString('token', token);
  }

  String getToken() {
    return _pref.getString('token') ?? '';
  }
}
