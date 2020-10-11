import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/Screen/OverViewScreen.dart';
import 'package:room_finder/Screen/signUpScreen.dart';
import 'package:room_finder/helper/decoration.dart';
import 'package:room_finder/helper/helper_function.dart';
import 'package:room_finder/provider/authProvider.dart';

class SignInScreen extends StatefulWidget {
  static const routName = 'sign_in_screen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  HelperFunction helperFunction = new HelperFunction();

//  Widget authorizeAccess(BuildContext context) {
//    FirebaseAuth.instance.currentUser().then((user) {
//      Firestore.instance
//          .collection('users')
//          .where('uid', isEqualTo: user.uid)
//          .getDocuments()
//          .then((docs) {
//        if (docs.documents[0].exists) {
//          if (docs.documents[0].data['role'] == 'admin') {
//            return Text(
//              "Admin",
//              style: TextStyle(
//                color: Colors.red,
//              ),
//            );
//          } else {
//            Text(
//              "Not Admin",
//              style: TextStyle(
//                color: Colors.red,
//              ),
//            );
//          }
//        } else {
//          return Text("User not identified");
//        }
//      });
//    });
//  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      formKey.currentState.save();
      try {
        helperFunction.saveUserLoggedInKey(true);
//        await Provider.of<Auth>(context, listen: false).signIn(
//            emailTextEditingController.text,
//            passwordTextEditingController.text);
        return await Provider.of<Auth>(context).signIn(
            emailTextEditingController.text,
            passwordTextEditingController.text);
      } catch (e) {
        print(e.toString());
      }
      Navigator.of(context).pushReplacementNamed(RoomsOverviewScreen.routName);
      setState(() {
        isLoading = false;
      });
    }
  }

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
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
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
                        decoration: textInputDecoration('Password'),
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
                          signIn();
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
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Text(
                            "Sign In with Google",
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
                            "Don't have an account?",
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SignUpScreen.routName);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 14),
                              child: Text(
                                "Register now",
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
            ),
    );
  }
}
