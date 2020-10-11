import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/database/databaseMethods.dart';
import 'package:room_finder/provider/room_provider.dart';

class RoomDetailScreen extends StatefulWidget {
  static const routName = 'roomdetail_screen';

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  TextEditingController commentController = new TextEditingController();
  DataBaseMethods _dataBaseMethods = new DataBaseMethods();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    addComment() async {
      if (commentController.text.isNotEmpty) {
        try {
          Map<String, dynamic> commentMap = {
            'comments': commentController.text,
            'commentBy': FirebaseAuth.instance.currentUser(),
            'time': DateTime.now().millisecondsSinceEpoch,
          };
          await _dataBaseMethods.addComment(id, commentMap);
          commentController.clear();
        } catch (e) {}
      } else {
        return null;
      }
    }

    final loadedRoom = Provider.of<RoomProvider>(context).findById(id);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.3),
      appBar: AppBar(
        title: Text(loadedRoom.placeName),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(loadedRoom.image),
                ),
                SizedBox(
                  height: 2,
                ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white70,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Text(
                          loadedRoom.description,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Text(
                    "Comments",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
//                          borderRadius: BorderRadius.only(
//                            topRight: Radius.circular(30),
//                            topLeft: Radius.circular(30),
//                          )
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                      child: CommentList(id),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.white70,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                              controller: commentController,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightBlueAccent)),
                                  labelText: 'Add Comment...',
                                  labelStyle: TextStyle(fontSize: 20)),
                            )),
                            CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    addComment();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  final String id;
  CommentList(this.id);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  DataBaseMethods _dataBaseMethods = new DataBaseMethods();
  Stream commentStream;

  void initState() {
    getCommentStream();
    super.initState();
  }

  Future getCommentStream() async {
    await _dataBaseMethods.getComment(widget.id).then((val) {
      setState(() {
        commentStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return getCommentStream != null
        ? StreamBuilder(
            stream: commentStream,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return CommentListData(
                      snapshot.data.documents[index].data['comments'],
                    );
                  });
            },
          )
        : Container();
  }
}

class CommentListData extends StatelessWidget {
  final String comment;
  CommentListData(this.comment);

  @override
  Widget build(BuildContext context) {
    return comment.isNotEmpty
        ? Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(child: Text("Csit")),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                            ),
                            child: Text(
                              comment,
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
