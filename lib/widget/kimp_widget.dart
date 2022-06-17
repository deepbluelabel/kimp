import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kimp/widget/kimp_list_widget.dart';

import 'kimp_info_widget.dart';
import 'kimp_list_type_selector_widget.dart';

class KimpWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kimp',
        style: TextStyle(color:Colors.black)), backgroundColor: Colors.white),
      body: Column(children: [
        KimpInfoWidget(),
        KimpListTypeSelectorWidget(),
        Expanded(child:KimpListWidget())
      ],)
    );
  }
}