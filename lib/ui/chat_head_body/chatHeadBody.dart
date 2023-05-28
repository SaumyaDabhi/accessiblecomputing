import 'dart:convert';
import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:floatingbubble/constants/constants.dart';
import 'package:floatingbubble/ui/chat_head.dart';
import 'package:floatingbubble/ui/views/charts/chart_options.dart';
import 'package:floatingbubble/ui/views/charts/charts.dart';
import 'package:floatingbubble/ui/views/summary/summary.dart';
import 'package:floatingbubble/ui/views/table/table.dart';
import 'package:floatingbubble/utils/spaces.dart';
import 'package:floatingbubble/widgets/multi_select_dialog_field/custom_button_widget.dart';
import 'package:floatingbubble/widgets/multi_select_dialog_field/multi_select_dialog_field.dart';
import 'package:floatingbubble/widgets/multi_select_dialog_field/util/multi_select_item.dart';
import 'package:flutter/material.dart';
// import 'package:magnifying_glass/magnifying_glass.dart';
// import 'package:floatingbubble/ui/chat_head_body/chatHeadBottom.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';

class ChatHeadBody extends StatefulWidget {
  final Function toggleChatHead;
  final GraphType graphType;
  final ViewType viewType;
  final List<ReorderListModel> reorderList;

  const ChatHeadBody({
    Key key,
    this.toggleChatHead,
    this.graphType,
    this.viewType,
    this.reorderList,
  }) : super(key: key);

  @override
  State<ChatHeadBody> createState() => _ChatHeadBodyState();
}

class _ChatHeadBodyState extends State<ChatHeadBody> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final List<int> randomInts = [0, 1, 2, 3];

  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  List<Widget> pageViewChildren = [];

  List<MultiSelectItem<SelectOption>> _items;

  List<SelectOption> _selectedOptions = [];

  String newGraphImageURL = 'https://seaborn.pydata.org/_images/seaborn-barplot-3.png';

  bool filtersSelected = false;

  final TransformationController _transformationController = TransformationController();

  double correctScaleValue = 0;

  int randomIndex = 0;

  bool showDialog = false;

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  DateTime startDateTime;

  int filterIndex;

  int filterPageViewindex;

  int _currentPage;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page.toInt();
      });
    });

    var rnd = Random();
    randomIndex = 0 + rnd.nextInt(3 - 0);

    startDateTime = DateTime.now();

    for (var loopIndex = 0; loopIndex < widget.reorderList.length; loopIndex++) {
      var randomItem = (randomInts.toList()..shuffle()).first;

      pageViewChildren.add(currentViewComponent(
        ViewType.baseline,
        randomItem,
      ));

      pageViewChildren.add(currentViewComponent(
        widget.reorderList[loopIndex].viewType,
        randomItem,
      ));

      if (widget.reorderList[loopIndex].viewType == ViewType.custom) {
        filterIndex = randomItem;
        filterPageViewindex = pageViewChildren.length - 1;
      }

      randomInts.remove(randomItem);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleFilterDisplay() {
    setState(() => showDialog = !showDialog);
  }

  Widget currentViewComponent(ViewType viewType, int randomlySelectedIndex) {
    switch (viewType) {
      case ViewType.baseline:
        return Charts(
          key: UniqueKey(),
          graphType: widget.graphType,
          selectedOptions: _selectedOptions,
          currentIndex: randomlySelectedIndex,
          toggleFilterDisplay: toggleFilterDisplay,
          isFilterEnabled: false,
        );
        break;
      case ViewType.summary:
        return Summary(
          key: UniqueKey(),
          currentIndex: randomlySelectedIndex,
          currentGraphType: widget.graphType,
        );
        break;
      case ViewType.table:
        return TableView(
          key: UniqueKey(),
          currentIndex: randomlySelectedIndex,
          currentGraphType: widget.graphType,
        );
        break;
      case ViewType.custom:
        return Charts(
          key: UniqueKey(),
          graphType: widget.graphType,
          selectedOptions: _selectedOptions,
          currentIndex: randomlySelectedIndex,
          toggleFilterDisplay: toggleFilterDisplay,
          isFilterEnabled: true,
        );
        break;
      default:
        throw Error();
    }
  }

  void changePageViewIndex(bool isBackward, double currentPage) {
    DateTime endDateTime = DateTime.now();

    Duration timeDifference = endDateTime.difference(startDateTime);

    String curentEventName;

    debugPrint(
        'Current Graph Type :- ${widget.graphType.toString().split('.')[1]}\nCurrent View Type :- ${widget.reorderList[(currentPage ~/ 2)].viewType.toString().split('.')[1]}\nTime Spent :- $timeDifference');

    debugPrint("Current Page :- $currentPage");
    if (isBackward) {
      curentEventName = 'previous_button';

      if (currentPage == 0 || currentPage == 1) {
        _controller.jumpToPage(6);
      } else if (currentPage == 2 || currentPage == 3) {
        _controller.jumpToPage(1);
      } else if (currentPage == 4 || currentPage == 5) {
        _controller.jumpToPage(3);
      } else if (currentPage == 6 || currentPage == 7) {
        _controller.jumpToPage(0);
      }
    } else {
      curentEventName = 'next_button';
      if (currentPage == 0 || currentPage == 1) {
        _controller.jumpToPage(2);
      } else if (currentPage == 2 || currentPage == 3) {
        _controller.jumpToPage(4);
      } else if (currentPage == 4 || currentPage == 5) {
        _controller.jumpToPage(6);
      } else if (currentPage == 6 || currentPage == 7) {
        _controller.jumpToPage(0);
      }
    }

    var firebaseEvent = {
      "view_type": widget.reorderList[(_controller.page ~/ 2)].viewType.toString().split('.')[1],
      "graph_type": widget.graphType.toString().split('.')[1],
      "time_taken": timeDifference.toString(),
    };

    debugPrint('Button Event :- ${jsonEncode(firebaseEvent).toString()}');

    firebaseAnalytics.logEvent(
      name: curentEventName,
      parameters: {
        "button_event": jsonEncode(firebaseEvent).toString(),
      },
    ).onError(
      (error, stackTrace) => debugPrint('Error $error\nStackTrace $stackTrace'),
    );

    startDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.graphType == GraphType.barChart) {
      _items = SelectOption.selectOptionsBarGraph[filterIndex]
          .map((selectOption) => MultiSelectItem<SelectOption>(selectOption, selectOption.name))
          .toList();
    } else {
      _items = SelectOption.selectOptionsLineGraph[filterIndex]
          .map((selectOption) => MultiSelectItem<SelectOption>(selectOption, selectOption.name))
          .toList();
    }

    return WillPopScope(
      onWillPop: () => widget.toggleChatHead(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.02, 0, 0),
          height: MediaQuery.of(context).size.height * 0.85,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            body: Column(
              children: [
                MultiSelectDialogField(
                  // key: GlobalKey<FormFieldState>(),
                  isOpen: showDialog,
                  // chipDisplay: MultiSelectChipDisplay.none(),

                  isChipsDisplayEnabled: filterPageViewindex == _currentPage,
                  dialogHeight: 250,
                  items: _items,
                  itemsTextStyle: const TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                  selectedItemsTextStyle: const TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                  title: const Text("Select Option"),
                  selectedColor: Colors.blue,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  buttonText: Text(
                    "Filter Graph",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 16,
                    ),
                  ),
                  onConfirm: (results) async {
                    // setState(() {});

                    int currentPage = _controller.page.toInt();

                    ViewType currentViewType = widget.reorderList[(currentPage ~/ 2)].viewType;

                    _controller.jumpToPage(currentPage - 1);

                    setState(() {
                      _selectedOptions = results;

                      pageViewChildren.removeAt(currentPage);

                      pageViewChildren.insert(
                          currentPage,
                          currentViewComponent(
                            currentViewType,
                            filterIndex,
                          ));
                    });

                    _controller.jumpToPage(currentPage);

                    // for (var reorderItem in widget.reorderList) {
                    //   pageViewChildren.add(currentViewComponent(
                    //     reorderItem.viewType,
                    //   ));
                    // }
                  },
                ),
                Container(
                  child: Expanded(
                    child: PageView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (int page) {
                        var swipingRight = page > _controller.page;

                        DateTime endDateTime = DateTime.now();

                        Duration timeDifference = endDateTime.difference(startDateTime);

                        String curentEventName;

                        debugPrint(
                            'Current Graph Type :- ${widget.graphType.toString().split('.')[1]}\nCurrent View Type :- ${widget.reorderList[(_controller.page ~/ 2)].viewType.toString().split('.')[1]}\nTime Spent :- $timeDifference');

                        debugPrint("Current Page :- $_controller.page");
                        if (!swipingRight) {
                          curentEventName = 'previous_button';
                        } else {
                          curentEventName = 'next_button';
                        }

                        var firebaseEvent = {
                          "view_type": widget.reorderList[(_controller.page ~/ 2)].viewType
                              .toString()
                              .split('.')[1],
                          "graph_type": widget.graphType.toString().split('.')[1],
                          "time_taken": timeDifference.toString(),
                        };

                        debugPrint('Swipe Event :- ${jsonEncode(firebaseEvent).toString()}');

                        firebaseAnalytics.logEvent(
                          name: curentEventName,
                          parameters: {
                            "swipe_event": jsonEncode(firebaseEvent).toString(),
                          },
                        ).onError(
                          (error, stackTrace) => debugPrint('Error $error\nStackTrace $stackTrace'),
                        );

                        startDateTime = DateTime.now();
                      },
                      itemCount: pageViewChildren.length,
                      itemBuilder: (context, index) {
                        return pageViewChildren[index];
                      },
                      // children: pageViewChildren,
                    ),
                  ),
                ),

                /// Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.HEIGHT_10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Previous Button
                      CustomButton(
                        hasBoxShadow: false,
                        onPressed: () => changePageViewIndex(true, _controller.page),
                        borderRadius: Sizes.RADIUS_80,
                        title: 'Back',
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        width: Sizes.WIDTH_120,
                        textStyle: const TextStyle(
                          color: AppColors.primaryRedColor,
                          fontSize: Sizes.TEXT_SIZE_16,
                        ),
                        color: AppColors.neutralDark,
                      ),

                      /// Horizontal Spacing
                      SpaceW10(),

                      /// Next Button
                      CustomButton(
                        hasBoxShadow: false,
                        onPressed: () => changePageViewIndex(false, _controller.page),
                        borderRadius: Sizes.RADIUS_80,
                        title: 'Next',
                        icon: const Icon(Icons.arrow_forward_ios),
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
            ),
          ),
        ),
      ),
    );
  }
}
