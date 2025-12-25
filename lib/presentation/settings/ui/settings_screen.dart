import 'package:alpha_whales/app_exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_dialogue.dart';
import '../widgets/custom_setting_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackIcon: false),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(12),
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: getProportionateScreenWidth(8),
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back, color: kSecondaryColor),
                  ),
                  Text("Settings", style: AppStyles.w700f20poppins),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              Text(
                "Main",
                style: AppStyles.w500f14poppins.copyWith(color: kWhiteColor),
              ),
              SizedBox(height: getProportionateScreenHeight(4)),
              CustomAccountCard(
                icon: Icons.person_2_outlined,
                title: "Account Details",
                subtitle: "Manage your account details",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.manageProfile);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              CustomAccountCard(
                icon: Icons.notifications,
                title: "Notifications",
                subtitle: "Manage your notification preferences",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.notificationScreen);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              Text(
                "Support",
                style: AppStyles.w500f14poppins.copyWith(color: kWhiteColor),
              ),
              SizedBox(height: getProportionateScreenHeight(4)),
              CustomAccountCard(
                icon: Icons.privacy_tip_rounded,
                title: "Privacy Policy",
                subtitle: "See the privacy policy of this app",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.privacyPolicy);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              CustomAccountCard(
                icon: Icons.file_copy_sharp,
                title: "Terms & Conditions",
                subtitle: "See the terms & conditions of this app",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.terms);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              Text(
                "Other",
                style: AppStyles.w500f14poppins.copyWith(color: kWhiteColor),
              ),
              SizedBox(height: getProportionateScreenHeight(4)),
          CustomAccountCard(
            icon: Icons.logout,
            title: "Logout",
            subtitle: "Sign-out your account",
            onTap: () {
              CustomDialog.show(
                context: context,
                title: 'Logout Account',
                message: 'Are you sure, you want to sign out?',
                confirmText: 'Logout',
                cancelText: 'Discard',
                onConfirm: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.signIn,
                        (route) => false,
                  );
                },
              );
            },
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
              CustomAccountCard(
                icon: Icons.delete_outlined,
                title: "Delete Account",
                subtitle: "Permanently delete your account",
                onTap: () {
                  CustomDialog.show(
                    context: context,
                    title: 'Delete Account?',
                    message: 'Deleting the account will permanently remove this account',
                    confirmText: 'Delete',
                    cancelText: 'Discard',
                    onConfirm: (){},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
