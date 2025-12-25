import '../../app_exports.dart';

class CustomProfileField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomProfileField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool internalReadOnly = readOnly || (onTap != null);

    Widget textFieldWidget = TextField(
      controller: controller,
      obscureText: obscureText,
      readOnly: internalReadOnly,
      onTap: internalReadOnly && onTap != null ? onTap : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.w500f16poppins.copyWith(color: kFieldHintTextColor),
        border: InputBorder.none,
        icon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: prefixIcon == null
            ? EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10))
            : EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      ),
      style: AppStyles.w500f16poppins,
    );

    Widget fieldStack = Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: getProportionateScreenHeight(15)),
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kPrimaryColor),
          ),
          child: textFieldWidget,
        ),
        Positioned(
          left: getProportionateScreenWidth(16),
          top: getProportionateScreenHeight(10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              title,
              style: AppStyles.w500f16poppins.copyWith(
                fontSize: 8,
                fontWeight: FontWeight.w300,
                color: kSecondaryColor,
              ),
            ),
          ),
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: IgnorePointer(
          ignoring: internalReadOnly,
          child: fieldStack,
        ),
      );
    }

    return fieldStack;
  }
}