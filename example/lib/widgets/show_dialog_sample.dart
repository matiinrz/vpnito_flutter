import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../services/constants.dart';


void showDialogSample(
    {required Widget widget,
    required double width,
    required double height,
    backTap,
    bool canDismise = true}) {

  Widget buildNewTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
      child: WillPopScope(
        onWillPop: () async => canDismise,
        child: Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            decoration: const BoxDecoration(),
            height: height,
            width: width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                canDismise
                    ? Positioned(
                    top: -10,
                    right: -10,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: backTap ??
                                () {
                              Get.back();
                            },
                        child: Container(
                          width: Constants.isPhone ? 25.w : 25.0,
                          height: Constants.isPhone ? 25.w : 25.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1.0,
                                    blurRadius: 5.0,
                                    offset: Offset(-2, 2))
                              ]),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                              size: 20.sm,
                            ),
                          ),
                        ),
                      ),
                    ))
                    : Container(),
                widget
              ],
            ),
          ),
        ),
      ),
    );
  }
  showGeneralDialog(
    context: Get.context!,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    // transitionBuilder: (ctx, a1, a2, child) {
    //   var curve = Curves.easeInOut.transform(a1.value);
    //   return Transform.scale(
    //     scale: curve,
    //     child: Dialog(
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    //       child: Container(
    //         decoration: const BoxDecoration(),
    //         height: height,
    //         width: width,
    //         child: Stack(
    //           clipBehavior: Clip.none,
    //           children: [
    //             widget,
    //             canDismise
    //                 ? Positioned(
    //                     top: -10,
    //                     right: -10,
    //                     child: Align(
    //                       alignment: Alignment.topRight,
    //                       child: InkWell(
    //                         onTap: backTap ??
    //                             () {
    //                               Get.back();
    //                             },
    //                         child: Container(
    //                           width: Constants.isPhone ? 25.w : 25.0,
    //                           height: Constants.isPhone ? 25.w : 25.0,
    //                           decoration: const BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               color: Colors.white,
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                     color: Colors.black26,
    //                                     spreadRadius: 1.0,
    //                                     blurRadius: 5.0,
    //                                     offset: Offset(-2, 2))
    //                               ]),
    //                           child: Center(
    //                             child: Icon(
    //                               Icons.close,
    //                               color: Colors.deepOrange,
    //                               size: 20.sm,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ))
    //                 : Container(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // },
    transitionBuilder: buildNewTransition,
    transitionDuration: const Duration(milliseconds: 150),
    barrierDismissible: canDismise,
    barrierLabel:
        MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
  );
  // showDialog(
  //   context: Get.context!,
  //   barrierDismissible: canDismise,
  //   builder: (context) {
  //     return Dialog(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //       child: Container(
  //         decoration: const BoxDecoration(),
  //         height: height,
  //         width: width,
  //         child: Stack(
  //           clipBehavior: Clip.none,
  //           children: [
  //
  //             widget,
  //             canDismise? Positioned(
  //                 top: -10,
  //                 right: -10,
  //                 child: Align(
  //                   alignment: Alignment.topRight,
  //                   child: InkWell(
  //                     onTap: backTap ??
  //                             () {
  //                           Get.back();
  //                         },
  //                     child: Container(
  //                       width:Constants.isPhone ? 25.w : 25.0,
  //                       height: Constants.isPhone ? 25.w : 25.0,
  //                       decoration: const BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: Colors.white,
  //                           boxShadow: [
  //                             BoxShadow(
  //                                 color: Colors.black26,
  //                                 spreadRadius: 1.0,
  //                                 blurRadius: 5.0,
  //                                 offset: Offset(-2, 2))
  //                           ]),
  //                       child: Center(
  //                         child: Icon(
  //                           Icons.close,
  //                           color: Colors.deepOrange,
  //                           size: 20.sm,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )):Container(),
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  // );
}

void showDialogSample2(
    {required Widget widget,
    required double width,
    backTap,
    bool canDismise = true}) {

  Widget buildNewTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
      child: WillPopScope(
        onWillPop: () async => canDismise,
        child:  Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(),
              constraints: BoxConstraints(minHeight: 0.3.sh),
              width: width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  widget,
                  Positioned(
                      top: -10,
                      right: -10,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: backTap ??
                                  () {
                                Get.back();
                              },
                          child: Container(
                            width: Constants.isPhone ? 25.w : 25.0,
                            height: Constants.isPhone ? 25.w : 25.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1.0,
                                      blurRadius: 5.0,
                                      offset: Offset(-2, 2))
                                ]),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.deepOrange,
                                size: 20.sm,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  showGeneralDialog(
    context: Get.context!,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    // transitionBuilder: (ctx, a1, a2, child) {
    //   var curve = Curves.easeInOut.transform(a1.value);
    //   return Transform.scale(
    //     scale: curve,
    //     child: Dialog(
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    //       child: IntrinsicHeight(
    //         child: Container(
    //           decoration: const BoxDecoration(),
    //           constraints: BoxConstraints(minHeight: 0.3.sh),
    //           width: width,
    //           child: Stack(
    //             clipBehavior: Clip.none,
    //             children: [
    //               widget,
    //               Positioned(
    //                   top: -10,
    //                   right: -10,
    //                   child: Align(
    //                     alignment: Alignment.topRight,
    //                     child: InkWell(
    //                       onTap: backTap ??
    //                           () {
    //                             Get.back();
    //                           },
    //                       child: Container(
    //                         width: Constants.isPhone ? 25.w : 25.0,
    //                         height: Constants.isPhone ? 25.w : 25.0,
    //                         decoration: const BoxDecoration(
    //                             shape: BoxShape.circle,
    //                             color: Colors.white,
    //                             boxShadow: [
    //                               BoxShadow(
    //                                   color: Colors.black26,
    //                                   spreadRadius: 1.0,
    //                                   blurRadius: 5.0,
    //                                   offset: Offset(-2, 2))
    //                             ]),
    //                         child: Center(
    //                           child: Icon(
    //                             Icons.close,
    //                             color: Colors.deepOrange,
    //                             size: 20.sm,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   )),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // },
    transitionBuilder: buildNewTransition,
    transitionDuration: const Duration(milliseconds: 150),
    barrierDismissible: canDismise,
    barrierLabel:
        MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
  );

  // showDialog(
  //   context: Get.context!,
  //   barrierDismissible: canDismise,
  //   builder: (context) {
  //     return Dialog(
  //       shape:
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //       child: IntrinsicHeight(
  //         child: Container(
  //           decoration: const BoxDecoration(),
  //           constraints: BoxConstraints(
  //             minHeight: 0.3.sh
  //           ),
  //           width: width,
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //
  //               widget,
  //               Positioned(
  //                   top: -10,
  //                   right: -10,
  //                   child: Align(
  //                     alignment: Alignment.topRight,
  //                     child: InkWell(
  //                       onTap: backTap ??
  //                               () {
  //                             Get.back();
  //                           },
  //                       child: Container(
  //                         width: Constants.isPhone ? 25.w : 25.0,
  //                         height: Constants.isPhone ? 25.w : 25.0,
  //                         decoration: const BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             color: Colors.white,
  //                             boxShadow: [
  //                               BoxShadow(
  //                                   color: Colors.black26,
  //                                   spreadRadius: 1.0,
  //                                   blurRadius: 5.0,
  //                                   offset: Offset(-2, 2))
  //                             ]),
  //                         child: Center(
  //                           child: Icon(
  //                             Icons.close,
  //                             color: Colors.deepOrange,
  //                             size: 20.sm,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   )),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  // );
}


void showDialogSample3({required Widget widget, required double width, required double height, backTap, bool canDismise = true}) {
  // showDialog(
  //   context: Get.context!,
  //   barrierDismissible: canDismise,
  //   builder: (context) {
  //     return WillPopScope(
  //       onWillPop: () async => canDismise,
  //       child: Dialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //         child: IntrinsicHeight(
  //           child: Container(
  //             decoration: const BoxDecoration(),
  //             constraints: BoxConstraints(
  //                 minHeight: height
  //             ),
  //             // height: height,
  //             width: width,
  //             child: Stack(
  //               clipBehavior: Clip.none,
  //               children: [
  //                 Positioned(
  //                     top: -10,
  //                     right: -10,
  //                     child: Align(
  //                       alignment: Alignment.topRight,
  //                       child: InkWell(
  //                         onTap: backTap ??
  //                                 () {
  //                               Get.back();
  //                             },
  //                         child: Container(
  //                           width: Constants.isPhone ? 30.w : 30.0,
  //                           height: Constants.isPhone ? 30.w : 30.0,
  //                           decoration: const BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Colors.white,
  //                               boxShadow: [BoxShadow(color: Colors.black26, spreadRadius: 1.0, blurRadius: 5.0, offset: Offset(-2, 2))]),
  //                           child: Center(
  //                             child: Icon(
  //                               Icons.close,
  //                               color: Colors.deepOrange,
  //                               size: 20.sm,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     )),
  //                 widget
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  // );


  Widget buildNewTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
      child: WillPopScope(
        onWillPop: () async => canDismise,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(),
              constraints: BoxConstraints(
                  minHeight: height
              ),
              // height: height,
              width: width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: -10,
                      right: -10,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: backTap ??
                                  () {
                                Get.back();
                              },
                          child: Container(
                            width: Constants.isPhone ? 30.w : 30.0,
                            height: Constants.isPhone ? 30.w : 30.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black26, spreadRadius: 1.0, blurRadius: 5.0, offset: Offset(-2, 2))]),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.deepOrange,
                                size: 20.sm,
                              ),
                            ),
                          ),
                        ),
                      )),
                  widget
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  showGeneralDialog(
    context: Get.context!,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },

    transitionBuilder: buildNewTransition,
    transitionDuration: const Duration(milliseconds: 150),
    barrierDismissible: canDismise,
    barrierLabel:
    MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
  );
}
