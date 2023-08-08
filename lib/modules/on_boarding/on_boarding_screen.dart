import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sopping_app/modules/login/login_screen.dart';
import 'package:sopping_app/shared/component/components.dart';
import 'package:sopping_app/shared/network/local/cache_helper.dart';
import 'package:sopping_app/shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Boarding 1 Title',
        body: 'On Boarding 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Boarding 2 Title',
        body: 'On Boarding 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Boarding 3 Title',
        body: 'On Boarding 3 Body'),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  var isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [defaultTextButton(function: submit, text: 'SKIP')]),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        expansionFactor: 3,
                        spacing: 5.0,
                        activeDotColor: defaultColor,
                      ),
                      count: boarding.length),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(height: 30.0),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
        ],
      );
}
