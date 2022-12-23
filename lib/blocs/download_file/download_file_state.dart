abstract class DownloadFileState {}

class DownloadFileInitial extends DownloadFileState {}

class DownloadFileFailed extends DownloadFileState {
  final String fileName;

  DownloadFileFailed({required this.fileName});
}

class DownloadFileSuccess extends DownloadFileInitial {
  final String fileName;
  final String filePath;
  final String contentType;

  DownloadFileSuccess(
      {required this.fileName,
      required this.filePath,
      required this.contentType});
}
