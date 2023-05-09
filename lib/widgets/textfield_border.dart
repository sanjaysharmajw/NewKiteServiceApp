//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutx/themes/text_style.dart';
// import 'package:nirbhaya_service/color_constant.dart';
//
// class TextFieldBorder extends StatelessWidget {
//   late final OutlineInputBorder outlineInputBorder;
//   const TextFieldBorder({Key? key, required this.outlineInputBorder}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     outlineInputBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4)),
//       borderSide: BorderSide(
//         color: Colors.transparent,
//       ),
//     );
//     return TextFormField(
//       style: FxTextStyle.bodyMedium(),
//       decoration: InputDecoration(
//           floatingLabelBehavior:
//           FloatingLabelBehavior.never,
//           filled: true,
//           isDense: true,
//           fillColor: appBlue,
//           prefixIcon: Icon(
//             FeatherIcons.mail,
//             color: appBlue,
//           ),
//           hintText: "Email Address",
//           enabledBorder: outlineInputBorder,
//           focusedBorder: outlineInputBorder,
//           border: outlineInputBorder,
//           contentPadding: FxSpacing.all(16),
//           hintStyle: FxTextStyle.bodyMedium(),
//           isCollapsed: true),
//       maxLines: 1,
//       controller: controller.emailTE,
//       validator: controller.validateEmail,
//       cursorColor: theme.colorScheme.onBackground,
//     ),
//   }
// }
