import '../../../app_exports.dart';
import '../../authentication/data/model/image_data.dart';
import '../widgets/custom_avatar_widget.dart';

class OnboardingPageTwo extends StatefulWidget {
  const OnboardingPageTwo({super.key});

  @override
  State<OnboardingPageTwo> createState() => _OnboardingPageTwoState();
}

class _OnboardingPageTwoState extends State<OnboardingPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Follow the 'Whales'", style: AppStyles.w600f32poppins),
        SizedBox(height: getProportionateScreenHeight(16)),
        Text(
          textAlign: TextAlign.center,
          "Track the investment moves of top\n investors and gain insights into their\n strategies.",
          style: AppStyles.w400f14poppins.copyWith(
            fontSize: 16,
            color: kLightGrayColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(60)),
        OverlappingAvatars(
          imageUrls: avatarImages,
          avatarSize: 80.0,
          overlapFactor: 0.8,
          maxAvatars: 5,
        ),
      ],
    );
  }
}
