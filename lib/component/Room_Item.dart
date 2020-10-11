import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/Screen/OverViewScreen.dart';
import 'package:room_finder/Screen/RoomDetailScreen.dart';
import 'package:room_finder/provider/room.dart';

class RoomItem extends StatefulWidget {
  @override
  _RoomItemState createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Room>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              left: 12,
              right: 12,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Text(
                            ' For ${loadedProduct.forWhom} ',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.message,
                        ),
                      ),
                      IconButton(
                        icon: loadedProduct.isFavourite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                              ),
                        onPressed: () {
                          setState(() {
                            loadedProduct.toggleIsFavourite();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0)
                  ]),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoomDetailScreen.routName,
                            arguments: loadedProduct.id);
                      },
                      child: Image(
                        height: 220.0,
                        width: MediaQuery.of(context).size.width,
                        image: AssetImage(loadedProduct.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 9.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        'Rs ${loadedProduct.rent.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5.0,
                    bottom: 5.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 14.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              loadedProduct.placeName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
