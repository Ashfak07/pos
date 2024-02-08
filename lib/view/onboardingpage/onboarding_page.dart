import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos/view/bottomnav/bottom_navbar.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<String> _imagePaths = [
    "assets/lottie/chart.json",
    "assets/lottie/inventory.json",
  ];
  List<String> _titles = [
    "Welcome to our app! Get ready to explore insightful charts\n and analytics that provide a visual representation of your data.",
    "Start managing your inventory effortlessly with intuitive tools and real-time updates, ensuring you stay organized and in control of your stock.",
    "Get Started Now"
  ];
  List<String> _descriptions = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),

                        // gradient: LinearGradient(colors: [
                        //   Colors.black.withOpacity(.6),
                        //   Colors.black.withOpacity(.3)
                        // ]),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _titles[index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 139, 137, 137)),
                                )),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LottieBuilder.asset(
                                _imagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            SizedBox(height: 20.0),
            _currentPage == _imagePaths.length - 1
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bottomnav(),
                          ));
                    },
                    child: Text("Get Started"),
                  )
                : SizedBox(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _imagePaths.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: 8.0,
        width: isActive ? 24.0 : 8.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

// class OnboardingPage extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String description;

//   const OnboardingPage(
//       {Key? key,
//       required this.imagePath,
//       required this.title,
//       required this.description})
//       : super(key: key);

@override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/icons/Slice.png'),
        SizedBox(height: 30.0),
        Text(
          '',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Text(
          '',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    ),
  );
}
