import 'package:alpha_whales/app_exports.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final ValueNotifier<bool> valueNotifier;
  final ValueChanged<bool>? onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.valueNotifier,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (context, value, _) {
        return Padding(
          padding: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(title, style: AppStyles.w500f16poppins),
            subtitle: subtitle != null ? Text(subtitle!) : null,
            subtitleTextStyle: AppStyles.w500f16poppins.copyWith(fontSize: 12,color: kMutedGrayColor),
            trailing: Switch(
              activeTrackColor: kSecondaryColor,
              inactiveTrackColor: kLightGrayColor,
              value: value,
              onChanged: (newValue) {
                valueNotifier.value = newValue;
                if (onChanged != null) onChanged!(newValue);
              },
            ),
          ),
        );
      },
    );
  }
}
