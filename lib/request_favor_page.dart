import 'package:favors/friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestFavorPage extends StatelessWidget {
  final List<Friend> friends;

  RequestFavorPage({Key key, this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requesting a favor"),
        leading: CloseButton(),
        actions: <Widget>[
          FlatButton(
            child: Text("SAVE"),
            textColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownButtonFormField(
            items: friends.map(
              (f) => DropdownMenuItem(
                child: Text(f.name),
              )
            ).toList(),
          ),
          TextFormField(
            maxLines: 5,
            inputFormatters: [LengthLimitingTextInputFormatter(200)],
            
          )
        ],
      ),
    );
  }
}
