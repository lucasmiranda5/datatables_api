library datatables_api;
import 'package:flutter/material.dart';
import 'package:datatables_api/dados.dart';
import 'package:datatables_api/fieldsDataTables.dart';

class DataTablesAPI extends StatefulWidget {
  final Uri? url;
  final List<FieldsDataTablesAPI>? fields;
  final Map<String, String>? headers;
  DataTablesAPI({Key? key, @required this.url, @required this.fields, this.headers}) : super(key: key);

  @override
  State<DataTablesAPI> createState() => _DataTablesAPIState();
}

class _DataTablesAPIState extends State<DataTablesAPI> {
  late var dados;

  Widget table = SizedBox();
  @override
  void initState() {
    chamar();
    super.initState();
  }

  Future<void> chamar() async {
    dados = new DadosTabela(widget.url, widget.fields!, widget.headers);
    await dados.chamarDados();
    table = PaginatedDataTable(
        actions: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  //controller: store.senha,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () => print("Lucas"),
                    ),
                    hintText: 'Pesquisar',
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
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
    return table;
  }
}
