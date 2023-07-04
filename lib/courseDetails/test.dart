import 'package:flutter/material.dart';

class TabLayoutExample extends StatefulWidget {
  const TabLayoutExample({Key? key}) : super(key: key);

  @override
  State<TabLayoutExample> createState() => _TabLayoutExampleState();
}

class _TabLayoutExampleState extends State<TabLayoutExample> with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          Text("wefioj"),
          Expanded(
            child: Column(
              children: [
                Container(
                  child:  TabBar(
                    controller: _tabController,
                    tabs: [
                      new Tab(
                        icon: const Icon(Icons.home),
                        text: 'Address',
                      ),
                      new Tab(
                        icon: const Icon(Icons.my_location),
                        text: 'Location',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80.0,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Card(
                        child:  ListTile(
                          leading: const Icon(Icons.home),
                          title:  TextField(
                            decoration: const InputDecoration(hintText: 'Search for address...'),
                          ),
                        ),
                      ),
                      Card(
                        child:  ListTile(
                          leading: const Icon(Icons.location_on),
                          title: new Text('Latitude: 48.09342\nLongitude: 11.23403'),
                          trailing: new IconButton(icon: const Icon(Icons.my_location), onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );


    // drawer: Drawer(
    //   // Add a ListView to the drawer. This ensures the user can scroll
    //   // through the options in the drawer if there isn't enough vertical
    //   // space to fit everything.
    //   child: ListView(
    //     // Important: Remove any padding from the ListView.
    //     padding: EdgeInsets.zero,
    //     children: [
    //       const DrawerHeader(
    //         decoration: BoxDecoration(
    //           color: Colors.blue,
    //         ),
    //         child: Text('Drawer Header'),
    //       ),
    //       ListTile(
    //         title: const Text('Item 1'),
    //         onTap: () {
    //           // Update the state of the app
    //           // ...
    //           // Then close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('Item 2'),
    //         onTap: () {
    //           // Update the state of the app
    //           // ...
    //           // Then close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //     ],
    //   ),
    // ),





    // return MaterialApp(
    //   home: Scaffold(
    //
    //     body: Column(
    //       children: [
    //         Container(
    //           child:  TabBar(
    //             controller: _tabController,
    //             tabs: [
    //               new Tab(
    //                 icon: const Icon(Icons.home),
    //                 text: 'Address',
    //               ),
    //               new Tab(
    //                 icon: const Icon(Icons.my_location),
    //                 text: 'Location',
    //               ),
    //             ],
    //           ),
    //         ),
    //          Container(
    //           height: 80.0,
    //           child: TabBarView(
    //             controller: _tabController,
    //             children: <Widget>[
    //               Card(
    //                 child:  ListTile(
    //                   leading: const Icon(Icons.home),
    //                   title:  TextField(
    //                     decoration: const InputDecoration(hintText: 'Search for address...'),
    //                   ),
    //                 ),
    //               ),
    //                Card(
    //                 child:  ListTile(
    //                   leading: const Icon(Icons.location_on),
    //                   title: new Text('Latitude: 48.09342\nLongitude: 11.23403'),
    //                   trailing: new IconButton(icon: const Icon(Icons.my_location), onPressed: () {}),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     )
    //   ),
    // );
  }
}