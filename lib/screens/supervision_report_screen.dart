import 'package:flutter/material.dart';
import '../models/inspection_model.dart';
import '../widgets/app_drawer.dart';

class SupervisionReportScreen extends StatelessWidget {
  final InspectionModel inspection;

  const SupervisionReportScreen({super.key, required this.inspection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
       drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'Supervision Report',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('School Information'),
            _reportCard([
              _reportRow('District', inspection.district),
              _reportRow('Circle', inspection.circle),
              _reportRow('School', inspection.school),
              _reportRow('Date of Visit', '${inspection.date.day}/${inspection.date.month}/${inspection.date.year}'),
            ]),

            const SizedBox(height: 20),
            _sectionHeader('Section 1 - General Information'),
            _reportCard([
              _reportRow('Type of School', inspection.schoolType),
              if (inspection.boysPresent != null)
                _reportRow('Boys Present on Day of Visit', '${inspection.boysPresent}'),
              if (inspection.girlsPresent != null)
                _reportRow('Girls Present on Day of Visit', '${inspection.girlsPresent}'),
              if (inspection.boysAbsent != null)
                _reportRow('Boys Not Attended in 15 Days', '${inspection.boysAbsent}'),
              if (inspection.girlsAbsent != null)
                _reportRow('Girls Not Attended in 15 Days', '${inspection.girlsAbsent}'),
              _reportRow('Students Use Library Books', inspection.libraryBooks),
            ]),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined, color: Color(0xFF1A237E)),
                label: const Text(
                  'Download Report',
                  style: TextStyle(color: Color(0xFF1A237E)),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFF1A237E)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A237E),
        ),
      ),
    );
  }

  Widget _reportCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _reportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ),
          Expanded(
            flex: 3,
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}