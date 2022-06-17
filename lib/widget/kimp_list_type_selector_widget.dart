import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:kimp/controller/kimp_controller.dart';

class KimpListTypeSelectorWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KimpController>();
    final groupButtonController = GroupButtonController();
    final listType = (controller.state == KimpControllerState.PREFERRED) ? 1 : 0;
    groupButtonController.selectIndex(listType);
    return Obx((){
      return (controller.state == KimpControllerState.NOTINIT)
          ? Container()
          : LayoutBuilder(builder: (context, constraints){
              final width = constraints.biggest.width;
              return Container(
                alignment: Alignment.centerRight,
                width: width,
                padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: GroupButton<String>(
                  controller: groupButtonController,
                  isRadio: true,
                  buttons: ['All', 'Preferred'],
                  options: GroupButtonOptions(
                    unselectedColor: Colors.transparent,
                    selectedColor: Colors.lightGreen,
                    selectedTextStyle: TextStyle(fontSize:11,
                        color: Colors.white),
                    unselectedTextStyle: TextStyle(fontSize:11,
                        color: Colors.black)
                  ),
                  onSelected: (value, index, isSelected){
                    if (index == 1)
                      controller.setState(KimpControllerState.PREFERRED);
                    else
                      controller.setState(KimpControllerState.ALL);
                  }
                )
              );
            });
    });
  }

}