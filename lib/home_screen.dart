import 'package:flutter/material.dart';
import 'package:starbucks_animatedui/colors.dart';
import 'package:starbucks_animatedui/drink.dart';
import 'package:starbucks_animatedui/drinkcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  double pageOffset = 0;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildToolbar(),
            buildLogo(size),
            buildPager(size),
          ],
        ),
      ),
    );
  }

  Widget buildToolbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          SizedBox(width: 20),
          Icon(
            Icons.location_on,
            size: 30,
          ),
          Spacer(),
          Icon(
            Icons.list,
            size: 30,
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: Image.asset(
        'assets/Starbucks_Corporation_Logo_2011.svg.png',
        width: 50,
        height: 50,
      ),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: PageView.builder(
          controller: pageController,
          itemCount: getDrinks().length,
          itemBuilder: (context, index) {
            return DrinkCard(
              0,
              getDrinks()[index],
              pageOffset,
              index,
            );
          }),
    );
  }

  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(
      Drink(
        'Tirami',
        'Su',
        'assets/ChocolateTiramisu_03.png',
        'assets/chicco_2.png',
        'assets/chicco_1.png',
        'assets/chicco_4.png',
        'assets/frapuccino.png',
        'then top with whipped cream amd mocha drizzle to bring you endless \njava joy',
        Brownlight,
        mBrown,
      ),
    );
    list.add(
      Drink(
        'Green',
        'Tea',
        'assets/7beb936a9bd3499a5a86625a082c9fec.png',
        'assets/foglia_3.png',
        'assets/foglia_1.png',
        'assets/foglia_2.png',
        'assets/green tea frappuccino.png',
        'milk and ice and top it with sweetened whipped cream to give you a delicious boost of energy.',
        Brownlight,
        mBrown,
      ),
    );
    list.add(
      Drink(
        'Triple',
        'Mocha',
        'assets/340bed37f043b36d04ca979b1ab94829.png',
        'assets/chocolate_2.png',
        'assets/chocolate_3.png',
        'assets/chocolate_1.png',
        'assets/triple mocha frappuccino.png',
        'layers of whipped cream that\’s infused with cold brew, white chocolate mocha and dark caramel.',
        Brownlight,
        mBrown,
      ),
    );
    return list;
  }
}
