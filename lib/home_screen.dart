// import 'package:flutter/material.dart';

// import 'databaseHelper.dart';
// import 'model.dart';

// class HomeScreen extends StatelessWidget {
//    HomeScreen({super.key});


//   DatabaseHelper dbHelper = DatabaseHelper();

// // Insert data
// MyData data = MyData(id: 1, name: 'John', age: 25);
// await dbHelper.insertData(data);

// // Retrieve all data
// List<MyData> dataList = await dbHelper.getAllData();

// // Perform other CRUD operations as needed

// // Close the database when no longer needed
// dbHelper.closeDatabase();


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Page"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Some Initial data...",
//             style: TextStyle(fontSize: 25),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text("Write Data"),
//               ),
//               ElevatedButton(onPressed: () {}, child: const Text("Read Data"))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
