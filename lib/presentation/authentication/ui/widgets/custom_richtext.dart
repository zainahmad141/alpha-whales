import 'package:alpha_whales/app_exports.dart';

class CustomRichText extends StatelessWidget {
  final String leadingText;
  final String actionText;
  final VoidCallback onTap;

  const CustomRichText({
    super.key,
    required this.leadingText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: leadingText,
        style: AppStyles.w400f14poppins.copyWith(color: kMutedGrayColor),
        children: [
          TextSpan(
            text: actionText,
            style: AppStyles.w600f16poppins.copyWith(fontSize: 14,color: kSecondaryColor,decoration: TextDecoration.underline,decorationColor: kSecondaryColor),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
