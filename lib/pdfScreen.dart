import 'package:flutter/material.dart';

import 'generatePdf.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({Key? key}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  // Function to generate PDF goes here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await generatePDFInvoice(
              'ABC123',
              '2023-10-15',
              'John Doe',
              ['Product A - \$50', 'Product B - \$30', 'Product C - \$25'],
              105.0,
            );
            print("test");
          },
          child: const Text("Generate PDF"),
        ),
      ),
    );
  }
}
