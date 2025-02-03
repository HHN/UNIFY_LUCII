import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:lucii/ui/features/bottom_navigation/posts_notification/post_notification_details/post_notification_incoming_details_screen.dart';
import 'package:lucii/ui/features/bottom_navigation/posts_notification/post_notification_details/post_notification_outgoing_details_screen.dart';
import 'package:lucii/utils/colors.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_field_util.dart';
import 'package:lucii/utils/text_util.dart';

import 'button_util.dart';
import 'dimens.dart';

class EmptyViewWithLoading extends StatelessWidget {
  const EmptyViewWithLoading(
      {super.key, this.message, required this.isLoading, this.height});

  final bool isLoading;
  final String? message;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final messageL = message ?? "No data available".tr;
    return SizedBox(
      height: height ?? 50,
      child: Center(
          child: isLoading
              ? CircularProgressIndicator(color: context.theme.focusColor)
              : TextAutoPoppins(messageL, maxLines: 3)),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key, this.padding, this.size}) : super(key: key);
  final double? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 15),
      child: Center(
          child: SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                  color: Theme.of(context).focusColor))),
    );
  }
}

Widget getTabView({
  List<String>? titles,
  TabController? controller,
  Function(int)? onTap,
  TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.tab,
  List<String>? icons,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Get.theme.primaryColor, width: 0.5))),
    child: TabBar(
      controller: controller,
      labelColor: Get.theme.primaryColor,
      labelStyle: Get.textTheme.titleMedium!
          .copyWith(fontWeight: FontWeight.bold, fontSize: Dimens.fontSizeMid),
      unselectedLabelStyle:
          Get.textTheme.titleMedium!.copyWith(fontSize: Dimens.fontSizeRegular),
      unselectedLabelColor: Get.theme.primaryColor,
      labelPadding: const EdgeInsets.only(left: 0, right: 0),
      indicatorColor: Get.theme.primaryColorDark,
      indicatorSize: indicatorSize,
      tabs: List.generate(titles != null ? titles.length : icons!.length,
          (index) {
        return Tab(
            text: (icons == null && titles != null) ? titles[index] : null,
            icon: (icons != null && titles == null)
                ? SvgPicture.asset(icons[index])
                : null,
            child: (icons != null && titles != null)
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset(icons[index]),
                    const SizedBox(width: 5),
                    Text(titles[index])
                  ])
                : null);
      }),
      onTap: (int x) {
        if (onTap != null) onTap(x);
      },
    ),
  );
}

class SegmentedControlView extends StatelessWidget {
  const SegmentedControlView(this.list, this.selected,
      {Key? key, this.onChange})
      : super(key: key);
  final int selected;
  final Function(int)? onChange;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).textScaleFactor > 1
        ? Dimens.fontSizeSmall
        : Dimens.fontSizeRegular;
    final Map<int, Widget> segmentValues = <int, Widget>{};

    for (int i = 0; i < list.length; i++) {
      segmentValues[i] = Text(list[i],
          style: context.theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize,
              color: selected == i ? Colors.white : context.theme.primaryColor),
          textAlign: TextAlign.center);
    }

    return CupertinoSlidingSegmentedControl(
        groupValue: selected,
        children: segmentValues,
        thumbColor: context.theme.focusColor,
        backgroundColor: Colors.grey.withOpacity(0.25),
        padding: const EdgeInsets.all(Dimens.paddingMin),
        onValueChanged: (i) {
          if (onChange != null) onChange!(i as int);
        });
  }
}

// class DividerVertical extends StatelessWidget {
//   const DividerVertical({Key? key, this.color, this.width = 10, this.height, this.indent}) : super(key: key);
//   final Color? color;
//   final double width;
//   final double? height;
//   final double? indent;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(height: height, child: VerticalDivider(width: width, color: color, thickness: 2, endIndent: indent, indent: indent));
//   }
// }

class DividerHorizontal extends StatelessWidget {
  const DividerHorizontal(
      {Key? key,
      this.color,
      this.width,
      this.height = 10,
      this.indent,
      this.thickness = 0.5})
      : super(key: key);
  final Color? color;
  final double? width;
  final double height;
  final double? indent;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Divider(
            height: height,
            color: color,
            thickness: thickness,
            endIndent: indent,
            indent: indent));
  }
}

boxDecorationRound(BuildContext context) => BoxDecoration(
    color: Theme.of(context).focusColor.withOpacity(0.1),
    borderRadius:
        const BorderRadius.all(Radius.circular(Dimens.cornerRadiusMid)));

Widget iconView(
    {IconData? icon,
    VoidCallback? onPressCallback,
    Color? iconColor,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: Icon(
      icon!,
      size: iconSize,
      color: iconColor,
    ),
  );
}

const double buttonSize = 28.0;

class EventItemView extends StatelessWidget {
  const EventItemView({super.key, required this.context, this.bgColor, this.title, this.details, this.data});

  final BuildContext? context;
  final Color? bgColor;
  final String? title;
  final String? details;
  final List<String>? data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.to(PostNotificationIncomingDetailsScreen(details: details, title: title, keywords: data,)),
          child: title == null ? Container() :
          Card(
            elevation: 10,
            color: bgColor,
            child: Container(
              //decoration: getRoundCornerBox(color: white),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              // height: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title != null && details != null ?AuthTitleView(
                    title: title!.tr,
                    titleFontSize: Dimens.fontSizeMid,
                    subTitle: details!.tr,
                    subMaxLines: 4,
                    subFontSize: Dimens.fontSizeSmall,
                  ) : Container(),
                  vSpacer10(),
                  data!.isEmpty ? Container() :
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return
                          Row(
                            children: [
                              data![index] == "" ? Container() : PhysicalModel(
                                  color: cLightDark,
                                  elevation: 5,
                                  shadowColor: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    alignment: Alignment.center,
                                    height: 20,
                                    child: Text(
                                      data![index],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12),
                                    ),
                                  )
                              ),
                              const SizedBox(width: 1,)
                            ],
                          );
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class EventItemView1 extends StatelessWidget {
  const EventItemView1({super.key, required this.context, this.bgColor});

  final BuildContext? context;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.to(const PostNotificationOutgoingDetailsScreen()),
          child: Card(
            elevation: 15.0,
            color: bgColor,
            child: Container(
              //decoration: getRoundCornerBox(color: white),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // height: 190,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      vSpacer10(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.calendar_month_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis(
                      //             "30.10.2024 - 17:00",
                      //             fontSize: Dimens.fontSizeSmall,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.location_on_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis("Heilbronn",
                      //               fontSize: Dimens.fontSizeSmall),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // vSpacer10(),
                      /*             TextAutoMetropolis("Event Title".tr, fontSize:  Dimens.fontSizeMid,textAlign: TextAlign.start,),
                    TextAutoSpan(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,".tr,
                        subText: "DETAILS".tr,maxLines: 4,
                        textColor: context.theme.primaryColor,
                        subTextColor: context.theme.focusColor,
                        onTap: () => Get.off(() => const SignUpScreen())),*/
                      AuthTitleView(
                        title: "Study Group at Local Cafe".tr,
                        titleFontSize: Dimens.fontSizeMid,
                        subTitle:
                        "Come and join us for a study group at Local Cafe! This event is perfect for intermediate students interested in Homework Help, Exam Prep. A great way to meet new people and enjoy some downtime on campus."
                            .tr,
                        subMaxLines: 4,
                        subFontSize: Dimens.fontSizeSmall,
                      ),
                      vSpacer10(),
                      Row(
                        children: [
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Study',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Cafe',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Group',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: SvgPicture.asset(
                  //     AssetConstants.icCross,
                  //     color: context.theme.primaryColorDark,
                  //     height: 20,
                  //     width: 20,
                  //   ),
                  // ),
                  // ButtonOnlyCircleIcon(
                  //     iconData: Icons.cancel_outlined, onTap: () {}),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   bottom: 8,
        //   child: Row(
        //     children: [
        //       LikeButton(
        //         size: buttonSize,
        //         circleColor: const CircleColor(
        //             start: Color(0xffffb38a), end: Color(0xffFD930B)),
        //         bubblesColor: const BubblesColor(
        //           // dotPrimaryColor: Color(0xff669900),
        //           // dotSecondaryColor: Color(0xff99cc00),
        //           dotPrimaryColor: Color(0xffffb38a),
        //           dotSecondaryColor: Color(0xffFD930B),
        //         ),
        //         likeBuilder: (bool isLiked) {
        //           return Icon(
        //             Icons.favorite,
        //             color: isLiked
        //                 ? context.theme.primaryColorDark
        //                 : context.theme.disabledColor,
        //             size: buttonSize,
        //           );
        //         },
        //         // likeCount: 665,
        //         likeCountAnimationType: LikeCountAnimationType.all,
        //         countBuilder: (int? count, bool isLiked, String text) {
        //           final MaterialColor color =
        //           isLiked ? Colors.green : Colors.grey;
        //           Widget result;
        //           if (count == 0) {
        //             result = Text(
        //               'Favorite',
        //               style: TextStyle(color: color),
        //             );
        //           } else {
        //             result = Text(
        //               text,
        //               style: TextStyle(color: color),
        //             );
        //           }
        //           return result;
        //         },
        //         likeCountPadding: const EdgeInsets.only(left: 15.0),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class EventItemView2 extends StatelessWidget {
  const EventItemView2({super.key, required this.context, this.bgColor});

  final BuildContext? context;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.to(const PostNotificationOutgoingDetailsScreen()),
          child: Card(
            elevation: 10,
            color: bgColor,
            child: Container(
              //decoration: getRoundCornerBox(color: white),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // height: 190,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      // vSpacer10(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.calendar_month_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis(
                      //             "30.10.2024 - 17:00",
                      //             fontSize: Dimens.fontSizeSmall,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.location_on_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis("Heilbronn",
                      //               fontSize: Dimens.fontSizeSmall),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // vSpacer10(),
                      /*             TextAutoMetropolis("Event Title".tr, fontSize:  Dimens.fontSizeMid,textAlign: TextAlign.start,),
                    TextAutoSpan(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,".tr,
                        subText: "DETAILS".tr,maxLines: 4,
                        textColor: context.theme.primaryColor,
                        subTextColor: context.theme.focusColor,
                        onTap: () => Get.off(() => const SignUpScreen())),*/
                      AuthTitleView(
                        title: "Personal Language Coaching".tr,
                        titleFontSize: Dimens.fontSizeMid,
                        subTitle:
                        "Seeking a personal coaching in Language Exchange? Join us at Online! Designed for advanceds, this session helps you excel in Language Exchange."
                            .tr,
                        subMaxLines: 4,
                        subFontSize: Dimens.fontSizeSmall,
                      ),
                      vSpacer10(),
                      Row(
                        children: [
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Workshop',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Language',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Coaching',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: SvgPicture.asset(
                  //     AssetConstants.icCross,
                  //     color: context.theme.primaryColorDark,
                  //     height: 20,
                  //     width: 20,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   bottom: 8,
        //   child: Row(
        //     children: [
        //       LikeButton(
        //         size: buttonSize,
        //         circleColor: const CircleColor(
        //             start: Color(0xffffb38a), end: Color(0xffFD930B)),
        //         bubblesColor: const BubblesColor(
        //           // dotPrimaryColor: Color(0xff669900),
        //           // dotSecondaryColor: Color(0xff99cc00),
        //           dotPrimaryColor: Color(0xffffb38a),
        //           dotSecondaryColor: Color(0xffFD930B),
        //         ),
        //         likeBuilder: (bool isLiked) {
        //           return Icon(
        //             Icons.favorite,
        //             color: isLiked
        //                 ? context.theme.primaryColorDark
        //                 : context.theme.disabledColor,
        //             size: buttonSize,
        //           );
        //         },
        //         // likeCount: 665,
        //         likeCountAnimationType: LikeCountAnimationType.all,
        //         countBuilder: (int? count, bool isLiked, String text) {
        //           final MaterialColor color =
        //           isLiked ? Colors.green : Colors.grey;
        //           Widget result;
        //           if (count == 0) {
        //             result = Text(
        //               'Favorite',
        //               style: TextStyle(color: color),
        //             );
        //           } else {
        //             result = Text(
        //               text,
        //               style: TextStyle(color: color),
        //             );
        //           }
        //           return result;
        //         },
        //         likeCountPadding: const EdgeInsets.only(left: 15.0),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class EventItemView3 extends StatelessWidget {
  const EventItemView3({super.key, required this.context, this.bgColor});

  final BuildContext? context;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.to(const PostNotificationOutgoingDetailsScreen()),
          child: Card(
            elevation: 10,
            color: bgColor,
            child: Container(
              //decoration: getRoundCornerBox(color: white),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // height: 190,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      // vSpacer10(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.calendar_month_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis(
                      //             "30.10.2024 - 17:00",
                      //             fontSize: Dimens.fontSizeSmall,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.location_on_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis("Heilbronn",
                      //               fontSize: Dimens.fontSizeSmall),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // vSpacer10(),
                      /*             TextAutoMetropolis("Event Title".tr, fontSize:  Dimens.fontSizeMid,textAlign: TextAlign.start,),
                    TextAutoSpan(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,".tr,
                        subText: "DETAILS".tr,maxLines: 4,
                        textColor: context.theme.primaryColor,
                        subTextColor: context.theme.focusColor,
                        onTap: () => Get.off(() => const SignUpScreen())),*/
                      AuthTitleView(
                        title: "Coaching in Technical Skills".tr,
                        titleFontSize: Dimens.fontSizeMid,
                        subTitle:
                        "Seeking a personal coaching in Technical Skills, Career Advice? Join us at Community Center! Designed for beginners, this session helps you excel in Technical Skills, Career Advice."
                            .tr,
                        subMaxLines: 4,
                        subFontSize: Dimens.fontSizeSmall,
                      ),
                      vSpacer10(),
                      Row(
                        children: [
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Skill',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Development',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Career',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: SvgPicture.asset(
                  //     AssetConstants.icCross,
                  //     color: context.theme.primaryColorDark,
                  //     height: 20,
                  //     width: 20,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   bottom: 8,
        //   child: Row(
        //     children: [
        //       LikeButton(
        //         size: buttonSize,
        //         circleColor: const CircleColor(
        //             start: Color(0xffffb38a), end: Color(0xffFD930B)),
        //         bubblesColor: const BubblesColor(
        //           // dotPrimaryColor: Color(0xff669900),
        //           // dotSecondaryColor: Color(0xff99cc00),
        //           dotPrimaryColor: Color(0xffffb38a),
        //           dotSecondaryColor: Color(0xffFD930B),
        //         ),
        //         likeBuilder: (bool isLiked) {
        //           return Icon(
        //             Icons.favorite,
        //             color: isLiked
        //                 ? context.theme.primaryColorDark
        //                 : context.theme.disabledColor,
        //             size: buttonSize,
        //           );
        //         },
        //         // likeCount: 665,
        //         likeCountAnimationType: LikeCountAnimationType.all,
        //         countBuilder: (int? count, bool isLiked, String text) {
        //           final MaterialColor color =
        //           isLiked ? Colors.green : Colors.grey;
        //           Widget result;
        //           if (count == 0) {
        //             result = Text(
        //               'Favorite',
        //               style: TextStyle(color: color),
        //             );
        //           } else {
        //             result = Text(
        //               text,
        //               style: TextStyle(color: color),
        //             );
        //           }
        //           return result;
        //         },
        //         likeCountPadding: const EdgeInsets.only(left: 15.0),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class EventItemView11 extends StatelessWidget {
  const EventItemView11({super.key, required this.context, this.bgColor, this.title, this.details, this.data, this.postKeywords,});

  final BuildContext? context;
  final Color? bgColor;
  final String? title;
  final String? details;
  final List<String>? data;
  final List<String>? postKeywords;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.to(PostNotificationIncomingDetailsScreen(title: title!, details: details!, keywords: data, postKeywords: postKeywords,)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              elevation: 10,
              color: bgColor,
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                //decoration: getRoundCornerBox(color: white),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title != null && details != null ?AuthTitleView(
                      title: title!.tr,
                      titleFontSize: Dimens.fontSizeMid,
                      subTitle: details!.tr,
                      subMaxLines: 4,
                      subFontSize: Dimens.fontSizeSmall,
                    ) : Container(),
                    vSpacer10(),
                    data!.isEmpty ? Container() :
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return
                              Row(
                                children: [
                                  data![index] == "" ? Container() : PhysicalModel(
                                      color: cLightDark,
                                      elevation: 5,
                                      shadowColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        alignment: Alignment.center,
                                        height: 20,
                                        child: Text(
                                          data![index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12),
                                        ),
                                      )
                                  ),
                                  const SizedBox(width: 1,)
                                ],
                              );
                          }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class KeyWordPhysicalModel extends StatelessWidget {
  const KeyWordPhysicalModel({super.key, required this.text, this.bgColor});

  final String? text;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColorL = bgColor ?? cLightDark;
    return PhysicalModel(
        color: bgColorL,
        elevation: 2,
        shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          // width: 75,
          height: 20,
          child: Text(
            text!,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
          ),
        ));
  }
}

class EventItemDetailsView extends StatelessWidget {
  const EventItemDetailsView({super.key, required this.context, this.bgColor, this.details, this.keywords, this.title, this.postKeywords, this.profileKeywords});

  final BuildContext? context;
  final Color? bgColor;
  final String? title;
  final String? details;
  final List<String>? keywords;
  final List<String>? postKeywords;
  final List<String>? profileKeywords;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 80.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Card(
            elevation: 10,
            color: bgColor,
            child: Container(
              //decoration: getRoundCornerBox(color: white),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // height: 190,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      vSpacer10(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          iconView(
                              icon: Icons.access_time,iconColor: Colors.grey,
                              iconSize: 20),
                          hSpacer5(),
                           const TextAutoMetropolis(
                            "30.10.2024 - 17:00",
                            fontSize: Dimens.fontSizeSmall,color: Colors.grey,
                          ),
                        ],
                      ),
                      vSpacer10(),
                      AuthTitleView(
                        title: title!.tr,
                        titleFontSize: Dimens.fontSizeMid,
                        subTitle:
                            details!.tr,
                        subMaxLines: 100000,
                        subFontSize: Dimens.fontSizeRegular,
                      ),
                      vSpacer20(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextAutoMetropolis("Post Keywords",
                              color: context.theme.primaryColor,
                              fontSize: Dimens.fontSizeSmall,
                              textAlign: TextAlign.start)),
                      vSpacer10(),
                      postKeywords!.isEmpty ? Container() :
                      SizedBox(
                        height: 30,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: postKeywords!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return
                                Row(
                                  children: [
                                    postKeywords![index] == "" ? Container() : PhysicalModel(
                                        color: cLightDark,
                                        elevation: 5,
                                        shadowColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          alignment: Alignment.center,
                                          height: 20,
                                          child: Text(
                                            postKeywords![index],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12),
                                          ),
                                        )
                                    ),
                                    const SizedBox(width: 1,)
                                  ],
                                );
                            }
                        ),
                      ),
                      const Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextAutoMetropolis("Profile Keywords",
                              color: context.theme.primaryColor,
                              fontSize: Dimens.fontSizeSmall,
                              textAlign: TextAlign.start)),
                      vSpacer10(),
                      profileKeywords!.isEmpty ? Container() :
                      SizedBox(
                        height: 30,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: profileKeywords!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return
                                Row(
                                  children: [
                                    profileKeywords![index] == "" ? Container() : PhysicalModel(
                                        color: cLightDark,
                                        elevation: 5,
                                        shadowColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          alignment: Alignment.center,
                                          height: 20,
                                          child: Text(
                                            profileKeywords![index],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12),
                                          ),
                                        )
                                    ),
                                    const SizedBox(width: 1,)
                                  ],
                                );
                            }
                        ),
                      ),
                      vSpacer10(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextAutoPoppins(
                              "Do you want more content like this?",
                              color: context.theme.primaryColor,
                              fontSize: Dimens.fontSizeSmall,
                              textAlign: TextAlign.start),
                          LikeButton(
                            size: buttonSize,
                            circleColor: const CircleColor(
                                start: Color(0xffffb38a),
                                end: Color(0xffFD930B)),
                            bubblesColor: const BubblesColor(
                              // dotPrimaryColor: Color(0xff669900),
                              // dotSecondaryColor: Color(0xff99cc00),
                              dotPrimaryColor: Color(0xffffb38a),
                              dotSecondaryColor: Color(0xffFD930B),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked
                                    ? context.theme.focusColor
                                    : context.theme.disabledColor,
                                size: buttonSize,
                              );
                            },
                            // likeCount: 665,
                            likeCountAnimationType: LikeCountAnimationType.all,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              final MaterialColor color =
                                  isLiked ? Colors.green : Colors.grey;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  'Favorite',
                                  style: TextStyle(color: color),
                                );
                              } else {
                                result = Text(
                                  text,
                                  style: TextStyle(color: color),
                                );
                              }
                              return result;
                            },
                            likeCountPadding: const EdgeInsets.only(left: 15.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ButtonOnlyCircleIcon(iconData: Icons.cancel_outlined, onTap: () {}),
                ],
              ),
            ),
          ),
          /*Positioned(
            right: 0,
            bottom: 8,
            child: Row(
              children: [
                LikeButton(
                  size: buttonSize,
                  circleColor: const CircleColor(
                      start: Color(0xffffb38a), end: Color(0xffFD930B)),
                  bubblesColor: const BubblesColor(
                    // dotPrimaryColor: Color(0xff669900),
                    // dotSecondaryColor: Color(0xff99cc00),
                    dotPrimaryColor: Color(0xffffb38a),
                    dotSecondaryColor: Color(0xffFD930B),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked
                          ? context.theme.primaryColorDark
                          : context.theme.disabledColor,
                      size: buttonSize,
                    );
                  },
                  // likeCount: 665,
                  likeCountAnimationType: LikeCountAnimationType.all,
                  countBuilder: (int? count, bool isLiked, String text) {
                    final MaterialColor color =
                        isLiked ? Colors.green : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        'Favorite',
                        style: TextStyle(color: color),
                      );
                    } else {
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    }
                    return result;
                  },
                  likeCountPadding: const EdgeInsets.only(left: 15.0),
                ),
                // LikeButton(
                //   size: buttonSize,
                //   circleColor: const CircleColor(
                //       start: Color(0xffffb38a), end: Color(0xffFD930B)),
                //   bubblesColor: const BubblesColor(
                //     // dotPrimaryColor: Color(0xff669900),
                //     // dotSecondaryColor: Color(0xff99cc00),
                //     dotPrimaryColor: Color(0xffffb38a),
                //     dotSecondaryColor: Color(0xffFD930B),
                //   ),
                //   likeBuilder: (bool isLiked) {
                //     return Icon(
                //       Icons.thumb_up,
                //       color: isLiked
                //           ? context.theme.focusColor
                //           : context.theme.disabledColor,
                //       size: buttonSize,
                //     );
                //   },
                //   // likeCount: 665,
                //   likeCountAnimationType: LikeCountAnimationType.all,
                //   countBuilder: (int? count, bool isLiked, String text) {
                //     final MaterialColor color =
                //         isLiked ? Colors.green : Colors.grey;
                //     Widget result;
                //     if (count == 0) {
                //       result = Text(
                //         'Like',
                //         style: TextStyle(color: color),
                //       );
                //     } else {
                //       result = Text(
                //         text,
                //         style: TextStyle(color: color),
                //       );
                //     }
                //     return result;
                //   },
                //   likeCountPadding: const EdgeInsets.only(left: 15.0),
                // ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}

class EventItemOutgoinDetailsView extends StatelessWidget {
  const EventItemOutgoinDetailsView({super.key, required this.context, this.bgColor});

  final BuildContext? context;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 80.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Card(
            elevation: 10,
            color: bgColor,
            child: Container(
              //decoration: getRoundCornerBox(color: white),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // height: 190,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      vSpacer10(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          iconView(
                              icon: Icons.access_time,iconColor: Colors.grey,
                              iconSize: 20),
                          hSpacer5(),
                          const TextAutoMetropolis(
                            "30.10.2024 - 17:00",
                            fontSize: Dimens.fontSizeSmall,color: Colors.grey,
                          ),
                        ],
                      ),
                      vSpacer10(),
                      // vSpacer10(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.calendar_month_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis(
                      //             "30.10.2024 - 17:00",
                      //             fontSize: Dimens.fontSizeSmall,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 3,
                      //       child: Row(
                      //         children: [
                      //           iconView(
                      //               icon: Icons.location_on_outlined,
                      //               iconSize: 20),
                      //           hSpacer5(),
                      //           const TextAutoMetropolis("Heilbronn",
                      //               fontSize: Dimens.fontSizeSmall),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // vSpacer10(),
                      /*             TextAutoMetropolis("Event Title".tr, fontSize:  Dimens.fontSizeMid,textAlign: TextAlign.start,),
                  TextAutoSpan(
                      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,".tr,
                      subText: "DETAILS".tr,maxLines: 4,
                      textColor: context.theme.primaryColor,
                      subTextColor: context.theme.focusColor,
                      onTap: () => Get.off(() => const SignUpScreen())),*/
                      AuthTitleView(
                        title: "Artificial Intelligence".tr,
                        titleFontSize: Dimens.fontSizeMid,
                        subTitle:
                            "Join us for an exciting AI and Machine Learning Workshop in San Francisco! This event is perfect for professionals and enthusiasts eager to dive deep into the latest trends and technologies. Whether you're a seasoned expert or just starting, there's something for everyone."
                                .tr,
                        subMaxLines: 100000,
                        subFontSize: Dimens.fontSizeRegular,
                      ),
                      vSpacer20(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextAutoMetropolis("Post Keywords",
                              color: context.theme.primaryColor,
                              fontSize: Dimens.fontSizeSmall,
                              textAlign: TextAlign.start)),
                      vSpacer10(),
                      Row(
                        children: [
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Workshop',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Technology',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: cLightDark,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'AI',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                      const Divider(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextAutoMetropolis("Profile Keywords",
                              color: context.theme.primaryColor,
                              fontSize: Dimens.fontSizeSmall,
                              textAlign: TextAlign.start)),
                      vSpacer10(),
                      Row(
                        children: [
                          PhysicalModel(
                              color: context.theme.disabledColor,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'AI',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: context.theme.disabledColor,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Machine Learning',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                          hSpacer5(),
                          PhysicalModel(
                              color: context.theme.disabledColor,
                              elevation: 5,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // width: 75,
                                height: 20,
                                child: const Text(
                                  'Trends',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                      vSpacer10(),
                    ],
                  ),
                  // ButtonOnlyCircleIcon(iconData: Icons.cancel_outlined, onTap: () {}),
                ],
              ),
            ),
          ),
          /*Positioned(
            right: 0,
            bottom: 8,
            child: Row(
              children: [
                LikeButton(
                  size: buttonSize,
                  circleColor: const CircleColor(
                      start: Color(0xffffb38a), end: Color(0xffFD930B)),
                  bubblesColor: const BubblesColor(
                    // dotPrimaryColor: Color(0xff669900),
                    // dotSecondaryColor: Color(0xff99cc00),
                    dotPrimaryColor: Color(0xffffb38a),
                    dotSecondaryColor: Color(0xffFD930B),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked
                          ? context.theme.primaryColorDark
                          : context.theme.disabledColor,
                      size: buttonSize,
                    );
                  },
                  // likeCount: 665,
                  likeCountAnimationType: LikeCountAnimationType.all,
                  countBuilder: (int? count, bool isLiked, String text) {
                    final MaterialColor color =
                        isLiked ? Colors.green : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        'Favorite',
                        style: TextStyle(color: color),
                      );
                    } else {
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    }
                    return result;
                  },
                  likeCountPadding: const EdgeInsets.only(left: 15.0),
                ),
                // LikeButton(
                //   size: buttonSize,
                //   circleColor: const CircleColor(
                //       start: Color(0xffffb38a), end: Color(0xffFD930B)),
                //   bubblesColor: const BubblesColor(
                //     // dotPrimaryColor: Color(0xff669900),
                //     // dotSecondaryColor: Color(0xff99cc00),
                //     dotPrimaryColor: Color(0xffffb38a),
                //     dotSecondaryColor: Color(0xffFD930B),
                //   ),
                //   likeBuilder: (bool isLiked) {
                //     return Icon(
                //       Icons.thumb_up,
                //       color: isLiked
                //           ? context.theme.focusColor
                //           : context.theme.disabledColor,
                //       size: buttonSize,
                //     );
                //   },
                //   // likeCount: 665,
                //   likeCountAnimationType: LikeCountAnimationType.all,
                //   countBuilder: (int? count, bool isLiked, String text) {
                //     final MaterialColor color =
                //         isLiked ? Colors.green : Colors.grey;
                //     Widget result;
                //     if (count == 0) {
                //       result = Text(
                //         'Like',
                //         style: TextStyle(color: color),
                //       );
                //     } else {
                //       result = Text(
                //         text,
                //         style: TextStyle(color: color),
                //       );
                //     }
                //     return result;
                //   },
                //   likeCountPadding: const EdgeInsets.only(left: 15.0),
                // ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}

Widget handleEmptyViewWithLoadingEvent(
    {required bool isLoading, double? height, String? message}) {
  String message0 = message ?? "Sorry! Data not found".tr;
  return Container(
      margin: const EdgeInsets.all(16),
      height: height,
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                message0,
                style: Get.textTheme.titleMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
      ));
}

class AuthTitleView extends StatelessWidget {
  const AuthTitleView(
      {super.key,
      required this.title,
      required this.subTitle,
      this.subMaxLines,
      this.titleFontSize,
      this.subFontSize});

  final String title;
  final double? titleFontSize;
  final String subTitle;
  final double? subFontSize;
  final int? subMaxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextAutoMetropolis(
          title,
          fontSize: titleFontSize,
        ),
        TextAutoPoppins(
          subTitle,
          maxLines: subMaxLines,
          fontSize: subFontSize,
        ),
      ],
    );
  }
}

class TextFieldCustomTags1 extends StatelessWidget {
  const TextFieldCustomTags1({
    super.key,
    required this.switchValue,
    required this.onChange,
    required this.titleText,
    required this.stringTagController,
    required this.distanceToField,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final bool? switchValue;
  final Function(bool)? onChange;
  final String? titleText;
  final StringTagController? stringTagController;
  final double? distanceToField;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Card(
          elevation: 15.0,
          margin: const EdgeInsets.all(0.0),
          color: context.theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const OnlyIcon(iconData: Icons.interests_outlined),
                title: Row(
                  children: [
                    Text(
                      titleText!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    // hSpacer10(),
                    ButtonOnlyCircleIcon(
                      iconData: Icons.add,
                      onTap: (){},
                    )
                  ],
                ),
                trailing: CupertinoSwitch(
                  activeColor: context.theme.primaryColorDark,
                  value: switchValue!,
                  onChanged: onChange,
                ),
              ),
              Wrap(
                runSpacing: 4.0,
                spacing: 4.0,
                alignment: WrapAlignment.start,
                children: [
                  text1!.isEmpty
                      ? const Text(' ')
                      : KeyWordPhysicalModel(
                          text: text1,
                          // bgColor: cSlateGray,
                        ),
                  text2!.isEmpty
                      ? const Text(' ')
                      : KeyWordPhysicalModel(
                          text: text2,
                          // bgColor: cSlateGray,
                        ),
                  text3!.isEmpty
                      ? const Text(' ')
                      : KeyWordPhysicalModel(
                          text: text3,
                          // bgColor: cSlateGray,
                        ),
                ],
              ),
              vSpacer15(),
              switchValue == true
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFieldTags<String>(
                            textfieldTagsController: stringTagController!,
                            // initialTags: _initialTags,
                            textSeparators: const [' ', ','],
                            letterCase: LetterCase.normal,
                            validator: (String tag) {
                              if (stringTagController!.getTags!.contains(tag)) {
                                return 'You\'ve already entered that';
                              }
                              return null;
                            },
                            inputFieldBuilder: (context, inputFieldValues) {
                              return TextField(
                                onTap: () {
                                  stringTagController!.getFocusNode
                                      ?.requestFocus();
                                },
                                controller:
                                    inputFieldValues.textEditingController,
                                focusNode: inputFieldValues.focusNode,
                                style: context.textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            Dimens.cornerRadiusMid)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            context.theme.secondaryHeaderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            Dimens.cornerRadiusMid)),
                                    borderSide: BorderSide(
                                        color: context.theme.primaryColorDark),
                                  ),
                                  helperText: 'Enter your input...',
                                  helperStyle: TextStyle(
                                    color: context.theme.primaryColorDark,
                                  ),
                                  hintText: inputFieldValues.tags.isNotEmpty
                                      ? ''
                                      : "Enter text...",
                                  errorText: inputFieldValues.error,
                                  prefixIconConstraints: BoxConstraints(
                                      maxWidth: distanceToField! * 0.8),
                                  prefixIcon: inputFieldValues.tags.isNotEmpty
                                      ? SingleChildScrollView(
                                          controller: inputFieldValues
                                              .tagScrollController,
                                          scrollDirection: Axis.vertical,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 8,
                                            ),
                                            child: Wrap(
                                                runSpacing: 4.0,
                                                spacing: 4.0,
                                                children: inputFieldValues.tags
                                                    .map((String tag) {
                                                  return Container(
                                                    decoration: const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0)),
                                                        color: cDark),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 2.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        InkWell(
                                                          child: Text('#$tag',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          onTap: () {
                                                            //print("$tag selected");
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: 4.0),
                                                        InkWell(
                                                          child: const Icon(
                                                            Icons.cancel,
                                                            size: 14.0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    233,
                                                                    233,
                                                                    233),
                                                          ),
                                                          onTap: () {
                                                            inputFieldValues
                                                                .onTagRemoved(
                                                                    tag);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }).toList()),
                                          ),
                                        )
                                      : null,
                                ),
                                onChanged: inputFieldValues.onTagChanged,
                                onSubmitted: inputFieldValues.onTagSubmitted,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}


class TextFieldCustomTags extends StatelessWidget {
  const TextFieldCustomTags({
    super.key,
    required this.switchValue,
    required this.onChange,
    required this.titleText,
    required this.stringTagController,
    required this.distanceToField,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final bool? switchValue;
  final Function(bool)? onChange;
  final String? titleText;
  final StringTagController? stringTagController;
  final double? distanceToField;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Card(
        elevation: 15.0,
        margin: const EdgeInsets.all(0.0),
        color: context.theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: const OnlyIcon(iconData: Icons.interests_outlined),
              title: Row(
                children: [
                  Text(
                    titleText!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  ButtonOnlyCircleIcon(
                    iconData: Icons.add,
                    onTap: () {
                      // Add logic to create text bubble here
                    },
                  ),
                ],
              ),
              trailing: CupertinoSwitch(
                activeColor: context.theme.primaryColorDark,
                value: switchValue!,
                onChanged: onChange,
              ),
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              alignment: WrapAlignment.start,
              children: [
                text1!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: text1),
                text2!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: text2),
                text3!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: text3),
              ],
            ),
            vSpacer15(),
            switchValue == true
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFieldTags<String>(
                    textfieldTagsController: stringTagController!,
                    textSeparators: const [' ', ','],
                    letterCase: LetterCase.normal,
                    validator: (String tag) {
                      if (stringTagController!.getTags!.contains(tag)) {
                        return 'You\'ve already entered that';
                      }
                      return null;
                    },
                    inputFieldBuilder: (context, inputFieldValues) {
                      return TextField(
                        onTap: () {
                          stringTagController!.getFocusNode?.requestFocus();
                        },
                        controller: inputFieldValues.textEditingController,
                        focusNode: inputFieldValues.focusNode,
                        style: context.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimens.cornerRadiusMid)),
                            borderSide: BorderSide(
                              width: 1,
                              color: context.theme.secondaryHeaderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimens.cornerRadiusMid)),
                            borderSide: BorderSide(
                              color: context.theme.primaryColorDark,
                            ),
                          ),
                          helperText: 'Enter your input...',
                          helperStyle: TextStyle(
                            color: context.theme.primaryColorDark,
                          ),
                          hintText: inputFieldValues.tags.isNotEmpty ? '' : "Enter text...",
                          errorText: inputFieldValues.error,
                          prefixIconConstraints: BoxConstraints(maxWidth: distanceToField! * 0.8),
                          prefixIcon: inputFieldValues.tags.isNotEmpty
                              ? SingleChildScrollView(
                            controller: inputFieldValues.tagScrollController,
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                left: 8,
                              ),
                              child: Wrap(
                                runSpacing: 4.0,
                                spacing: 4.0,
                                children: inputFieldValues.tags.map((String tag) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color: cDark,
                                    ),
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          child: Text('#$tag', style: const TextStyle(color: Colors.white)),
                                          onTap: () {
                                            //print("$tag selected");
                                          },
                                        ),
                                        const SizedBox(width: 4.0),
                                        InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: Color.fromARGB(255, 233, 233, 233),
                                          ),
                                          onTap: () {
                                            inputFieldValues.onTagRemoved(tag);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                              : null,
                        ),
                        onChanged: inputFieldValues.onTagChanged,
                        onSubmitted: inputFieldValues.onTagSubmitted,
                      );
                    },
                  ),
                ],
              ),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

/*class TextFieldCustomTagsWithManualAddText extends StatefulWidget {
  const TextFieldCustomTagsWithManualAddText({
    super.key,
    required this.switchValue,
    required this.onChange,
    required this.titleText,
    required this.stringTagController,
    required this.distanceToField,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final bool? switchValue;
  final Function(bool)? onChange;
  final String? titleText;
  final StringTagController? stringTagController;
  final double? distanceToField;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  State<TextFieldCustomTagsWithManualAddText> createState() => _TextFieldCustomTagsWithManualAddTextState();
}

class _TextFieldCustomTagsWithManualAddTextState extends State<TextFieldCustomTagsWithManualAddText> {
  bool showTextField = false;
  List<String> tags = [];
  TextEditingController textEditingController = TextEditingController();

  void addTag() {
    String tag = textEditingController.text.trim();
    if (tag.isNotEmpty && !tags.contains(tag)) {
      setState(() {
        tags.add(tag);
      });
      textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
      child: Card(
        elevation: 15.0,
        margin: const EdgeInsets.all(0.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
              leading: const OnlyIcon(iconData: Icons.interests_outlined),
              title: Row(
                children: [
                  Text(
                    widget.titleText!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  ButtonOnlyCircleIcon(
                    iconData: Icons.add,
                    onTap: () {
                      setState(() {
                        showTextField = !showTextField;
                      });
                    },
                  ),
                ],
              ),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).focusColor,
                value: widget.switchValue!,
                onChanged: widget.onChange,
              ),
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              alignment: WrapAlignment.start,
              children: [
                widget.text1!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: widget.text1),
                widget.text2!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: widget.text2),
                widget.text3!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: widget.text3),
              ],
            ),
            vSpacer15(),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              children: tags.map((String tag) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('#$tag', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 4.0),
                      InkWell(
                        child: const Icon(
                          Icons.cancel,
                          size: 14.0,
                          color: Color.fromARGB(255, 233, 233, 233),
                        ),
                        onTap: () {
                          setState(() {
                            tags.remove(tag);
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            vSpacer10(),
            showTextField
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldView(
                        controller: textEditingController,
                        hint: "Enter your text input".tr,
                        // helperText: 'Enter your input...',
                        inputType: TextInputType.emailAddress,
                        // validator: (text) => TextFieldValidator.emptyValidator(text,
                        //         message: "Email is required".tr)
                    ),
                  ),
                  hSpacer10(),
                  ElevatedButton.icon(
                    onPressed: addTag,
                    icon: Icon(Icons.add,color: context.theme.primaryColorLight),
                    label: TextAutoPoppins('Add',color: context.theme.primaryColorLight,),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.focusColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}*/

class TextFieldCustomTagsWithManualAddText extends StatefulWidget {
  const TextFieldCustomTagsWithManualAddText({
    super.key,
    required this.switchValue,
    required this.onChange,
    required this.titleText,
    required this.stringTagController,
    required this.distanceToField,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final bool? switchValue;
  final Function(bool)? onChange;
  final String? titleText;
  final StringTagController? stringTagController;
  final double? distanceToField;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  State<TextFieldCustomTagsWithManualAddText> createState() => _TextFieldCustomTagsWithManualAddTextState();
}

class _TextFieldCustomTagsWithManualAddTextState extends State<TextFieldCustomTagsWithManualAddText> {
  bool showTextField = false;
  List<String> tags = [];
  TextEditingController textEditingController = TextEditingController();

  void addTag() {
    String tag = textEditingController.text.trim();
    if (tag.isNotEmpty && !tags.contains(tag)) {
      setState(() {
        tags.add(tag);
      });
      textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
      child: Card(
        elevation: 15.0,
        margin: const EdgeInsets.all(0.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              leading: const OnlyIcon(iconData: Icons.interests_outlined),
              title: Row(
                children: [
                  Text(
                    widget.titleText!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  hSpacer10(),
                  ButtonOnlyCircleIcon(
                    iconData: showTextField ? Icons.remove : Icons.add, iconSize: 25,
                    onTap: () {
                      setState(() {
                        showTextField = !showTextField;
                      });
                    },
                  ),
                ],
              ),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).focusColor,
                value: widget.switchValue!,
                onChanged: widget.onChange,
              ),
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              alignment: WrapAlignment.start,
              children: [
                widget.text1!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: widget.text1),
                widget.text2!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: widget.text2),
                widget.text3!.isEmpty ? const Text(' ') : KeyWordPhysicalModel(text: widget.text3),
              ],
            ),
            vSpacer5(),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              children: tags.map((String tag) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('#$tag', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 4.0),
                      InkWell(
                        child: const Icon(
                          Icons.cancel,
                          size: 14.0,
                          color: Color.fromARGB(255, 233, 233, 233),
                        ),
                        onTap: () {
                          setState(() {
                            tags.remove(tag);
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            vSpacer5(),
            showTextField
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldView(
                      controller: textEditingController,
                      hint: "Enter your text input".tr,
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                  hSpacer10(),
                  ElevatedButton.icon(
                    onPressed: addTag,
                    icon: Icon(Icons.add, color: Theme.of(context).primaryColorLight),
                    label: TextAutoPoppins(
                      'Add',
                      color: Theme.of(context).primaryColorLight,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).focusColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}


Widget buttonSVG(
    {Icon? icon,
    VoidCallback? onPressCallback,
    String iconPath = "",
    double? size,
    Color? iconColor}) {
  return Material(
    color: Colors.transparent,
    child: IconButton(
      onPressed: onPressCallback,
      icon: iconPath.isNotEmpty
          ? iconPath.contains(".svg")
              ? SvgPicture.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
              : Image.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
          : Container(),
    ),
  );
}
