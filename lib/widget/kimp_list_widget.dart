import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimp/controller/kimp_controller.dart';

import 'kimp_list_item_widget.dart';

class KimpListWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KimpController>();
    return Obx((){
      return (controller.state == KimpControllerState.NOTINIT)
        ? Container(child:Center(child:CircularProgressIndicator()))
        : Container(
            child: ListView.builder(
              itemCount: controller.kimpPrices.length,
              itemBuilder: (context, index){
                return KimpListItemWidget(
                    kimpPrice:controller.kimpPrices[index]);
              }));
    });
  }
}