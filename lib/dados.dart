import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:datatables_api/fieldsDataTables.dart';

class DadosTabela extends DataTableSource {
  final Uri? url;
  final List<FieldsDataTablesAPI>? campos;
  final Map<String, String>? headers;

  List? data;

  int quatidadePagina = 0;

  int pag = 1;

  int porPagina = 2;

  int count = 0;

  DadosTabela(this.url, this.campos, this.headers) {
    chamarDados();
  }

  Future<void> chamarDados() async {
    String fields = "";
    if (campos![0].name != null)
      fields = campos![0].name!;
    else
      fields = campos![0].id!;

    for (int x = 1; x < campos!.length; x++) {
      if (campos![x].name != null || campos![x].id != null) {
        if (campos![x].name != '' || campos![x].id != '') {
          if (campos![x].name != null)
            fields += "," + campos![x].name!;
          else
            fields += "," + campos![x].id!;
        }
      }
    }

    var uri = url!.replace(queryParameters: {'page': pag.toString(), 'fields': fields, 'limit': porPagina.toString()});
    var resposta = await http.get(uri, headers: headers);
    if (resposta.statusCode == 200) {
      var retorno = jsonDecode(resposta.body);
      data = retorno['data'];
      quatidadePagina = retorno['pages'];
      count = retorno['count'];
      this.notifyListeners();
    }
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
        cells: campos!.map((e) {
      String campoMap = e.name != null ? "name" : "id";
      int newIndex = index;
      if(index >= porPagina){
        newIndex = index - ((pag - 1) * porPagina);
      }
      if (e.child != null) {
        Widget wid = e.child!(data![newIndex]);
        return DataCell(wid);
      } else {
        return DataCell(Text(data![newIndex][campoMap].toString()));
      }
    }).toList());
  }
}
