import '../../../app_exports.dart';
import 'onboardingpage1.dart';
import 'onboardingpage2.dart';
import 'onboardingpage3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(35),
              bottom: getProportionateScreenHeight(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: const [
                      OnboardingPageOne(),
                      OnboardingPageTwo(),
                      OnboardingPageThree(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(5),
                      ),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? kSecondaryColor
                            : kPlaceHolderColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: CustomActionButton(
                    backgroundColor: kAppGradient,
                    buttonText: _currentPage == 2 ? "Get Started" : "Next",
                    onTap: () {
                      if (_currentPage == 2) {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteName.navBar,
                        );
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
