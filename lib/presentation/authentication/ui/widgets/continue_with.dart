import 'package:alpha_whales/app_exports.dart';

class OrContinueWithDivider extends StatelessWidget {
  final String text;
  final Color textColor;
  final double height;
  final double indent;

  const OrContinueWithDivider({
    super.key,
    this.text = "Or continue with",
    this.textColor = Colors.white,
    this.height = 1,
    this.indent = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: height,
            margin: EdgeInsets.only(right: indent),
            decoration: const BoxDecoration(
              gradient: kDividerGradientLeft, 
            ),
          ),
        ),
        Text(
          text,
          style: AppStyles.w500f14poppins.copyWith(
            fontSize: 12,
            color: Color(0xffB6B6B6),
          ),
        ),
        Expanded(
          child: Container(
            height: height,
            margin: EdgeInsets.only(left: indent),
            decoration: const BoxDecoration(
              gradient: kDividerGradientRight,
            ),
          ),
        ),
      ],
    );
  }
}
