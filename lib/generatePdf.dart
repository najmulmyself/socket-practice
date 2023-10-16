import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'; // For opening the PDF

// Function to generate a PDF invoice
Future<void> generatePDFInvoice(String invoiceNo, String date,
    String customerName, List<String> items, double totalAmount) async {
  final pdf = pw.Document();

  // Add font configuration
  final fontData = await rootBundle.load("assets/OpenSans-Regular.ttf");
  final customFont = pw.Font.ttf(fontData.buffer.asByteData());

  // Use the custom font in the document
  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(
        base: customFont,
      ),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
              level: 0,
              text: 'Bangladesh National Zoo Restaurant',
              textStyle: const pw.TextStyle(fontSize: 55),
            ),
            pw.Text('National zoo Restaurant , Mirpur-1',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Shah Ali PS, Dhaka-1216,Bangladesh,3864',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Office Phone: 8801735731815',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Mushak-6.3', style: const pw.TextStyle(fontSize: 40)),
            pw.SizedBox(height: 20), // Spacer
            pw.Header(
                level: 0,
                text: 'X-Report',
                textStyle: const pw.TextStyle(fontSize: 55)),
            pw.Text('Terminal No: 91529437u5a95f93',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('BIN : 0033567354-0101',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Cashier : 91529437u5a95f93',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Start Time : ${DateTime.now()}',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('End Time : ${DateTime.now()}',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Header(
                level: 0,
                text: 'Report: 1',
                textStyle: const pw.TextStyle(fontSize: 55)),
            pw.Text('Sales Details', style: const pw.TextStyle(fontSize: 50)),
            pw.Text('Cash Count:1', style: const pw.TextStyle(fontSize: 50)),
            pw.Text('Cart Count:1', style: const pw.TextStyle(fontSize: 50)),
            pw.Text('MFS Count:1', style: const pw.TextStyle(fontSize: 50)),
            pw.Header(level: 0, text: ''),
            pw.Text('SD Amount:0.000TK',
                style: const pw.TextStyle(fontSize: 50)),
            pw.Text('VAT Amount:3.333TK',
                style: const pw.TextStyle(fontSize: 50)),
            pw.Text('Total Sales Amount: 70.000TK',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Credit Details: 70.000',
                style: const pw.TextStyle(fontSize: 40)),
            pw.Text('Credit Count: 0', style: const pw.TextStyle(fontSize: 40)),

            // for (var item in items)
            //   pw.Bullet(
            //     text: item,
            //   ),
            // pw.SizedBox(height: 20), // Spacer
            // pw.Text('Total Amount: \$$totalAmount'),
          ],
        );
      },
    ),
  );

  // Save and open the PDF
  final Uint8List pdfData = await pdf.save();
  final Directory tempDir = await getTemporaryDirectory();
  final File tempFile = File('${tempDir.path}/invoice.pdf');
  await tempFile.writeAsBytes(pdfData);
  // OpenFile.open(tempFile.path);
  // Use the Printing package to open and print the PDF
  await Printing.layoutPdf(onLayout: (format) {
    return pdfData;
  });
  print("open");
}
