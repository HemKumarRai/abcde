import 'package:flutter/cupertino.dart';
import 'package:room_finder/provider/room.dart';

class RoomProvider with ChangeNotifier {
  List<Room> _rooms = [
    Room(
        id: '1',
        description:
            'Room near balkumari with the facility of water and kdhafaja kdsahj asdfjhakhuierdaj jhasdkjfhkjahdfjjkasdfh'
            'ajdshhafjhauifafjkasd ashjdfjakshfui  electricityy',
        placeName: 'Gwarko',
        rent: 5000,
        isFavourite: false,
        phone: '98000000000',
        forWhom: "Girls",
        image: ('assets/images/ktm.jpg')),
    Room(
      id: '2',
      description:
          'Room near balkumari with the facility of water and electricityy',
      placeName: 'Balkumari',
      rent: 7000,
      isFavourite: false,
      forWhom: "boys",
      phone: '98000000000',
      image: ('assets/images/pokhara.jpg'),
    ),
    Room(
      id: '3',
      description:
          'Room near balkumari with the facility of water and electricityajfhajlndf;ajkny',
      placeName: 'Satdobato',
      rent: 6000,
      isFavourite: false,
      forWhom: " Office",
      phone: '98000000000',
      image: ('assets/images/mteverest.jpg'),
    ),
    Room(
        id: '4',
        description:
            'Room near balkumari with the facility of water and electricityy',
        placeName: 'Gwarko',
        rent: 5000,
        isFavourite: false,
        phone: '98000000000',
        forWhom: 'Students',
        image: ('assets/images/ktm.jpg')),
    Room(
      id: '5',
      description:
          'Room near balkumari with the facility of water and electricityy',
      placeName: 'Nepal',
      rent: 20000,
      isFavourite: false,
      phone: '98000000000',
      forWhom: 'Family',
      image: ('assets/images/chitawan.jpg'),
    ),
  ];
  List<Room> get items {
    return [..._rooms];
  }

  Room findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  List<Room> get favourites {
    return _rooms.where((roomItem) {
      return roomItem.isFavourite;
    }).toList();
  }

  void addRoom(Room room) {
    final newRoom = Room(
      forWhom: room.forWhom,
      id: DateTime.now().toIso8601String(),
      phone: room.phone,
      rent: room.rent,
      placeName: room.placeName,
      description: room.description,
      image: room.image,
    );
    _rooms.add(newRoom);
    notifyListeners();
  }

  void deleteRoom(String id) {
    _rooms.retainWhere((room) => room.id == id);
    notifyListeners();
  }
}
