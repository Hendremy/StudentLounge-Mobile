import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_state.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class FileTable extends StatefulWidget {
  final List<LessonFile> fakeFiles = [
    LessonFile(
        id: "2",
        name: 'Fake.pdf',
        user: 'Test',
        date: DateTime.now(),
        type: FileType.summary),
    LessonFile(
        id: "1",
        name: 'Fake.txt',
        user: 'Toto',
        date: DateTime.now(),
        type: FileType.notes),
  ];

  final List<LessonFile> files;
  FileTable({super.key, required this.files});

  @override
  State<FileTable> createState() => _FileTableState();
}

class _FileTableState extends State<FileTable> {
  late DownloadFileCubit downloadFileCubit;
  final List<DataColumn> columns = <DataColumn>[
    const DataColumn(label: Expanded(child: Text('Type'))),
    const DataColumn(label: Expanded(child: Text('Nom'))),
    const DataColumn(label: Expanded(child: Text('Auteur'))),
    const DataColumn(label: Expanded(child: Text('Date'))),
    const DataColumn(label: Expanded(child: Text('Actions')))
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        downloadFileCubit = BlocProvider.of<DownloadFileCubit>(context);
        return downloadFileCubit;
      },
      child: BlocListener<DownloadFileCubit, DownloadFileState>(
        listener: (context, state) {
          if (state is DownloadFileFailed) {
            _displayFailedToDownload(state.fileName);
          } else if (state is DownloadFileSuccess) {
            _displayDownloadSuccess(state.fileName);
          }
        },
        child: SingleChildScrollView(
          child: DataTable(columnSpacing: 25, columns: columns, rows: <DataRow>[
            for (LessonFile file in widget.fakeFiles) _createFileRow(file)
          ]),
        ),
      ),
    );
  }

  _createFileRow(LessonFile file) {
    return DataRow(cells: [
      DataCell(Icon(file.type == FileType.notes
          ? Icons.text_fields
          : Icons.insert_drive_file)),
      DataCell(Text(file.name)),
      DataCell(Text(file.user)),
      DataCell(Text(DateFormat.yMd().format(file.date))),
      DataCell(IconButton(
        color: theme.primary,
        icon: const Icon(Icons.download),
        onPressed: () => downloadFileCubit.downloadFile(file.id, file.name),
      ))
    ]);
  }

  _displayFailedToDownload(String fileName) {
    final fail = SnackBar(
        content: Text("Le téléchargement de $fileName a échoué"),
        backgroundColor: theme.error);
    ScaffoldMessenger.of(context).showSnackBar(fail);
  }

  _displayDownloadSuccess(String fileName) {
    final success = SnackBar(
        content: Text("Fichier $fileName téléchargé"),
        backgroundColor: theme.success);
    ScaffoldMessenger.of(context).showSnackBar(success);
  }
}
