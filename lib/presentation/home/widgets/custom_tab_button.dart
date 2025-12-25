import 'package:alpha_whales/app_exports.dart';

class CustomTabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? kSecondaryColor : const Color(0xFF1C1F2E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.transparent : kHintTextColor,
            width: 1.2,
          ),
        ),
        child: Text(
          text,
          style: AppStyles.w500f14poppins.copyWith(
            color: isSelected ? const Color(0xff0B0F1A) : kMutedGrayColor,
          ),
        ),
      ),
    );
  }
}
