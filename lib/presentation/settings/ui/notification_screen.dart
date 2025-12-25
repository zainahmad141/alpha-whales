
import '../../../app_exports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ValueNotifier<bool> _notifications = ValueNotifier(false);
  final ValueNotifier<bool> _darkMode = ValueNotifier(false);
  final ValueNotifier<bool> lightMode = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackIcon: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(12),
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            children: [
              Row(
                spacing: getProportionateScreenWidth(8),
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, color: kSecondaryColor),
                  ),
                  Text("Notifications", style: AppStyles.w700f20poppins),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomSwitchTile(
                title: "Whale Alerts",
                subtitle: "Get notified when top investors make moves",
                valueNotifier: _notifications,
                onChanged: (val) {},
              ),
              CustomSwitchTile(
                title: "Insider Alerts",
                subtitle: "Track executive buying an selling activity",
                valueNotifier: _darkMode,
                onChanged: (val) {},
              ),
              CustomSwitchTile(
                title: "CNBC Alerts",
                subtitle: "Latest picks from CNBC shows",
                valueNotifier: lightMode,
                onChanged: (val) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
