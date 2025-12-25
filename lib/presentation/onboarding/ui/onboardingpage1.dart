import '../../../app_exports.dart';

class OnboardingPageOne extends StatefulWidget {
  const OnboardingPageOne({super.key});

  @override
  State<OnboardingPageOne> createState() => _OnboardingPageOneState();
}

class _OnboardingPageOneState extends State<OnboardingPageOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              Assets.pngAssetsAlphaWhalesSplashLogo,
              height: getProportionateScreenHeight(202),
            ),
          ),
        ),
      ],
    );
  }
}
