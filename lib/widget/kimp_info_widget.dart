import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimp/controller/kimp_controller.dart';

class KimpInfoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KimpController>();
    final style = TextStyle(color: Colors.blueGrey);
    return Padding(padding: EdgeInsets.all(10),
      child: Obx((){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('This is a rate of Upbit/Binance Future', style: style),
            Text('calced by KRW/USD(${controller.krwPerUSD.toString()}).',
                style:style)
          ]);
      }));
  }
}