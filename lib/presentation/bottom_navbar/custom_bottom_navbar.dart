import '/app_exports.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int index;

  const CustomBottomNavBar({super.key, this.index = 0});

  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late final ValueNotifier<int> _selectedIndexNotifier;

  @override
  void initState() {
    super.initState();
    _selectedIndexNotifier = ValueNotifier<int>(widget.index);
  }

  @override
  void dispose() {
    _selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,result) async {
        if (_selectedIndexNotifier.value != 0) {
          _selectedIndexNotifier.value = 0;
        } else {
          Navigator.of(context).maybePop();
        }
      },
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedIndexNotifier,
        builder: (context, selectedIndex, _) {
          return Scaffold(
            body: _getSelectedWidget(selectedIndex),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: kBgColor,
                border: const Border(
                  top: BorderSide(
                    color: Color(0x30000000),
                    width: 0.33,
                  ),
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  items: [
                    _buildBottomNavigationBarItem(
                      activeIcon: Assets.svgAssetsSelectedHome,
                      inactiveIcon: Assets.svgAssetsUnselectedHome,
                      label: 'Home',
                      index: 0,
                      isIconData: false,
                      selectedIndex: selectedIndex,
                    ),
                    _buildBottomNavigationBarItem(
                      activeIcon: Assets.svgAssetsSelectedInsider,
                      inactiveIcon: Assets.svgAssetsUnselectedInsider,
                      label: 'Insider',
                      index: 1,
                      isIconData: false,
                      selectedIndex: selectedIndex,
                    ),
                    _buildBottomNavigationBarItem(
                      activeIcon: Assets.svgAssetsSelectedWhale,
                      inactiveIcon: Assets.svgAssetsUnselectedWhale,
                      label: 'Whale List',
                      index: 2,
                      isIconData: false,
                      selectedIndex: selectedIndex,
                    ),
                    _buildBottomNavigationBarItem(
                      activeIcon: Assets.svgAssetsSelectedAlert,
                      inactiveIcon: Assets.svgAssetsUnselectedAlert,
                      label: 'Alerts',
                      index: 3,
                      isIconData: false,
                      selectedIndex: selectedIndex,
                    ),
                    _buildBottomNavigationBarItem(
                      activeIcon: Assets.svgAssetsSelectedCnbc,
                      inactiveIcon: Assets.svgAssetsUnselectedCnbc,
                      label: 'CNBC Alerts',
                      index: 4,
                      isIconData: false,
                      selectedIndex: selectedIndex,
                    ),
                  ],
                  currentIndex: selectedIndex,
                  selectedLabelStyle: AppStyles.w600f10poppins.copyWith(
                    color: kSecondaryColor,
                  ),
                  unselectedLabelStyle: AppStyles.w500f10poppins.copyWith(
                    color: kUnSelectedNavColor,
                  ),
                  selectedItemColor: kSecondaryColor,
                  unselectedItemColor: kUnSelectedNavColor,
                  onTap: (index) => _selectedIndexNotifier.value = index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required dynamic activeIcon,
    required dynamic inactiveIcon,
    required String label,
    required int index,
    required int selectedIndex,
    bool isIconData = false,
  }) {
    Widget iconWidget;

    if (isIconData) {
      iconWidget = Icon(
        selectedIndex == index ? activeIcon : inactiveIcon,
        color: selectedIndex == index ? kSecondaryColor : kUnSelectedNavColor,
      );
    } else {
      iconWidget = Padding(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(6)),
        child: SvgPicture.asset(
          selectedIndex == index ? activeIcon : inactiveIcon,
          colorFilter: ColorFilter.mode(
            selectedIndex == index ? kSecondaryColor : kUnSelectedNavColor,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    return BottomNavigationBarItem(
      icon: iconWidget,
      label: label,
    );
  }

  Widget _getSelectedWidget(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const InsiderScreen();
      case 2:
        return const WhaleListScreen();
      case 3:
        return const AlertScreen();
      case 4:
        return const CNBCScreen();
      default:
        return const HomeScreen();
    }
  }
}
