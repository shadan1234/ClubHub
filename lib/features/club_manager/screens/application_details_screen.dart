import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clubhub/models/applications.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class ApplicationDetailScreen extends StatelessWidget {
  final Application application;
  final Function(String) acceptApplication;
  final Function(String) rejectApplication;

  ApplicationDetailScreen({
    required this.application,
    required this.acceptApplication,
    required this.rejectApplication,
  });

  @override
  Widget build(BuildContext context) {
    // Format applied date to show only year, month, and day
    String formattedDate = DateFormat('yyyy-MM-dd').format(application.appliedAt);

    return Scaffold(
      appBar: AppBar(
        title: Text('Application Details'),
        backgroundColor: AppColors.primary, // Use your custom primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Applicant: ${application.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87), // Custom font size and color
            ),
            SizedBox(height: 16),
            Text(
              'Applied Date: $formattedDate',
              style: TextStyle(color: Colors.grey[600], fontSize: 18), // Lighter text color
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87), // Custom font size and color
            ),
            SizedBox(height: 8),
            Text(
              application.description,
              style: TextStyle(fontSize: 16, color: Colors.black87), // Custom text color
            ),
            SizedBox(height: 16),
            Text(
              'Document:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87), // Custom font size and color
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                PDFDocument doc = await PDFDocument.fromURL(application.document);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PDFViewer(document: doc)),
                );
              },
              child: Text(
                'View Document',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 24), // Increased space
            application.status == 'pending'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => acceptApplication(application.id),
                        child: Text('Accept'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color on button
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => rejectApplication(application.id),
                        child: Text('Reject'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color on button
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Status: ${application.status}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87), // Custom text color
                  ),
          ],
        ),
      ),
    );
  }
}
