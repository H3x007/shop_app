import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/board_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/splash_1.png',
      title: 'Jawhara Shop',
      body: 'Welcome to Jawhara, Lets Shop!',
    ),
    BoardingModel(
      image: 'assets/images/splash_2.png',
      title: 'Jawhara Shop',
      body: 'We help people connect with store \naround Palestine.',
    ),
    BoardingModel(
      image: 'assets/images/splash_3.png',
      title: 'Jawhara Shop',
      body: 'We show the easy way to shop.\n Just stay at home with us.',
    ),
  ];

  var pageController = PageController(initialPage: 0);
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              submit(context);
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index){
                  if(index == boarding.length -1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemCount: boarding.length,
                itemBuilder: (context, index) => BoardingItem(
                  boardingModel: boarding[index],
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const ScaleEffect(
                    activeDotColor: defaultColor,
                  )
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast == true){
                      submit(context);
                    }else{
                      pageController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
