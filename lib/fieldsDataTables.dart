import 'package:fluent_ui/fluent_ui.dart';

class FieldsDataTablesAPI {
  final String? label;
  final String? id;
  final String? name;
  final bool? search;
  final bool? order;
  final Widget Function(dynamic data)? child;

  FieldsDataTablesAPI({@required this.label, this.id, this.name, this.search = true, this.order = true, this.child});

  Map toJson() {
    return {"label": label, "id": id, "name": name, "search": search, "order": order};
  }
}
