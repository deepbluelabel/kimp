import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kimp/model/kimp_price.dart';

class KimpListItemWidget extends StatelessWidget{
  final KimpPrice kimpPrice;
  const KimpListItemWidget({Key? key, required this.kimpPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(children: [
          Expanded(flex:1, child: Text(kimpPrice.base.currency.name)),
          Expanded(flex:2, child: Column(children: [
            Text(kimpPrice.base.price.toString()),
            Text(kimpPrice.compare.price.toString(),
                style: TextStyle(color: Colors.grey))])),
          Expanded(flex:1,
              child: Text(kimpPrice.rateperusd.toStringAsFixed(2)+'%'))
        ]));
  }
}