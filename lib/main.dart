import 'package:flutter/material.dart';
import 'package:favors/favor.dart';

main() {
  runApp(FavorsApp());
}

class FavorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Favors application",
      home: FavorsPage(),
    );
  }
}

// class FavorsPage extends StatefulWidget {
//   FavorsPage({Key key}) : super(key: key);
//   @override
//   _FavorsPageState createState() => _FavorsPageState();
// }

// class _FavorsPageState extends State<FavorsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class FavorsPage extends StatelessWidget {
  // using mock values from mock_favors dart file for now
  final List<Favor> pendingAnswerFavors;
  final List<Favor> acceptedFavors;
  final List<Favor> completedFavors;
  final List<Favor> refusedFavors;

  FavorsPage(
      {Key key,
      this.pendingAnswerFavors,
      this.acceptedFavors,
      this.completedFavors,
      this.refusedFavors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Favors"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildCategoryTab("Requests"),
              _buildCategoryTab("Doing"),
              _buildCategoryTab("Completed"),
              _buildCategoryTab("Requested")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _favorsList("Pending Requests", pendingAnswerFavors),
            _favorsList("Doing", acceptedFavors),
            _favorsList("Completed", completedFavors),
            _favorsList("Refused", refusedFavors),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "Ask a favor",
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title) {
    return Tab(
      child: Text(title),
    );
  }

  Widget _favorsList(String title, List<Favor> favors) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          child: Text(title),
          padding: EdgeInsets.only(top: 16.0),
        ),
        Expanded(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: favors.length,
              itemBuilder: (BuildContext context, int index) {
                final favor = favors[index];
                return Card(
                  // key: ValueKey(favor.uuid),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Padding(
                    child: Column(
                      children: <Widget>[
                        _itemHeader(favor),
                        Text(favor.description),
                        _itemFooter(favor)
                      ],
                    ),
                    padding: EdgeInsets.all(8.0),
                  ),
                );
              }),
        )
      ],
    );
  }

  Row _itemHeader(Favor favor) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
            favor.friend.photoURL,
          ),
        ),
        Expanded(
          child: Padding(
            child: Text("${favor.friend.name} asked you to..."),
            padding: EdgeInsets.only(left: 8.0),
          ),
        )
      ],
    );
  }

  Widget _itemFooter(Favor favor) {
    if (favor.isCompleted) {
      // final format = DateFormat();
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        alignment: Alignment.centerRight,
        child: Chip(
          label: Text(
            "Completed at: 15/05/2021 15:30",
            // "Completed at: ${format.format(favor.completed)}"
          ),
        ),
      );
    }
    if (favor.isRequested) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("Refuse"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Do"),
            onPressed: () {},
          )
        ],
      );
    }
    if (favor.isDoing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("give up"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("cpmpleted"),
            onPressed: () {},
          )
        ],
      );
    }

    return Container();
  }
}
