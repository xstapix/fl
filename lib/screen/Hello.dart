import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:go_router/go_router.dart';


class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  final ScrollController _controller = ScrollController();
  final ScrollController _controllerPhoto = ScrollController();
  var scrollPosition = 0.0;
  var scrollPhoto = 0.0;

  void _scrollRight() {
    if (scrollPosition < (MediaQuery.of(context).size.width - 32) * 3) {
      scrollPosition = scrollPosition + MediaQuery.of(context).size.width - 32; 
      scrollPhoto = scrollPhoto + MediaQuery.of(context).size.width;
    }

    _controller.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );

    _controllerPhoto.animateTo(
      scrollPhoto,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _handlerCreateAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('account', 'test acc');
    context.go('/camera');
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            controller: _controllerPhoto,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/m.jpg"), fit: BoxFit.cover),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/n.jpg"), fit: BoxFit.cover),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/g.jpg"), fit: BoxFit.cover),
                ),
              ),
            ]
          ),
          Positioned(
            bottom: 0,
            left:0, right:0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 13, 0, 87),
                borderRadius: BorderRadius.vertical(top: Radius.circular(17))
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16 ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            child: const Column(
                              children: [
                                Text(
                                  'Find The Profossional Photographer For Your',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24
                                  ),
                                ),
                                Text(
                                  'Platform That Provides Mony Kinds Of',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                ),
                              ]
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            child: const Column(
                              children: [
                                Text(
                                  'Capture Moment From Today',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24
                                  ),
                                ),
                                Text(
                                  'Capture the Beauty Of Your Jour',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                ),
                              ]
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            child: Column(
                              children: [
                                Text(
                                  'Welcome to create account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _handlerCreateAccount();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 40),
                                    padding: EdgeInsets.all(12),
                                    width: MediaQuery.of(context).size.width - 40,
                                    child: Center(
                                      child: Text(
                                        'Create account'
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                )
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('skip', style: TextStyle(color: Colors.white, fontSize: 15))
                          )
                        ),
                        InkWell(
                          onTap: () {
                            _scrollRight();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('next', style: TextStyle(color: Colors.white, fontSize: 15))
                          )
                        )
                      ],
                    )
                  ],
                ),
              )
            )
          )
        ],
      )
    );
  }
}