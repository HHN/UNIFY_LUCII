import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucii/utils/extentions.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_util.dart';

import 'button_util.dart';
import 'dimens.dart';

void alertForAction(BuildContext context,
    {String? title,
    String? subTitle,
    int? maxLinesSub,
    String? buttonYesTitle,
    VoidCallback? onYesAction,
    String? buttonNoTitle,
    VoidCallback? onNoAction,
    Color? noButtonColor,
    Color? yesButtonColor}) {
  final view = Column(
    children: [
      vSpacer10(),
      if (title.isValid)
        TextAutoMetropolis(title!,
            maxLines: 2,
            fontSize: Dimens.fontSizeMid,
            textAlign: TextAlign.center),
      vSpacer10(),
      if (subTitle.isValid)
        TextAutoPoppins(subTitle!,
            maxLines: maxLinesSub ?? 5, textAlign: TextAlign.center),
      vSpacer15(),
      if (buttonYesTitle.isValid)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonFillMain(
                title: buttonNoTitle,
                onPress: onNoAction,
                bgColor: noButtonColor),
            ButtonFillMain(
                title: buttonYesTitle,
                onPress: onYesAction,
                bgColor: yesButtonColor),
          ],
        ),
      vSpacer10(),
    ],
  );
  showModalSheetScreen(context, view);
}

void alertForSuccessful(BuildContext context,
    {String? title,
    String? subTitle,
    int? maxLinesSub,
    String? buttonYesTitle,
    VoidCallback? onYesAction,
    Color? yesButtonColor}) {
  final view = Container(
    color: context.theme.primaryColorLight,
    child: Column(
      children: [
        vSpacer10(),
        if (title.isValid)
          TextAutoMetropolis(title!,
              maxLines: 2,
              fontSize: Dimens.fontSizeMid,
              textAlign: TextAlign.center),
        vSpacer10(),
        if (subTitle.isValid)
          TextAutoPoppins(subTitle!,
              maxLines: maxLinesSub ?? 5, textAlign: TextAlign.center),
        vSpacer15(),
        if (buttonYesTitle.isValid)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonFillMain(
                  title: buttonYesTitle,
                  onPress: onYesAction,
                  bgColor: yesButtonColor),
            ],
          ),
        vSpacer10(),
      ],
    ),
  );
  showModalSheetScreen(context, view);
}

showModalSheetScreen(BuildContext context, Widget customView,
    {Function? onClose, bool? isDismissible}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: isDismissible ?? true,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimens.paddingMid),
                margin: const EdgeInsets.symmetric(
                    vertical: Dimens.paddingLarge,
                    horizontal: Dimens.paddingMid),
                decoration: BoxDecoration(
                    color: context.theme.primaryColorLight,
                    border: Border.all(
                        color: context.theme.primaryColorLight, width: 1),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Dimens.cornerRadiusMidPlus))),
                child: customView)
          ],
        );
      });
}
//
// void alertForInput(BuildContext context,
//     {String? title,
//       int? maxLinesSub,
//       String? buttonYesTitle,
//       VoidCallback? onYesAction,
//       Function? onSubmitted,
//       Function? onChipDeleted,
//       Function? onSaved,
//       String? buttonNoTitle,
//       Color? yesButtonColor}) {
//
//   String output = '';
//   String? deletedChip, deletedChipIndex;
//   final keySimpleChipsInput = GlobalKey<FormState>();
//   final FocusNode focusNode = FocusNode();
//   const TextFormFieldStyle style = TextFormFieldStyle(
//     keyboardType: TextInputType.phone,
//     cursorColor: Colors.blue,
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.all(0.0),
//       border: InputBorder.none,
//     ),
//   );
//
//   final view = Column(
//     children: [
//       vSpacer10(),
//       if (title.isValid)
//         TextAutoMetropolis(title!,
//             maxLines: 2,
//             fontSize: Dimens.fontSizeMid,
//             textAlign: TextAlign.center),
//       vSpacer10(),
//       Text(
//         deletedChip != null
//             ? 'Deleted chip: $deletedChip at index $deletedChipIndex'
//             : '',
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 16, color: Colors.blue),
//       ),
//       Text(
//         'Output:\n$output',
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 16, color: Colors.blue),
//       ),
//       MaterialButton(
//         color: Colors.blue,
//         onPressed: (() {
//           keySimpleChipsInput.currentState!.save();
//         }),
//         child: const Text(
//           'Submit',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SimpleChipsInput(
//           separatorCharacter: ",",
//           focusNode: focusNode,
//           validateInput: false,
//           formKey: keySimpleChipsInput,
//           textFormFieldStyle: style,
//           // validateInputMethod: (String value) {
//           //   final phoneNumberRegExp =
//           //   RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
//           //   if (!phoneNumberRegExp.hasMatch(value)) {
//           //     return 'Enter a valid phone number';
//           //   }
//           // },
//           onSubmitted: () => onSubmitted,
//           onChipDeleted: onChipDeleted!,
//           onSaved: onSaved!,
//           chipTextStyle: const TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//           deleteIcon: const Icon(
//             Icons.delete,
//             size: 14.0,
//             color: Colors.black,
//           ),
//           widgetContainerDecoration: BoxDecoration(
//             color: Colors.blue[100]!,
//             borderRadius: BorderRadius.circular(16.0),
//             border: Border.all(color: Colors.blue[100]!),
//           ),
//           chipContainerDecoration: BoxDecoration(
//             color: Colors.blue,
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(50),
//           ),
//           placeChipsSectionAbove: false,
//         ),
//       ),
//
//       vSpacer20(),
//       if (buttonYesTitle.isValid)
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ButtonFillMain(
//                 title: buttonYesTitle,
//                 onPress: onYesAction,
//                 bgColor: yesButtonColor),
//           ],
//         ),
//       vSpacer10(),
//     ],
//   );
//   showModalSheetScreen(context, view);
// }
//
// showModalSheetInputScreen(BuildContext context, Widget customView,
//     {Function? onClose, bool? isDismissible}) {
//   showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       context: context,
//       isDismissible: isDismissible ?? true,
//       builder: (context) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ButtonOnlyIcon(
//                     iconData: Icons.cancel_outlined,
//                     iconSize: Dimens.iconSizeMid,
//                     iconColor: Colors.white,
//                     onTap: () {
//                       Get.back();
//                       if (onClose != null) onClose();
//                     }),
//                 hSpacer10(),
//               ],
//             ),
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(Dimens.paddingMid),
//                 margin: const EdgeInsets.symmetric(
//                     vertical: Dimens.paddingLarge,
//                     horizontal: Dimens.paddingMid),
//                 decoration: BoxDecoration(
//                     color: context.theme.primaryColor,
//                     border:
//                     Border.all(color: context.theme.primaryColor, width: 1),
//                     borderRadius: const BorderRadius.all(
//                         Radius.circular(Dimens.cornerRadiusMid))),
//                 child: customView)
//           ],
//         );
//       });
// }

void showBottomSheetFullScreen(BuildContext context, Widget customView,
    {Function? onClose,
    String? title,
    bool isScrollControlled = true,
    double? titleFontSize}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) =>
        BottomSheetView(customView, title: title, titleFontSize: titleFontSize),
  ).whenComplete(() => onClose != null ? onClose() : {});
}

class BottomSheetView extends StatelessWidget {
  const BottomSheetView(this.customView,
      {Key? key, this.title, this.titleFontSize})
      : super(key: key);

  final Widget customView;
  final String? title;
  final double? titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height - 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.cornerRadiusLarge),
                topRight: Radius.circular(Dimens.cornerRadiusLarge))),
        padding: const EdgeInsets.all(Dimens.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isValid)
                  Expanded(
                      child: TextAutoMetropolis(title!,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          fontSize: titleFontSize ?? Dimens.fontSizeMid))
                else
                  hSpacer30(),
                InkResponse(
                    child: Icon(Icons.cancel_outlined,
                        size: Dimens.iconSizeLarge,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () => Navigator.of(context).pop())
              ],
            ),
            customView,
          ],
        ));
  }
}
