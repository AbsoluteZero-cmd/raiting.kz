class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagePath': imagePath,
      'lessonCount': lessonCount,
      'money': money,
      'rating': rating,
    };
  }

  Category.fromMap(Map<String, dynamic> addressMap)
      : title = addressMap['title'],
        lessonCount = addressMap['lessonCount'],
        money = addressMap['money'],
        rating = addressMap['rating'],
        imagePath = addressMap['imagePath'];

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'UX/UI дизайн',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Мобильная разработка',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
  ];
}
