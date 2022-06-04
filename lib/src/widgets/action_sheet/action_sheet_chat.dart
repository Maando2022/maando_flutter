// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class ActionSheetChat {

  BuildContext context;
  List<ActionSheetAction> listActions;

  ActionSheetChat({@required this.context, @required this.listActions});

  sheetHeader(){
      return PlatformActionSheet().displaySheet(
                    title: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          iconFace1(context),
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(generalText.options(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(33, 36, 41, 1.0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.width * 0.08)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            )
                            ],
                          ),
                        ],
                      ),
                    ),
                  // message: Row(
                  //   children: [
                  //     Text('${generalText.title()}: ',
                  //           style: TextStyle(
                  //               color: Color.fromRGBO(33, 36, 41, 1.0),
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: MediaQuery.of(context).size.width * 0.06)),
                  //     Text(ad["title"],
                  //           style: TextStyle(
                  //               color: Color.fromRGBO(173, 181, 189, 1.0),
                  //               fontSize: MediaQuery.of(context).size.width * 0.05,
                  //               fontWeight: FontWeight.bold),
                  //               ),
                  //   ],
                  // ),
                    context: context,

                    actions: listActions);
  }
}
