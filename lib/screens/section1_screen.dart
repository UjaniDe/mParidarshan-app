import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Section1Screen extends StatefulWidget {
  final String district;
  final String circle;
  final String school;

  const Section1Screen({
    super.key,
    required this.district,
    required this.circle,
    required this.school,
  });

  @override
  State<Section1Screen> createState() => _Section1ScreenState();
}

class _Section1ScreenState extends State<Section1Screen> {
  String? _isCoed; // 'yes' or 'no'
  String? _schoolType; // 'Boys' or 'Girls' (only if not coed)
  String? _libraryBooks; // 'Yes', 'No', 'Library Not Available'

  final _boysPresent = TextEditingController();
  final _girlsPresent = TextEditingController();
  final _boysAbsent = TextEditingController();
  final _girlsAbsent = TextEditingController();

  @override
  void dispose() {
    _boysPresent.dispose();
    _girlsPresent.dispose();
    _boysAbsent.dispose();
    _girlsAbsent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'Section 1 - General Information',
          style: TextStyle(color: Colors.white, fontSize: 16),
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
            // School Info Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E).withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF1A237E).withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow('District', widget.district),
                  const SizedBox(height: 6),
                  _infoRow('Circle', widget.circle),
                  const SizedBox(height: 6),
                  _infoRow('School', widget.school),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Coed question
            _sectionLabel('Is it a Co-ed School?'),
            const SizedBox(height: 10),
            Row(
              children: [
                _radioOption('Yes', _isCoed, (val) {
                  setState(() {
                    _isCoed = val;
                    _schoolType = null;
                  });
                }),
                const SizedBox(width: 16),
                _radioOption('No', _isCoed, (val) {
                  setState(() {
                    _isCoed = val;
                  });
                }),
              ],
            ),

            // School type (only if not coed)
            if (_isCoed == 'No') ...[
              const SizedBox(height: 16),
              _sectionLabel('Type of School'),
              const SizedBox(height: 10),
              Row(
                children: [
                  _radioOption('Boys', _schoolType, (val) {
                    setState(() => _schoolType = val);
                  }),
                  const SizedBox(width: 16),
                  _radioOption('Girls', _schoolType, (val) {
                    setState(() => _schoolType = val);
                  }),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // Students present on day of visit
            _sectionLabel('Students Present on Day of Visit'),
            const SizedBox(height: 12),
            if (_isCoed == 'Yes') ...[
              _numberField('Number of Boys', _boysPresent),
              const SizedBox(height: 12),
              _numberField('Number of Girls', _girlsPresent),
            ] else if (_isCoed == 'No' && _schoolType == 'Boys') ...[
              _numberField('Number of Boys', _boysPresent),
            ] else if (_isCoed == 'No' && _schoolType == 'Girls') ...[
              _numberField('Number of Girls', _girlsPresent),
            ] else ...[
              _placeholderText('Select Co-ed option above to fill this section'),
            ],

            const SizedBox(height: 24),

            // Students not attended in 15 days
            _sectionLabel('Students Not Attended in Last 15 Days'),
            const SizedBox(height: 12),
            if (_isCoed == 'Yes') ...[
              _numberField('Number of Boys', _boysAbsent),
              const SizedBox(height: 12),
              _numberField('Number of Girls', _girlsAbsent),
            ] else if (_isCoed == 'No' && _schoolType == 'Boys') ...[
              _numberField('Number of Boys', _boysAbsent),
            ] else if (_isCoed == 'No' && _schoolType == 'Girls') ...[
              _numberField('Number of Girls', _girlsAbsent),
            ] else ...[
              _placeholderText('Select Co-ed option above to fill this section'),
            ],

            const SizedBox(height: 24),

            // Library books dropdown
            _sectionLabel('Do Students Use Library Books?'),
            const SizedBox(height: 12),
            _buildDropdown(
              value: _libraryBooks,
              items: ['Yes', 'No', 'Library Not Available'],
              hint: 'Select an option',
              onChanged: (val) => setState(() => _libraryBooks = val),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canProceed() ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    if (_isCoed == null || _libraryBooks == null) return false;
    if (_isCoed == 'No' && _schoolType == null) return false;
    if (_isCoed == 'Yes') {
      return _boysPresent.text.isNotEmpty && _girlsPresent.text.isNotEmpty &&
             _boysAbsent.text.isNotEmpty && _girlsAbsent.text.isNotEmpty;
    }
    if (_schoolType == 'Boys') {
      return _boysPresent.text.isNotEmpty && _boysAbsent.text.isNotEmpty;
    }
    if (_schoolType == 'Girls') {
      return _girlsPresent.text.isNotEmpty && _girlsAbsent.text.isNotEmpty;
    }
    return false;
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _radioOption(String label, String? groupValue, ValueChanged<String?> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: groupValue == label ? const Color(0xFF1A237E) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: groupValue == label ? const Color(0xFF1A237E) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: groupValue == label ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _numberField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          _MaxValueFormatter(1999),
        ],
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1A237E)),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _placeholderText(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
    );
  }
}

class _MaxValueFormatter extends TextInputFormatter {
  final int max;
  _MaxValueFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final val = int.tryParse(newValue.text);
    if (val == null || val > max) return oldValue;
    return newValue;
  }
}
