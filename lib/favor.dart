import 'package:favors/friend.dart';
import 'package:flutter/cupertino.dart';

class Favor {
  String description;
  Friend friend;
  DateTime completed;
  bool isRequested;
  bool isDoing;
  bool isCompleted;
  Favor({Key key, this.description});
}
