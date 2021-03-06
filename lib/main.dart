import 'dart:ui';
import 'package:animation_login/CustomGestureDetector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showBottomMenu = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _emailError = false, _passError = false, _loading = false;
  bool isDealer = true;



  @override
  Widget build(BuildContext context) {
    ThemeData _currentTheme = Theme.of(context);

    double height= MediaQuery.of(context).size.height;

// memberi default volicity 
    double threshold = 100;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // memanggil scroll ketika akan melakukan perubaahan axis 
        body: CustomGestureDetector( 
          // set axis default is y 
          axis: CustomGestureDetector.AXIS_Y, 
          //set default treshold 
          velocity: threshold, 
          // mengatur value ketika terjadi sweife up 
          onSwipeUp: (){
            this.setState((){
              showBottomMenu = true;
            });
          }, 
          // mengatur value ketika terjadi swifeDown
          onSwipeDown: (){
            this.setState((){
              showBottomMenu = false;
            });
          },
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[ 
                          // give title 
                          Text(
                            "RPS",
                            style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ), 
                          // make textfield 
                          TextField(
                            maxLines: 1,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: _currentTheme.primaryColor,
                              ),
                              errorText: (_emailError) ? "Invalid Email" : null,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ), 
                          // passwword 
                          TextField(
                            maxLines: 1,
                            controller: _passController,
                            obscureText: true,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Password",
                              errorText: (_passError) ? "Invalid Password" : null,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: _currentTheme.primaryColor,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              filled: false,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ), 
                          // confirm password 
                          TextField(
                            maxLines: 1,
                            controller: _passController,
                            obscureText: true,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              errorText: (_passError) ? "Invalid Password" : null,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: _currentTheme.primaryColor,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              filled: false,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 1,
                            controller: _passController, 
                            // set textfield tidak disembunyikan 
                            obscureText: false,
                            cursorColor: _currentTheme.accentColor,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              errorText: (_passError) ? "Invalid Password" : null, 
                              // pluss icon 
                              prefixIcon: Icon(
                                Icons.person_pin,
                                color: _currentTheme.primaryColor,
                              ), 
                              // add underline input border 
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              filled: false,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AbsorbPointer(
                            absorbing: _loading,
                            child: SizedBox(
                              width: double.infinity,
                              child: MaterialButton(
                                color: _currentTheme.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "LOGIN",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  String email = _emailController.text.trim();
                                  String pass = _passController.text.trim();
                                  this.setState(() {
                                    _emailError = email == "";
                                    _passError = pass == "";
                                  });
                                  if (!(_emailError || _passError)) {}
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Skip Login >",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                
                // set animation 
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: (showBottomMenu)?1.0:0.0,
                child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
                  child: Container( 
                    height: showBottomMenu== true? double.infinity : 0.0,
                    color: Colors.black.withOpacity(0.2),
                  ),),
                ),

                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 200),
                  left: 0,
                    bottom: (showBottomMenu)?-60:-(height/3),
                    child: MenuWidget())

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // membuat layout memiliki lengkung pada atas kanan kiri 
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        color: Colors.deepOrangeAccent,
        width: width,
        height: height/3 + 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.keyboard_arrow_up,
                size: 20,
              ),
              Text(
                "Social Logins",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Choose whichever you use frequently!",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "LOGIN WITH GOOGLE",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "LOGIN WITH FACEBOOK",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.lightBlue.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "LOGIN WITH TWITTER",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





