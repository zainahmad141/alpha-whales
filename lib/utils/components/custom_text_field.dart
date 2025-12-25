import 'dart:developer';
import 'package:alpha_whales/app_exports.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? fieldTitle;
  final String hintText;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final Color? prefixIconColor;
  final double? textHorizontalPadding;
  final int? maxLines, maxLength;
  final String? Function(String?)? validator;
  final bool? autoFocus, readOnly;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final double alphaColor;
  final TextStyle? hintTextStyle;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const CustomTextField({
    super.key,
    required this.controller,
    this.fieldTitle,
    required this.hintText,
    this.fillColor,
    this.borderColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.maxLines,
    this.validator,
    this.autoFocus,
    this.readOnly,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.maxLength,
    this.inputFormatters,
    this.textHorizontalPadding = 18,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.alphaColor = 0.8,
    this.hintTextStyle,
    this.borderRadius,
    this.textStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;
  final defaultBorderRadius = BorderRadius.circular(8);

  get key => widget.key;

  get validator => widget.validator;

  @override
  Widget build(BuildContext context) {
    final currentBorderRadius = widget.borderRadius ?? defaultBorderRadius;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldTitle != null &&
            widget.fieldTitle!.trim().isNotEmpty) ...[
          Text(
            widget.fieldTitle!,
            style: AppStyles.w400f14poppins.copyWith(
              fontWeight: FontWeight.w500,
              color: kWhiteColor,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: getProportionateScreenHeight(4)),
        ],
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(6),
            ),
            child: TextFormField(
              maxLength: widget.maxLength,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: widget.onTap,
              focusNode: widget.focusNode,
              onChanged: (value) {
                widget.onChanged?.call(value);
              },
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onFieldSubmitted: widget.onSubmitted,
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines ?? 1,
              autofocus: widget.autoFocus ?? false,
              readOnly: widget.readOnly ?? false,
              obscureText: widget.obscureText && hidePassword,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              style:
                  widget.textStyle ??
                  AppStyles.w400f12poppins.copyWith(
                    fontSize: 14,
                    color: kWhite2Color,
                  ),
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                counter: const SizedBox.shrink(),
                border: InputBorder.none,
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 17,
                          top: 18,
                          bottom: 18,
                        ),
                        child: widget.prefixIcon,
                      )
                    : null,
                prefixIconColor: widget.prefixIconColor,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 45,
                  minHeight: 45,
                ),
                suffixIcon:
                    widget.suffixIcon ??
                    (widget.obscureText
                        ? InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                              log(
                                'Hide Password: ${hidePassword && widget.obscureText}',
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(10),
                              ),
                              child: Icon(
                                color: kHintTextColor,
                                hidePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          )
                        : null),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: widget.prefixIcon == null
                      ? widget.textHorizontalPadding!
                      : 12,
                  vertical: getProportionateScreenHeight(13),
                ),
                isDense: true,
                alignLabelWithHint: true,
                errorStyle: AppStyles.w400f12poppins.copyWith(
                  color: kErrorColor,
                ),
                hintText: widget.hintText,
                hintStyle:
                    widget.hintTextStyle ??
                    AppStyles.w400f16inter.copyWith(
                      color: kHintTextColor,
                      fontSize: 14,
                    ),
                filled: true,
                fillColor: kBgColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: currentBorderRadius,
                  borderSide: BorderSide(
                    color: widget.borderColor ?? kMutedGrayColor,
                    width: 0.3,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: currentBorderRadius,
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: currentBorderRadius,
                  borderSide: BorderSide(
                    color: widget.borderColor ?? kMutedGrayColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: currentBorderRadius,
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: currentBorderRadius,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
