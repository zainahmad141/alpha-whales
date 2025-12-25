import '../../../app_exports.dart';

class OnboardingPageThree extends StatefulWidget {
  const OnboardingPageThree({super.key});

  @override
  State<OnboardingPageThree> createState() => _OnboardingPageThreeState();
}

class _OnboardingPageThreeState extends State<OnboardingPageThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: getProportionateScreenHeight(16),
      children: [
        Text("Explore Stock Insights", style: AppStyles.w600f32poppins),
        Text(
          textAlign: TextAlign.center,
          "Dive into detailed stock analysis,\n including top investor activity,\n performance metrics, and potential\n opportunities.",
          style: AppStyles.w400f14poppins.copyWith(
            fontSize: 16,
            color: kLightGrayColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(25),),
        Image.asset(Assets.pngAssetsStockLaptop)
      ],
    );
  }
}
