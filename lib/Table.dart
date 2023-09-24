import 'package:flutter/material.dart';

class TableS extends StatelessWidget {
  const TableS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 35,
            color: const Color.fromRGBO(76, 175, 80, 1),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Sl',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(border: Border.all()),
                    child: const Text('Service Category',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Text('Total Sales',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Text('Total VAT',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(border: Border.all()),
                    child: const Text('Total SD',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 1,
            // decoration: BoxDecoration(border: Border.all()),
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: Center(
                      //     child: Text("dfjlsdaf"),
                      //   ),
                      // ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 35,
                          decoration: const BoxDecoration(
                              border: Border(right: BorderSide(width: 1))),
                          child: const Text('Total SD',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text("ei"),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text("dfaskd"),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text("dfjals"),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(("Hello")),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
