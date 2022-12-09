import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_cubit.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_state.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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

class FileDataSource extends DataGridSource {
  late DownloadFileCubit myDownloadFileCubit;
  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: dataGridCell.columnName == 'Action'
              ? IconButton(
                  color: theme.primary,
                  icon: const Icon(Icons.download),
                  onPressed: () => myDownloadFileCubit.downloadFile(
                      row.getCells()[0].value.toString(),
                      row.getCells()[2].value.toString()))
              : Center(
                  child: Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                )));
    }).toList());
  }

  FileDataSource({required List<LessonFile> files, context}) {
    myDownloadFileCubit = BlocProvider.of<DownloadFileCubit>(context);
    dataGridRows = files
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'Nom', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'Auteur', value: dataGridRow.user),
              DataGridCell<String>(
                  columnName: 'Date',
                  value: DateFormat.yMd().format(dataGridRow.date)),
              const DataGridCell<Widget>(columnName: 'Action', value: null)
            ]))
        .toList();
  }
}

class _FileTableState extends State<FileTable> {
  late DownloadFileCubit downloadFileCubit;
  late FileDataSource fileDataSource;

  final List<GridColumn> columns = <GridColumn>[
    GridColumn(
        columnName: 'Id',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Id',
              overflow: TextOverflow.ellipsis,
            ))),
    /*GridColumn(
        columnName: 'Type',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Type',
              overflow: TextOverflow.ellipsis,
            ))),*/
    GridColumn(
        columnName: 'Nom',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Nom',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'Auteur',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Auteur',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'Date',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Date',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'Actions',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Actions',
              overflow: TextOverflow.ellipsis,
            ))),
  ];

  @override
  void initState() {
    fileDataSource = FileDataSource(files: widget.fakeFiles, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadFileCubit, DownloadFileState>(
        listener: (context, state) {
          if (state is DownloadFileFailed) {
            _displayFailedToDownload(state.fileName);
          } else if (state is DownloadFileSuccess) {
            _displayDownloadSuccess(state.fileName);
            showDialog(
              context: context,
              builder: (context) => Scaffold(
                body: PDFView(
                  filePath: state.filePath,
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: SfDataGrid(
            columnWidthMode: ColumnWidthMode.fill,
            columns: columns,
            source: fileDataSource,
          ),
        ));
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
