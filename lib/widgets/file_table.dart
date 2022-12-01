import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class FileTable extends StatefulWidget {
  final List<LessonFile> files;
  const FileTable({super.key, required this.files});

  @override
  State<FileTable> createState() => _FileTableState();
}

class _FileTableState extends State<FileTable> {
  final List<DataColumn> columns = <DataColumn>[
    const DataColumn(label: Expanded(child: Text('Type'))),
    const DataColumn(label: Expanded(child: Text('Nom'))),
    const DataColumn(label: Expanded(child: Text('Auteur'))),
    const DataColumn(label: Expanded(child: Text('Date'))),
    const DataColumn(label: Expanded(child: Text('Actions')))
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(columnSpacing: 45, columns: columns, rows: <DataRow>[
      for (LessonFile file in widget.files) _createFileRow(file)
    ]);
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
        onPressed: () {},
      ))
    ]);
  }
}
