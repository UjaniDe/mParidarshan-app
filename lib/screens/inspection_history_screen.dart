import 'package:flutter/material.dart';
import '../models/inspection_model.dart';
import 'supervision_report_screen.dart';
import '../widgets/app_drawer.dart';

class InspectionHistoryScreen extends StatelessWidget {
  const InspectionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
       drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'Inspection History',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: dummyInspections.isEmpty
          ? const Center(child: Text('No inspections yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dummyInspections.length,
              itemBuilder: (context, index) {
                final inspection = dummyInspections[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A237E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.school_outlined,
                            color: Color(0xFF1A237E),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inspection.school,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${inspection.district} • ${_formatDate(inspection.date)}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupervisionReportScreen(
                                  inspection: inspection,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(color: Color(0xFF1A237E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}