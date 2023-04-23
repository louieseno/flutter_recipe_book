import 'package:client/services/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin MixinSharedPreference {
  Future<String?> getSortingValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKey.sortBy.name);
  }

  Future<bool> setSortingValue(SortByValue sort) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPrefKey.sortBy.name, sort.name);
  }

  Future<bool> clearSortingValue() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(SharedPrefKey.sortBy.name);
  }
}
