import '../../../app_exports.dart';
import '../data/list_data.dart';
import '../widgets/custom_whale_card.dart';

class WhaleListScreen extends StatefulWidget {
  const WhaleListScreen({super.key});

  @override
  State<WhaleListScreen> createState() => _WhaleListScreenState();
}

class _WhaleListScreenState extends State<WhaleListScreen> {
  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenHeight(12),
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Whales List", style: AppStyles.w700f20poppins),
            SizedBox(height: getProportionateScreenHeight(16)),
            SizedBox(
              height: getProportionateScreenHeight(80),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: avatarList.length,
                itemBuilder: (context, index) {
                  final avatar = avatarList[index];
                  return Padding(
                    padding: EdgeInsets.only(right: getProportionateScreenWidth(16)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.whaleDetail,
                          arguments: avatar,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kMutedGrayColor)
                        ),
                        child: CircleAvatar(
                          radius: getProportionateScreenWidth(32),
                          backgroundImage: AssetImage(avatar["imageUrl"]),
                          backgroundColor: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            ValueListenableBuilder<int>(
              valueListenable: selectedTab,
              builder: (context, currentIndex, _) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(8),
                        ),
                        child: CustomTabButton(
                          text: tabs[index],
                          isSelected: currentIndex == index,
                          onTap: () => selectedTab.value = index,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, currentIndex, _) {
                  final filteredWhales = currentIndex == 0
                      ? whales
                      : whales
                      .where((w) =>
                  w["tag"] == tabs[currentIndex])
                      .toList();

                  return ListView.builder(
                    itemCount: filteredWhales.length,
                    itemBuilder: (context, index) {
                      final whale = filteredWhales[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(12),
                        ),
                        child: WhaleCard(
                          name: whale["name"],
                          role: whale["role"],
                          imageUrl: whale["imageUrl"],
                          tag: whale["tag"],
                          convictionScore: whale["convictionScore"],
                          holdings: whale["holdings"],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}