import 'package:bloc/bloc.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_state.dart';
import 'package:studentlounge_mobile/repositories/lesson_files_repository.dart';

class DownloadFileCubit extends Cubit<DownloadFileState> {
  final LessonFilesRepository lessonFilesRepository;
  DownloadFileCubit({required this.lessonFilesRepository})
      : super(DownloadFileInitial());

  void downloadFile(String fileId, String fileName, String contentType) async {
    try {
      String path = await lessonFilesRepository.downloadFile(fileId, fileName);
      emit(DownloadFileSuccess(
          fileName: fileName, filePath: path, contentType: contentType));
    } catch (ex) {
      emit(DownloadFileFailed(fileName: fileName));
    }
  }
}
