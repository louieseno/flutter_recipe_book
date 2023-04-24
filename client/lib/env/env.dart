import 'package:envied/envied.dart';

part 'env.g.dart';

//  Here you can specify the path to your .env file
//  relative to the project root
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'X-RapidAPI-Key', obfuscate: true)
  static final rapidAPIKey = _Env.rapidAPIKey;
  @EnviedField(varName: 'X-RapidAPI-Host', obfuscate: true)
  static final rapidAPIHost = _Env.rapidAPIHost;
}
