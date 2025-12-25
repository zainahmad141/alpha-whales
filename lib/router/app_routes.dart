import 'package:alpha_whales/presentation/insider/ui/insider_screen.dart';
import 'package:alpha_whales/presentation/settings/ui/manage_profile_screen.dart';
import 'package:alpha_whales/presentation/settings/ui/notification_screen.dart';
import 'package:alpha_whales/presentation/settings/ui/privacy_policy_screen.dart';
import 'package:alpha_whales/presentation/settings/ui/settings_screen.dart';
import 'package:alpha_whales/presentation/settings/ui/terms_conditions_screen.dart';
import 'package:alpha_whales/presentation/whale/ui/whale_detail.dart';
import '../presentation/authentication/ui/forget_password_screen.dart';
import '../presentation/authentication/ui/sign_in_screen.dart';
import '../presentation/authentication/ui/sign_up_screen.dart';
import '../presentation/authentication/ui/verify_email_screen.dart';
import '../presentation/home/ui/home_screen.dart';
import '../presentation/onboarding/ui/onboarding_screen.dart';
import '../presentation/splash.dart';
import '/app_exports.dart';

class AppGenerateRoute {
  static Route<dynamic>? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.signIn:
        return _navigateScreen(const SignInScreen());
      case RouteName.signUp:
        return _navigateScreen(const SignUpScreen());
      case RouteName.forgetPassword:
        return _navigateScreen(const ForgetPasswordScreen());
      case RouteName.onBoarding:
        return _navigateScreen(const OnboardingScreen());
      case RouteName.homeScreen:
        return _navigateScreen(const HomeScreen());
      case RouteName.insider:
        return _navigateScreen(const InsiderScreen());
      case RouteName.whaleDetail:
        return _navigateScreen(const WhaleDetail());
      case RouteName.manageProfile:
        return _navigateScreen(const ManageProfileScreen());
      case RouteName.settings:
        return _navigateScreen(const SettingsScreen());
      case RouteName.verifyEmail:
        return _navigateScreen(const VerifyEmailScreen());
      case RouteName.terms:
        return _navigateScreen(const TermsConditionsScreen());
      case RouteName.privacyPolicy:
        return _navigateScreen(const PrivacyPolicyScreen());
      case RouteName.notificationScreen:
        return _navigateScreen(const NotificationScreen());
      case RouteName.navBar:
        return _navigateScreen(const CustomBottomNavBar(index: 0,));
      default:
        return _navigateScreen(const SplashScreen());
    }
  }

  static PageRouteBuilder _navigateScreen(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return customLeftSlideTransition(animation, child);
      },
    );
  }

  static Widget customLeftSlideTransition(Animation<double> animation, Widget child) {
    Tween<Offset> tween = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
    return SlideTransition(
      position: tween.animate(animation),
      child: child,
    );
  }
}

class RouteName {
  static const splash = "/splash";
  static const signIn = "/signIn";
  static const signUp = "/signUp";
  static const forgetPassword = "/forgetPassword";
  static const navBar = "/navBar";
  static const addNewCard = "/addNewCard";
  static const homeScreen = "/homeScreen";
  static const dotRegulationScreen = "/dotRegulationScreen";
  static const insider = "/insider";
  static const onBoarding = "/onBoarding";
  static const whaleDetail = "/whaleDetail";
  static const settings = "/settings";
  static const manageProfile = "/manageProfile";
  static const privacyPolicy = "/privacyPolicy";
  static const terms = "/terms";
  static const notificationScreen = "/notificationScreen";
  static const verifyEmail = "/verifyEmail";
}
