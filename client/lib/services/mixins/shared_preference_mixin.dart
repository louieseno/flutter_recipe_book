import 'package:client/services/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferenceMixin {
  Future<String?> getSortingValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKey.sortBy.name);
  }

  Future<bool> setSortingValue(String sort) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPrefKey.sortBy.name, sort);
  }

  Future<bool> clearSortingValue() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(SharedPrefKey.sortBy.name);
  }
}
