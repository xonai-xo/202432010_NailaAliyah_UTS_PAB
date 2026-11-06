enum ReportType { hilang, ditemukan }

class Item {
  final String id;
  final String name;
  final String category;
  final String description;
  final String location;
  final String time;
  final String contact;
  final String imagePath;
  final ReportType type;
  bool isReturned;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.location,
    required this.time,
    required this.contact,
    required this.imagePath,
    required this.type,
    this.isReturned = false,
  });
}