import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/Screen/OverViewScreen.dart';
import 'package:room_finder/Screen/signInScreen.dart';
import 'package:room_finder/database/databaseMethods.dart';
import 'package:room_finder/helper/decoration.dart';
import 'package:room_finder/helper/helper_function.dart';
import 'package:room_finder/provider/authProvider.dart';

class SignUpScreen extends StatefulWidget {
  static const routName = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameEditingController = new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  HelperFunction _helperFunction = new HelperFunction();

  signMeUp() async {
    if (formKey.currentState.validate()) {
      Map<String, String> userMap = {
        "name": userNameEditingController.text,
        'email': emailTextEditingController.text,
        'role': 'client',
      };
      dataBaseMethods.addUserInfo(userMap);
      await Provider.of<Auth>(context, listen: false).signUp(
          emailTextEditingController.text, passwordTextEditingController.text);
      Navigator.pushNamed(context, RoomsOverviewScreen.routName);

      setState(() {
        isLoading = true;
      });

      _helperFunction.saveUserLoggedInKey(true);
      _helperFunction.saveUserNameKey(userNameEditingController.text);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    TextFormField(
                      decoration: textInputDecoration('UserName'),
                      validator: (val) {
                        return val.length < 3
                            ? "The username must contain 3 digit"
                            : null;
                      },
                      controller: userNameEditingController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: true,
                    ),
                    TextFormField(
                      decoration: textInputDecoration('Email'),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.13457'*+-/=?^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Provide a valid UserEmail";
                      },
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: true,
                    ),
                    TextFormField(
                      decoration: textInputDecoration('PAssword'),
                      validator: (val) {
                        return val.length < 6
                            ? "The password must contain 6 digit"
                            : null;
                      },
                      controller: passwordTextEditingController,
                      obscureText: true,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signMeUp();
                      },
                      child: GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(19)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(19)),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Text(
                          "Sign Up with Google",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignInScreen.routName);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 14),
                            child: Text(
                              "SignIn now",
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ),
    );
  }
}
