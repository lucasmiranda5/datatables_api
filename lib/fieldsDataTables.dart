import 'package:flutter/material.dart';

class FieldsDataTablesAPI{
   final String? label;
      final String? id;
      final String? name;
      final bool? search;
      final bool? order;
      final Widget Function(dynamic data)? child;

  FieldsDataTablesAPI({ @required this.label, this.id, this.name, this.search = true, this.order = true, this.child });  
}
