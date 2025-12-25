import 'app_exports.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(0xFF01386C, color),
      ),
      scaffoldBackgroundColor: kScaffoldColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: kWhiteColor,
        surfaceTintColor: kWhiteColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // white icons
          statusBarBrightness: Brightness.dark, // iOS contrast
        ),
      ));
}
