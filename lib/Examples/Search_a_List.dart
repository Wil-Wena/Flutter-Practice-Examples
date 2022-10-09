import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Searching Example"),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchList())),
                child: const Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.search),
                ))
          ]),
      body: const Center(
          child: Text(
        "Click on the Search icon to perfom a search",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }
}

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  TextEditingController textEditingController = TextEditingController();

  //Database of Users
  final List<Map<String, dynamic>> usersDb = [
    {
      "id": "W",
      "name": "Wilson",
      "icon": Icon(Icons.call_merge),
      "time": "11:21 pm",
    },
    {
      "id": "M",
      "name": "May",
      "icon": Icon(Icons.call),
      "time": "10:00 am",
    },
    {
      "id": "H",
      "name": "Hamdia",
      "icon": Icon(Icons.missed_video_call),
      "time": "10:10 am",
    },
    {
      "id": "L",
      "name": "Lawrence",
      "icon": Icon(Icons.call_missed),
      "time": "1:20 pm",
    },
    {
      "id": "O",
      "name": "Owen",
      "icon": Icon(Icons.call_made),
      "time": "2:00 pm",
    },
    {
      "id": "F",
      "name": "Franca",
      "icon": Icon(Icons.call),
      "time": "4:00 pm",
    },
    {
      "id": "V",
      "name": "Val",
      "icon": Icon(Icons.call_missed_outgoing),
      "time": "6:00 pm",
    },
    {
      "id": "O",
      "name": "Owen",
      "icon": Icon(Icons.call_made),
      "time": "2:00 pm",
    },
    {
      "id": "E",
      "name": "Emmett",
      "icon": Icon(Icons.call_missed_outlined),
      "time": "9:00 pm",
    },
    {
      "id": "K",
      "name": "Kenneth",
      "icon": Icon(Icons.call_made),
      "time": "10:00 pm",
    },
  ];

  List<Map<String, dynamic>> foundUsers = [];
  @override
  void initState() {
    foundUsers = usersDb;
    super.initState();
  }

  //Filtering Search List
  void filter(String enteredKey) {
    List<Map<String, dynamic>> results = [];
    if (enteredKey.isEmpty) {
      results = usersDb;
    } else {
      results = usersDb
          .where((userName) =>
              userName["name"].toLowerCase().contains(enteredKey.toLowerCase()))
          .toList();
    }

    setState(() {
      foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          height: 35,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: TextField(
              onChanged: (value) => filter(value),
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    textEditingController.clear();
                    foundUsers = usersDb;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: foundUsers.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Recent",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )),
                    Expanded(
                        flex: 15,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: foundUsers.length,
                            itemBuilder: (context, index) => Card(
                                  borderOnForeground: false,
                                  key: ValueKey(foundUsers[index]["id"]),
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  child: ListTile(
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                          child: Text(
                                            foundUsers[index]["id"],
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      //CircleAvatar(
                                      //   backgroundColor: Colors.white30,
                                      //   foregroundColor: Colors.black,
                                      //   radius: 20,
                                      //   child: Text(
                                      //     foundUsers[index]["id"],
                                      //     style: TextStyle(fontSize: 20),
                                      //   ),
                                      // ),
                                      title: Text(
                                        foundUsers[index]["name"],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          foundUsers[index]["icon"],
                                          SizedBox(width: 5),
                                          Text("Mobile")
                                        ],
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Text(foundUsers[index]["time"]),
                                      )),
                                )))
                  ],
                )
              : Center(
                  child: Text("No results found"),
                )),
    );
  }
}
