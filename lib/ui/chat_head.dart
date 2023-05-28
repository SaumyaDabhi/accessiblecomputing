import 'dart:convert';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:floatingbubble/constants/constants.dart';
import 'package:floatingbubble/ui/chat_head_body/chatHeadBody.dart';
import 'package:floatingbubble/utils/spaces.dart';
import 'package:floatingbubble/widgets/multi_select_dialog_field/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ReorderListModel {
  int index;
  String title;
  ViewType viewType;

  ReorderListModel({
    this.index,
    this.title,
    this.viewType,
  });

  ReorderListModel.fromJson(Map<String, dynamic> json) {
    index = json['index'] as int;
    title = json['title'] as String;
    viewType = json['view_type'] as ViewType;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['title'] = title;
    data['view_type'] = viewType.toString();
    return data;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _floatingKey = GlobalKey();
  bool chatHeadOpened = false;
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  // getting size of chat head
  Size floatingSize;

  // Initial Location of Chat Head
  Offset floatingLocation = const Offset(0, 40);

  InAppWebViewController webViewController;

  GraphType currentGraphType = GraphType.barChart;

  ViewType currentViewType = ViewType.baseline;

  List<ReorderListModel> _listOrder = [
    ReorderListModel(
      index: 0,
      title: 'Baseline magnification',
      viewType: ViewType.baseline,
    ),
    ReorderListModel(
      index: 1,
      title: 'Chart Text summary',
      viewType: ViewType.summary,
    ),
    ReorderListModel(
      index: 2,
      title: 'Table of Content and Caption',
      viewType: ViewType.table,
    ),
    ReorderListModel(
      index: 3,
      title: 'Our Novel Implementation',
      viewType: ViewType.custom,
    ),
  ];

  List<ReorderListModel> _tempListOrder = [
    ReorderListModel(
      index: 0,
      title: 'Baseline magnification',
      viewType: ViewType.baseline,
    ),
    ReorderListModel(
      index: 1,
      title: 'Chart Text summary',
      viewType: ViewType.summary,
    ),
    ReorderListModel(
      index: 2,
      title: 'Table of Content and Caption',
      viewType: ViewType.table,
    ),
    ReorderListModel(
      index: 3,
      title: 'Our Novel Implementation',
      viewType: ViewType.custom,
    ),
  ];

  void getFloatingSize() async {
    RenderBox _floatingBox = _floatingKey.currentContext.findRenderObject();
    floatingSize = _floatingBox.size;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getFloatingSize());

    super.initState();
  }

  _toggleChatHead() {
    setState(() {
      chatHeadOpened = !chatHeadOpened;
      // if ChatHead == Opened, it will be placed at top right of the screen alongside other widgets
      if (chatHeadOpened) {
        floatingLocation = const Offset(0, 40);
      }
      // if ChatHead == closed, it will align on right, same place where it opened on top right corner
      else {
        floatingLocation = Offset(MediaQuery.of(context).size.width - floatingSize.width, 40);
      }
    });
  }

  _openChatHead() async {
    var currentScrollPositionY = await webViewController.getScrollY();
    debugPrint('Current Scroll Position Y :- $currentScrollPositionY');

    _toggleChatHead();

    /// 1000 - Bar Graph
    /// 1500 - Line Graph
    /// 2000 - Pie Chart
  }

  Future<bool> _openReorederList() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 75,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            elevation: 16,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: GraphType.barChart,
                        groupValue: currentGraphType,
                        onChanged: (GraphType value) {
                          setState(() => currentGraphType = GraphType.barChart);
                        },
                      ),
                      GestureDetector(
                        onTap: () => setState(() => currentGraphType = GraphType.barChart),
                        child: const Text('Bar Chart'),
                      ),
                      Radio(
                        value: GraphType.lineChart,
                        groupValue: currentGraphType,
                        onChanged: (GraphType value) {
                          setState(() => currentGraphType = GraphType.lineChart);
                        },
                      ),
                      GestureDetector(
                        onTap: () => setState(() => currentGraphType = GraphType.lineChart),
                        child: const Text('Line Chart'),
                      ),
                    ],
                  ),

                  ReorderableListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _tempListOrder.length,
                    itemBuilder: (context, index) {
                      final String productName = _tempListOrder[index].title;
                      return Container(
                        key: ValueKey(productName),
                        color: Colors.amberAccent,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            productName,
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: const Icon(Icons.drag_handle),
                        ),
                      );
                    },
                    // The reorder function
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final element = _tempListOrder.removeAt(oldIndex);
                        _tempListOrder.insert(newIndex, element);
                      });
                    },
                  ),

                  // Vertical Spacing
                  SpaceH24(),

                  /// Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.HEIGHT_10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /// No Button
                        CustomButton(
                          hasBoxShadow: false,
                          onPressed: () => Navigator.of(context).pop(false),
                          borderRadius: Sizes.RADIUS_80,
                          title: 'Cancel',
                          width: Sizes.WIDTH_120,
                          textStyle: const TextStyle(
                            color: AppColors.primaryRedColor,
                            fontSize: Sizes.TEXT_SIZE_16,
                          ),
                          color: AppColors.neutralDark,
                        ),

                        /// Horizontal Spacing
                        SpaceW10(),

                        /// Yes Button
                        CustomButton(
                          hasBoxShadow: false,
                          onPressed: () {
                            return Navigator.of(context).pop(true);
                          },
                          borderRadius: Sizes.RADIUS_80,
                          title: 'Confirm',
                          width: Sizes.WIDTH_120,
                          textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: Sizes.TEXT_SIZE_16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],

                // Vertical Spacing
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: GestureDetector(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0),
                  ),
                  child: InAppWebView(
                    initialOptions: InAppWebViewGroupOptions(
                      // ios: IOSInAppWebViewOptions(
                      //   allowsBackForwardNavigationGestures: false,
                      //   maximumZoomScale: 1.0,
                      //   minimumZoomScale: 1.0,
                      //   pageZoom: 1.0,
                      // ),
                      crossPlatform: InAppWebViewOptions(
                          // useShouldOverrideUrlLoading: true,
                          // disableHorizontalScroll: true,
                          // horizontalScrollBarEnabled: false,
                          // javaScriptEnabled: true,
                          ),
                    ),
                    onZoomScaleChanged: (controller, oldScale, newScale) {
                      debugPrint("Old Scale $oldScale New Scale $newScale");
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      debugPrint('Console message $consoleMessage');

                      // var jsMessage = consoleMessage.message;

                      // if (jsMessage.contains('LONG_PRESS')) {
                      //   _toggleChatHead();
                      // }

                      // if (jsMessage.contains('LONG_PRESS_BAR_GRAPH')) {
                      //   setState(() => clickCountBarGraph++);
                      //   setState(() => currentGraphType = GraphType.barChart);
                      //   clickCountResolver(GraphType.barChart);
                      //   // switch (jsMessage) {
                      //   //   case 'LONG_PRESS_BAR_GRAPH':
                      //   //     setState(() => currentViewType = ViewType.baseline);
                      //   //     break;
                      //   // }
                      // } else if (jsMessage.contains('LONG_PRESS_LINE_GRAPH')) {
                      //   setState(() => clickCountLineGraph++);
                      //   setState(() => currentGraphType = GraphType.lineChart);
                      //   clickCountResolver(GraphType.lineChart);
                      //   // switch (jsMessage) {
                      //   //   case 'LONG_PRESS_LINE_GRAPH':
                      //   //     setState(() => currentViewType = ViewType.baseline);
                      //   //     break;
                      //   // }
                      // } else if (jsMessage.contains('LONG_PRESS_PIE_GRAPH')) {
                      //   setState(() => clickCountPieGraph++);
                      //   setState(() => currentGraphType = GraphType.pieChart);
                      //   clickCountResolver(GraphType.pieChart);
                      //   // switch (jsMessage) {
                      //   //   case 'LONG_PRESS_PIE_GRAPH':
                      //   //     setState(() => currentViewType = ViewType.baseline);
                      //   //     break;
                      //   // }
                      // }
                    },
                    shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
                      var url = shouldOverrideUrlLoadingRequest.request.url.toString();
                      debugPrint("URL: $url");

                      return NavigationActionPolicy.ALLOW;
                    },
                    initialUrlRequest: URLRequest(
                      url: Uri.parse('https://accessiblecomputing.netlify.app/'),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, Uri uri) {
                      debugPrint("onLoadStart $uri");
                    },
                    onLoadStop: (InAppWebViewController controller, Uri uri) async {
                      debugPrint("onLoadStop $uri");
                      // await controller.evaluateJavascript(
                      //     source:
                      //         "document.getElementsByClassName('centered-top')[0].remove(); document.getElementsByClassName('centered-top-container')[0].remove(); document.getElementsByClassName('flat-icon-button ripple')[0].remove(); document.getElementsByClassName('post-bottom')[0].remove(); document.getElementById('comments').remove(); document.getElementById('footer').remove();");
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {},
                  ),
                ),
              ),
              if (chatHeadOpened)
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(1),
                      ),
                    ),
                  ),
                ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: floatingLocation.dx,
                top: floatingLocation.dy,
                child: chatHead(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatHead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                if (!chatHeadOpened) {
                  DateTime startDateTime = DateTime.now();

                  final bool isSet = await _openReorederList();
                  if (isSet != null && isSet) {
                    setState(() => _listOrder = List.from(_tempListOrder));

                    DateTime endDateTime = DateTime.now();

                    Duration timeDifference = endDateTime.difference(startDateTime);

                    var firebaseEvent = {
                      "reorder_list": jsonEncode(_listOrder.map((e) => e.toJson()).toList()),
                      "time_taken": timeDifference.toString(),
                    };

                    debugPrint('Counter Balance :- ${jsonEncode(firebaseEvent).toString()}');

                    firebaseAnalytics.logEvent(
                      name: 'counter_balance',
                      parameters: {
                        "reorder_list": firebaseEvent,
                      },
                    ).onError(
                      (error, stackTrace) => debugPrint('Error $error\nStackTrace $stackTrace'),
                    );

                    _toggleChatHead();
                  } else {
                    setState(() => _tempListOrder = List.from(_listOrder));
                  }
                } else {
                  _toggleChatHead();
                }
              },
              child: Container(
                key: _floatingKey,
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360.0),
                    color: const Color(0xff4267B2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                      )
                    ]),
                child: const CircleAvatar(
                    // backgroundImage: AssetImage('assets/hamza.jpeg'),
                    ),
              ),
            )
          ],
        ),
        chatHeadOpened
            ? ChatHeadBody(
                toggleChatHead: _toggleChatHead,
                graphType: currentGraphType,
                viewType: currentViewType,
                reorderList: _listOrder,
              )
            : Container()
      ],
    );
  }
}
