import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimp/controller/kimp_controller.dart';
import 'package:kimp/model/kimp_price.dart';

class KimpListItemWidget extends StatelessWidget{
  final KimpPrice kimpPrice;
  const KimpListItemWidget({Key? key, required this.kimpPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KimpController>();
    onPressed(){ controller.togglePreferred(kimpPrice); }
    var preferredButton = (kimpPrice.preferred == true)
      ? IconButton(icon: Icon(Icons.star, color: Colors.yellow),
          onPressed: onPressed, enableFeedback: false,
          splashColor: Colors.transparent)
      : IconButton(icon: Icon(Icons.star_border_outlined, color: Colors.grey),
          onPressed: onPressed, enableFeedback: false,
          splashColor: Colors.transparent);

    _displayRate(rate){
      var color = Colors.black;
      if (rate > 0.0) color = Colors.green;
      if (rate < 0.0) color = Colors.red;
      return Text(rate.toStringAsFixed(2)+'%',
        style: TextStyle(color:color));
    }

    return Container(
      child: Padding(padding: EdgeInsets.fromLTRB(3, 5, 0, 5),
        child:Row(children: [
          Expanded(flex:1, child: preferredButton),
          Expanded(flex:3, child: Column(children: [
            Text(kimpPrice.base.currency.name),
            Text(kimpPrice.base.currency.symbol,
              style: TextStyle(color: Colors.blueGrey, fontSize: 11))
          ])),
          Expanded(flex:3, child: Column(children: [
            Text(kimpPrice.base.price.toString()),
            Text(kimpPrice.compare.price.toString(),
                style: TextStyle(color: Colors.blueGrey, fontSize: 11))])),
          Expanded(flex:2,
              child: _displayRate(kimpPrice.rateperusd))
        ])));
  }
}