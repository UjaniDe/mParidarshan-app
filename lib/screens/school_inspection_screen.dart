import 'package:flutter/material.dart';
import 'section1_screen.dart';

class SchoolInspectionScreen extends StatefulWidget {
  const SchoolInspectionScreen({super.key});

  @override
  State<SchoolInspectionScreen> createState() => _SchoolInspectionScreenState();
}

class _SchoolInspectionScreenState extends State<SchoolInspectionScreen> {
  String? _selectedDistrict;
  String? _selectedCircle;
  String? _selectedSchool;

  final Map<String, List<String>> _districtToCircles = {
    'Kolkata': ['Kolkata North', 'Kolkata South', 'Kolkata East'],
    'Howrah': ['Howrah Sadar', 'Uluberia', 'Bagnan'],
    'Hooghly': ['Chinsurah', 'Arambagh', 'Chandannagar'],
    'North 24 Parganas': ['Barasat', 'Barrackpore', 'Basirhat', 'Bangaon'],
    'South 24 Parganas': ['Alipore', 'Diamond Harbour', 'Kakdwip'],
    'Nadia': ['Krishnanagar', 'Ranaghat', 'Kalyani'],
    'Murshidabad': ['Berhampore', 'Jangipur', 'Lalbagh'],
    'Burdwan': ['Asansol', 'Durgapur', 'Katwa', 'Kalna'],
    'Birbhum': ['Suri', 'Rampurhat', 'Bolpur'],
    'Bankura': ['Bankura Sadar', 'Bishnupur', 'Khatra'],
    'Purulia': ['Purulia Sadar', 'Raghunathpur', 'Jhalda'],
    'Midnapore East': ['Tamluk', 'Haldia', 'Contai'],
    'Midnapore West': ['Midnapore Sadar', 'Ghatal', 'Jhargram'],
    'Malda': ['English Bazar', 'Old Malda', 'Chanchal'],
    'Uttar Dinajpur': ['Raiganj', 'Islampur', 'Dalkhola'],
    'Dakshin Dinajpur': ['Balurghat', 'Gangarampur'],
    'Jalpaiguri': ['Jalpaiguri Sadar', 'Alipurduar', 'Mal'],
    'Darjeeling': ['Darjeeling Sadar', 'Siliguri', 'Kurseong'],
    'Cooch Behar': ['Cooch Behar Sadar', 'Dinhata', 'Mathabhanga'],
  };

  final Map<String, List<String>> _circleToSchools = {
    'Kolkata North': ['Shyambazar HS School', 'Belgachia Vidyamandir', 'Hatkhola Girls School'],
    'Kolkata South': ['Ballygunge Govt HS School', 'Alipore Multipurpose School', 'Tollygunge Govt School'],
    'Kolkata East': ['Ultadanga HS School', 'Maniktala Govt School', 'Phoolbagan Vidyalaya'],
    'Howrah Sadar': ['Howrah Zilla School', 'Shibpur Govt HS School', 'Ramrajatala HS School'],
    'Uluberia': ['Uluberia HS School', 'Bagnan Govt School', 'Shyampur Vidyamandir'],
    'Barasat': ['Barasat Govt HS School', 'Madhyamgram HS School', 'Habra HS School'],
    'Barrackpore': ['Barrackpore Govt HS School', 'Titagarh HS School', 'Khardah HS School'],
    'Krishnanagar': ['Krishnanagar Govt College School', 'Nabadwip HS School', 'Santipur HS School'],
    'Berhampore': ['Berhampore Govt HS School', 'Krishnanath College School', 'Jiaganj HS School'],
    'Durgapur': ['Durgapur Govt HS School', 'Benachity HS School', 'Bidhan Nagar HS School'],
    'Asansol': ['Asansol Govt HS School', 'Kulti HS School', 'Raniganj HS School'],
    'Siliguri': ['Siliguri Govt HS School', 'Pradhan Nagar HS School', 'Matigara HS School'],
    'Darjeeling Sadar': ['Darjeeling Govt HS School', 'St. Joseph School', 'Loreto Convent School'],
    'Suri': ['Suri Vidyasagar College School', 'Suri HS School', 'Dubrajpur HS School'],
    'Bankura Sadar': ['Bankura Zilla School', 'Bankura Sammilani School', 'Onda HS School'],
    'Purulia Sadar': ['Purulia Zilla School', 'Purulia HS School', 'Manbazar HS School'],
    'Tamluk': ['Tamluk Hamilton HS School', 'Nandakumar HS School', 'Mahishadal HS School'],
    'English Bazar': ['Malda Zilla School', 'Malda Govt HS School', 'English Bazar HS School'],
    'Raiganj': ['Raiganj Coronation HS School', 'Raiganj Govt School', 'Itahar HS School'],
    'Balurghat': ['Balurghat HS School', 'Balurghat Girls School', 'Tapan HS School'],
    'Jalpaiguri Sadar': ['Jalpaiguri Govt HS School', 'Jalpaiguri Zilla School', 'Rajganj HS School'],
    'Cooch Behar Sadar': ['Cooch Behar Zilla School', 'Jenkins School', 'Sunity Academy'],
  };

  List<String> get _circles {
    if (_selectedDistrict == null) return [];
    return _districtToCircles[_selectedDistrict!] ?? [];
  }

  List<String> get _schools {
    if (_selectedCircle == null) return [];
    return _circleToSchools[_selectedCircle!] ?? ['No schools listed for this circle'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'School Inspection',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Select School Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'West Bengal',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildDropdown(
              label: 'District',
              value: _selectedDistrict,
              items: _districtToCircles.keys.toList(),
              onChanged: (val) {
                setState(() {
                  _selectedDistrict = val;
                  _selectedCircle = null;
                  _selectedSchool = null;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Circle',
              value: _selectedCircle,
              items: _circles,
              enabled: _selectedDistrict != null,
              onChanged: (val) {
                setState(() {
                  _selectedCircle = val;
                  _selectedSchool = null;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'School',
              value: _selectedSchool,
              items: _schools,
              enabled: _selectedCircle != null,
              onChanged: (val) {
                setState(() {
                  _selectedSchool = val;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
onPressed: _selectedSchool != null
    ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Section1Screen(
              district: _selectedDistrict!,
              circle: _selectedCircle!,
              school: _selectedSchool!,
            ),
          ),
        );
      }
    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed',
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

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            enabled ? 'Select $label' : 'Select ${label == 'Circle' ? 'District' : 'Circle'} first',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down,
              color: enabled ? const Color(0xFF1A237E) : Colors.grey),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}