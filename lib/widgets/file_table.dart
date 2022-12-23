import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_cubit.dart';
import 'package:studentlounge_mobile/blocs/download_file/download_file_state.dart';
import 'package:studentlounge_mobile/models/lesson_file_model.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;
import 'package:studentlounge_mobile/utils/my_date_formatter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FileTable extends StatefulWidget {
  final List<LessonFile> files;
  const FileTable({super.key, required this.files});

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
                  icon: const Icon(Icons.visibility_rounded),
                  onPressed: () => myDownloadFileCubit.downloadFile(
                      fileId: row.getCells()[0].value.toString(),
                      contentType: row.getCells()[1].value.toString(),
                      fileName: row.getCells()[2].value.toString()))
              : Center(
                  child: Text(
                  dataGridCell.value.toString(),
                  // overflow: TextOverflow.ellipsis,
                )));
    }).toList());
  }

  FileDataSource({required List<LessonFile> files, context}) {
    myDownloadFileCubit = BlocProvider.of<DownloadFileCubit>(context);
    dataGridRows = files
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Id', value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: 'ContentType', value: dataGridRow.contentType),
              DataGridCell<String>(columnName: 'Nom', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'Auteur', value: dataGridRow.user),
              DataGridCell<String>(
                  columnName: 'Date',
                  value: MyDateFormatter.formatDateYMMMD(dataGridRow.date)),
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
      visible: false,
      columnName: '',
      label: const Text(''),
    ),
    GridColumn(
        visible: false,
        columnName: '',
        columnWidthMode: ColumnWidthMode.none,
        label: const Text('')),
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
            ))),
    GridColumn(
        columnName: 'Auteur',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text('Auteur'))),
    GridColumn(
        columnName: 'Date',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Date',
              //overflow: TextOverflow.visible,
            ))),
    GridColumn(
        columnName: 'Actions',
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Actions',
              //overflow: TextOverflow.ellipsis,
            ))),
  ];

  @override
  void initState() {
    fileDataSource = FileDataSource(files: widget.files, context: context);
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
            if (state.contentType == 'application/pdf') {
              showDialog(
                context: context,
                builder: (context) => Scaffold(
                  body: PDFView(
                    filePath: state.filePath,
                  ),
                ),
              );
            }
          } else if (state is DownloadFileLoad) {
            _displayLoadToDownload(state.fileName);
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

  _displayLoadToDownload(String fileName) {
    final load = SnackBar(
        content: Text("Chargement du fichier $fileName"),
        backgroundColor: theme.greyDark);
    ScaffoldMessenger.of(context).showSnackBar(load);
  }

  _displayDownloadSuccess(String fileName) {
    final success = SnackBar(
        content: Text("Fichier $fileName téléchargé"),
        backgroundColor: theme.success);
    ScaffoldMessenger.of(context).showSnackBar(success);
  }
}
