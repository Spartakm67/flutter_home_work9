class CategoryRepository {
  static final List<String> categories = [
    'Сніданок',
    'Обід',
    'Вечеря',
    'Десерт',
    'Млинці',
  ];
  static List<String> getAllCategories() {
    return categories;
  }
}