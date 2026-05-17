import 'package:flutter/material.dart';
import '../models/inspection_model.dart';
import '../services/api_service.dart';
import 'supervision_report_screen.dart';

class InspectionHistoryScreen extends StatefulWidget {
  const InspectionHistoryScreen({super.key});

  @override
  State<InspectionHistoryScreen> createState() => _InspectionHistoryScreenState();
}

class _InspectionHistoryScreenState extends State<InspectionHistoryScreen> {
  List<InspectionModel> _inspections = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInspections();
  }

  Future<void> _loadInspections() async {
    final data = await ApiService.getInspections();
    setState(() {
      _inspections = data.map((item) => InspectionModel(
        district: item['district'] ?? '',
        circle: item['circle'] ?? '',
        school: item['school'] ?? '',
        schoolType: item['school_type'] ?? '',
        boysPresent: item['boys_present'],
        girlsPresent: item['girls_present'],
        boysAbsent: item['boys_absent'],
        girlsAbsent: item['girls_absent'],
        libraryBooks: item['library_books'] ?? '',
        date: DateTime.parse(item['created_at']),
      )).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _inspections.isEmpty
              ? const Center(child: Text('No inspections yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _inspections.length,
                  itemBuilder: (context, index) {
                    final inspection = _inspections[index];
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
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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