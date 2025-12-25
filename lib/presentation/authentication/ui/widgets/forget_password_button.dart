import '/app_exports.dart';

class ForgetPasswordButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForgetPasswordButton({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(
            kGrey8EColor.withValues(alpha: 0.3),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
                horizontal: 8
            ),
          ),
          visualDensity:  VisualDensity(
            horizontal: -2,
            vertical: -4
          ),
        ),
        child: Text(
          "Forgot Password?",
          style: AppStyles.w500f14poppins.copyWith(
            fontSize: 12,
            color: kPlaceHolderColor,
          ),
        ),
      ),
    );
  }
}