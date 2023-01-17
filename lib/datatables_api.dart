library datatables_api;

import 'package:datatables_api/DataTableApiController.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show DataTable, DataColumn, DataRow, DataCell, PaginatedDataTable;
import 'package:datatables_api/dados.dart';
import 'package:datatables_api/fieldsDataTables.dart';

class DataTablesAPI extends StatefulWidget {
  final Uri? url;
  final List<FieldsDataTablesAPI>? fields;
  final Map<String, String>? headers;
  final bool? search;
  final String? labelSearch;
  final bool? searchOnChange;
  final String? title;
  final int perPage;
  final DataTableApiController? controller;
  DataTablesAPI(
      {Key? key,
      @required this.url,
      @required this.fields,
      this.headers,
      this.search = true,
      this.labelSearch = "Pesquisar",
      this.searchOnChange = true,
      this.title,
      this.perPage = 10,
      this.controller})
      : super(key: key);

  @override
  State<DataTablesAPI> createState() => _DataTablesAPIState();
}

class _DataTablesAPIState extends State<DataTablesAPI> {
  late var dados;
  late var controller;

  Widget table = SizedBox();
  @override
  void initState() {
    controller = widget.controller ?? DataTableApiController();
    controller.widget = this;
    chamar();
    super.initState();
  }

  Future<void> chamar() async {
    dados = new DadosTabela(widget.url, widget.fields!, widget.headers, widget.perPage);
    dados.controller = this;
    await dados.chamarDados();
    table = PaginatedDataTable(
        rowsPerPage: dados.porPagina,
        columns: widget.fields!.map((e) => DataColumn(label: Text(e.label!))).toList(),
        source: dados,
        showCheckboxColumn: true,
        onPageChanged: (i) async {
          dados.pag = (i / dados.porPagina).toInt() + 1;
          await dados.chamarDados();
          setState(() {});
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            widget.title != null ? Expanded(child: Text(widget.title!)) : SizedBox(),
            widget.search == true
                ? Expanded(
                    child: TextBox(
                      // controller: store.senha,
                      onChanged: (value) => dados.setSearch(value, widget.searchOnChange),
                      onSubmitted: (value) => dados.setSearch(value, true),
                      suffix: IconButton(
                          icon: Icon(
                            FluentIcons.search,
                          ),
                          onPressed: () => dados.chamarDados),

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox()
          ],
        ),
        table,
      ],
    );
  }
}
