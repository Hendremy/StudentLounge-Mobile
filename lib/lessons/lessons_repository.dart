class LessonsRepository {
  var baseUrl = "https://porthos-intra.cg.helmo.be/e190449";
  Duration duration = const Duration(seconds: 1);

  Future<dynamic> getLesson(String lessonName) async {
    await Future.delayed(duration);
    return null;
  }
}
