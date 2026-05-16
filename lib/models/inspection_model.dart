class InspectionModel {
  final String district;
  final String circle;
  final String school;
  final String schoolType; // 'Coed', 'Boys', 'Girls'
  final int? boysPresent;
  final int? girlsPresent;
  final int? boysAbsent;
  final int? girlsAbsent;
  final String libraryBooks;
  final DateTime date;

  InspectionModel({
    required this.district,
    required this.circle,
    required this.school,
    required this.schoolType,
    this.boysPresent,
    this.girlsPresent,
    this.boysAbsent,
    this.girlsAbsent,
    required this.libraryBooks,
    required this.date,
  });
}

// Dummy data for history
final List<InspectionModel> dummyInspections = [
  InspectionModel(
    district: 'Birbhum',
    circle: 'Suri',
    school: 'Suri Vidyasagar College School',
    schoolType: 'Coed',
    boysPresent: 120,
    girlsPresent: 98,
    boysAbsent: 5,
    girlsAbsent: 3,
    libraryBooks: 'Yes',
    date: DateTime(2026, 5, 10),
  ),
  InspectionModel(
    district: 'Murshidabad',
    circle: 'Berhampore',
    school: 'Berhampore Govt HS School',
    schoolType: 'Boys',
    boysPresent: 210,
    girlsPresent: null,
    boysAbsent: 12,
    girlsAbsent: null,
    libraryBooks: 'No',
    date: DateTime(2026, 5, 8),
  ),
  InspectionModel(
    district: 'Nadia',
    circle: 'Krishnanagar',
    school: 'Nabadwip HS School',
    schoolType: 'Girls',
    boysPresent: null,
    girlsPresent: 175,
    boysAbsent: null,
    girlsAbsent: 8,
    libraryBooks: 'Library Not Available',
    date: DateTime(2026, 5, 5),
  ),
];