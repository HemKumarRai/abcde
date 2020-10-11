import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/component/Room_Item.dart';
import 'package:room_finder/component/room_grid.dart';
import 'package:room_finder/provider/room.dart';
import 'package:room_finder/provider/room_provider.dart';
import 'package:room_finder/widget.dart';

enum FilterOptions { Favourites, All }

class RoomsOverviewScreen extends StatefulWidget {
  static const routName = 'overview_screen';
  @override
  _RoomsOverviewScreenState createState() => _RoomsOverviewScreenState();
}

class _RoomsOverviewScreenState extends State<RoomsOverviewScreen> {
  bool _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showFavourites
            ? Text("Your Favourites...")
            : Text("Available Rooms"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showFavourites = true;
                } else {
                  _showFavourites = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: FilterOptions.Favourites,
                child: Text('Show Your Favourites'),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              )
            ],
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      drawer: AppDrawer(),
      body: RoomGridView(_showFavourites),
    );
  }
}
