import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  List titles = [];
  List descriptions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            centerTitle: true,
            title: const Text('Home Page'),
            expandedHeight: 50,
            floating: true,
            backgroundColor: Colors.green[900],
          ),
        ],
        body: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, __) {
            return ExpansionTile(
              title: const Text(
                'Expansion Tile',
                style: TextStyle(fontSize: 20),
              ),
              leading: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,Expansion Tile,",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          },
          itemCount: 30,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.edit),
        backgroundColor: Colors.green[900],
      ),
    );
  }

  getPreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('title', []);
  }
}
