import 'package:flutter/material.dart';

import 'databaseHelper.dart';
import 'model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();

// // Retrieve all data
  List<MyData> users = [];

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: dbHelper.getAllData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.data!.isEmpty) {
                    return const Text("something went wrong");
                  } else if (snapshot.hasError) {
                    return const Text("error occured");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle:
                              Text("Age is : ${snapshot.data![index].age}"),
                        );
                      },
                    );
                  }
                }),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Insert data
                  MyData data = MyData(
                    name: nameController.value.text,
                    age: int.parse(ageController.value.text),
                  );
                  await dbHelper.insertData(data);
                  print("added from view");
                  setState(() {});
                },
                child: const Text("Write Data"),
              ),
              ElevatedButton(
                onPressed: () async {
                  users = await dbHelper.getAllData();
                },
                child: const Text("Read Data"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Age",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
