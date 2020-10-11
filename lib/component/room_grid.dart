import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/component/Room_Item.dart';
import 'package:room_finder/provider/room_provider.dart';

class RoomGridView extends StatelessWidget {
  final bool favourite;
  RoomGridView(this.favourite);
  @override
  Widget build(BuildContext context) {
    final rooms = favourite
        ? Provider.of<RoomProvider>(context).favourites
        : Provider.of<RoomProvider>(context).items;

    return GridView.builder(
      itemCount: rooms.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        childAspectRatio: 4 / 3,
      ),
      itemBuilder: (context, index) =>
          ChangeNotifierProvider.value(value: rooms[index], child: RoomItem()),
    );
  }
}
