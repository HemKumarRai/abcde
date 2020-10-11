import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
        ),
      ),
      body: Container(
          color: Colors.blueGrey,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
//                              controller: searchController,
//                              style: simpleTextStyle(),
                  decoration: InputDecoration(
                      hintText: "Message...",
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 16),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              GestureDetector(
                onTap: () {
//                              initiateSearch();
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => SignUpScreen()));s
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(40)),
                    child: Image.asset('images/send.png')),
              )
            ],
          )),
    );
  }
}
