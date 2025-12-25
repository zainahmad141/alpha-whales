import '/app_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(12),
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Whale Moves", style: AppStyles.w700f20poppins),
              SizedBox(height: getProportionateScreenHeight(16)),
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: 3,
                itemBuilder: (context, index, realIndex) {
                  bool isActive = index == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.only(right: getProportionateScreenWidth(4),),
                    child: Transform.scale(
                      scale: isActive ? 1.0 : 0.95,
                      child: Material(
                        elevation: isActive ? 4 : 2,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        child: InvestorStockCard(
                          investorName: index == 0 ? "Warren Buffet" : index == 1 ? "Jeff Bezos" : "Sydney Sweeney",
                          timeAgo: "2 days ago",
                          companyTicker: index == 1 ? "MSFT" : "AAPL",
                          companyName: index == 1 ? "Microsoft Corp." : "Apple Inc.",
                          companyLogo: index == 0 ? Assets.svgAssetsAppleLogo : index == 1 ? Assets.svgAssetsMicrosoftLogo : Assets.svgAssetsTeslaLogo,
                          action: index == 1 ? "Buy" : "Sell",
                          amount: index == 1 ? "\$2.1M" : "\$1.3M",
                          convictionScore: index == 1 ? 0.85 : 0.79,
                          news: index == 1 ? "Bezos doubled MSFT exposure this quarter" : "Buffet doubled AAPL exposure this quarter",
                          investorImage: index == 0 ? Assets.pngAssetsWarrenBuffet : index == 1 ? Assets.pngAssetsWarrenBuffet :  Assets.pngAssetsWarrenBuffet,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: getProportionateScreenHeight(430),
                  viewportFraction: 0.75,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  padEnds: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Insider Buys", style: AppStyles.w700f20poppins),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomBottomNavBar(index: 1),
                        ),
                      );
                    },
                    child: Text(
                      "See All",
                      style: AppStyles.w500f14poppins.copyWith(
                        color: kSecondaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: kSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              ListView.builder(
                itemCount: insiderStockData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = insiderStockData[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(8),
                    ),
                    child: InsiderStockCard(
                      stockModel: data,
                    ),
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