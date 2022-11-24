abstract class LessonsRepository {
  Future<dynamic> getLesson(String lessonName);
}

class AppLessonsRepository extends LessonsRepository{
  final String baseUrl;

  AppLessonsRepository({required this.baseUrl});

  @override
  Future<dynamic> getLesson(String lessonName) async {
    return null;
  }

  @override
  Future<dynamic> getUserLessons(String userId) async {
    
    return null;
  }
}
