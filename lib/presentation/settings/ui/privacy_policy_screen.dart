import 'package:alpha_whales/app_exports.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, color: kSecondaryColor),
                  ),
                  Text("Privacy Policy", style: AppStyles.w700f20poppins),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              Text("Alpha Whales Policies", style: AppStyles.w600f18poppins),
              Text(
                "January 21, 2022",
                style: AppStyles.w400f12poppins.copyWith(color: kHintTextColor),
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, justo et laoreet efficitur,  purus lectus tristique metus, ut luctus libero arcu id tortor. Donec vel sem ut lacus bibendum tincidunt vel a libero. Sed cursus augue non massa pharetra, a scelerisque ligula ultricies. Suspendisse potenti. Aliquam erat volutpat. Integer auctor urna et mauris scelerisque, vitae tincidunt odio gravida. Proin ac felis id ligula tincidunt ullamcorper nec nec erat.rci p",
                style: AppStyles.w500f14poppins.copyWith(color: kLightGrayColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
