class Category {
  String title;
  int lessonCount;
  int money;
  int availableSeats;
  double lessonDuration;
  double rating;
  String imagePath;
  String description;
  String categoryType;

  static List<String> categoryTypes = ["IT", "Подача", "Школы"];

  Category(
      {this.title = '',
      this.imagePath = '',
      this.lessonCount = 0,
      this.money = 0,
      this.rating = 0.0,
      this.availableSeats = 0,
      this.lessonDuration = 0,
      this.description = '',
      this.categoryType = ''});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagePath': imagePath,
      'lessonCount': lessonCount,
      'money': money,
      'rating': rating,
      'availableSeats': availableSeats,
      'lessonDuration': lessonDuration,
      "description": description,
      "categoryType": categoryType,
    };
  }

  Category.fromMap(Map<String, dynamic> addressMap)
      : title = addressMap['title'],
        lessonCount = addressMap['lessonCount'],
        money = addressMap['money'],
        rating = addressMap['rating'],
        availableSeats = addressMap['availableSeats'],
        lessonDuration = addressMap['lessonDuration'],
        description = addressMap['description'],
        categoryType = addressMap['categoryType'],
        imagePath = addressMap['imagePath'];
}
