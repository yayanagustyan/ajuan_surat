import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../base/routes.dart';
import 'button_style.dart';
import 'constant.dart';
import 'helper.dart';
import 'my_colors.dart';
import 'p_dialog.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

enum TPosition {
  top,
  bottom,
  center,
  topLeft,
  topRight,
  bottomLeft,
  bottomRright,
  centerLeft,
  centerRight,
  snackbar,
}

dynamic showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

dynamic showToast({
  required String message,
  required BuildContext context,
  TPosition position = TPosition.bottom,
  Color backGroundColor = colorBlack70,
  TextAlign alignment = TextAlign.start,
}) {
  FToast fToast = FToast().init(context);
  ToastGravity poss = ToastGravity.BOTTOM;
  if (position == TPosition.bottom) {
    poss = ToastGravity.BOTTOM;
  } else if (position == TPosition.center) {
    poss = ToastGravity.CENTER;
  } else if (position == TPosition.top) {
    poss = ToastGravity.TOP;
  }

  fToast.showToast(
      child: content(context, message,
          color: backGroundColor, textAlign: alignment),
      gravity: poss);
}

late ProgressDialog pd;
showPDialog(BuildContext context) {
  pd = ProgressDialog(context: context);
  if (!pd.isOpen()) {
    pd.show(max: 100, msg: "Loading ...");
  }
}

bool isShowing() {
  return pd.isOpen();
}

hidePDialog() {
  if (pd.isOpen()) {
    pd.close();
  }
}

Widget content(BuildContext _context, String _message,
    {Color color = colorBlack70, TextAlign textAlign = TextAlign.start}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    ),
    child: Text(
      _message,
      textAlign: textAlign,
      style: const TextStyle(
        color: colorWhite,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
  );
}

customAppBar(
  BuildContext context,
  String title, {
  String subtitle = "",
  List<Widget>? actions,
  bool leading = true,
  double elevation = 1,
  void Function()? onTap,
}) {
  return AppBar(
    elevation: elevation,
    iconTheme: const IconThemeData(color: colorWhite),
    backgroundColor: colorPrimary,
    leading: leading
        ? InkWell(
            onTap: () {
              if (onTap != null) {
                onTap();
              } else {
                backStep(context);
              }
            },
            child: const Icon(Icons.arrow_back),
          )
        : null,
    leadingWidth: 50,
    automaticallyImplyLeading: leading,
    centerTitle: false,
    titleSpacing: leading ? 0 : 15,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: colorWhite, fontSize: 18),
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: const TextStyle(color: colorWhite, fontSize: 12),
          ),
      ],
    ),
    actions: actions,
  );
}

Widget textFieldBuild(
    String title,
    String hintText,
    TextEditingController _controller,
    TextInputType _textType,
    bool isReadOnly) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        child: Text(title, style: TextStyles.txtBody),
      ),
      TextFormField(
        readOnly: isReadOnly,
        controller: _controller,
        cursorColor: colorPrimary,
        keyboardType: _textType,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          focusedBorder: BorderStyles.focusBorder,
          border: BorderStyles.textFieldBorder,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(
            14.0,
          ),
        ),
        style: TextStyles.txtBody,
        validator: (value) {
          if (value!.isEmpty) {
            return '$title tidak boleh kosong !';
          }
          return null;
        },
      )
    ],
  );
}

class RoundedWidget extends StatelessWidget {
  final BuildContext context;
  final String title;

  final TextEditingController controller;
  final FocusNode focusNode = FocusNode();
  final TextInputType inputType = TextInputType.text;
  final TextInputAction inputAction = TextInputAction.next;
  final TextCapitalization? capital;
  final FocusNode nextFocus = FocusNode();
  final bool? enabled;
  final Function(String)? onChanged;

  RoundedWidget({
    Key? key,
    required this.context,
    required this.title,
    required this.controller,
    focusNode,
    nextFocus,
    inputType = TextInputType.text,
    inputAction = TextInputAction.next,
    this.capital,
    this.enabled,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        enabled: true,
        controller: controller,
        cursorColor: colorPrimary,
        textCapitalization: capital!,
        focusNode: focusNode,
        textInputAction: inputAction,
        keyboardType: inputType,
        maxLines: inputType == TextInputType.multiline ? 3 : 1,
        minLines: inputType == TextInputType.multiline ? 3 : 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: colorWhite,
          filled: true,
          hintText: title.replaceAll("*", "") == "pesan"
              ? "Apa Yang Ingin Anda Sampaikan"
              : title.replaceAll("*", ""),
          hintStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
          focusedBorder: inputType == TextInputType.multiline
              ? BorderStyles.focusBorderMulti
              : BorderStyles.focusBorder,
          enabledBorder: inputType == TextInputType.multiline
              ? BorderStyles.focusBorderMulti
              : BorderStyles.focusBorder,
          border: inputType == TextInputType.multiline
              ? BorderStyles.textFieldBorderMulti
              : BorderStyles.textFieldBorder,
          contentPadding: const EdgeInsets.all(10.0),
        ),
        style: TextStyles.txtEdit,
        validator: (value) {
          if (value!.isEmpty) {
            return '$title tidak boleh kosong !';
          }
          return null;
        },
      ),
    );
  }
}

Widget roundComboBox({
  required String title,
  required TextEditingController controller,
  Function()? onTap,
  FocusNode? focusNode,
  TextInputType inputType = TextInputType.text,
  TextInputAction textAction = TextInputAction.done,
  TextCapitalization capital = TextCapitalization.none,
  BuildContext? context,
  FocusNode? nextFocus,
  bool? enabled = true,
  String? hint = "",
  bool unfocus = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 10),
        child: Text(
          title,
          style: const TextStyle(color: colorDark),
        ),
      ),
      SizedBox(
        height: inputType == TextInputType.multiline ? 70 : 40,
        child: TextFormField(
          onTap: onTap,
          controller: controller,
          enableInteractiveSelection: false,
          focusNode: AlwaysDisabledFocusNode(),
          onFieldSubmitted: (term) {
            fieldFocusChange(context!, focusNode!, nextFocus!);
          },
          cursorColor: colorPrimary,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 20),
            fillColor: colorWhite,
            filled: true,
            hintText:
                hint!.isNotEmpty ? hint : "Pilih " + title.replaceAll("* ", ""),
            hintStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
            focusedBorder: inputType == TextInputType.multiline
                ? BorderStyles.focusBorderMulti
                : BorderStyles.focusBorder,
            enabledBorder: inputType == TextInputType.multiline
                ? BorderStyles.focusBorderMulti
                : BorderStyles.focusBorder,
            border: inputType == TextInputType.multiline
                ? BorderStyles.textFieldBorderMulti
                : BorderStyles.textFieldBorder,
            contentPadding: const EdgeInsets.all(12.0),
          ),
          style: TextStyles.txtEdit,
        ),
      ),
    ],
  );
}

Widget pinTextField({
  required String title,
  required TextEditingController controller,
  FocusNode? focusNode,
  FocusNode? nextFocus,
  TextInputType? inputType = TextInputType.text,
  Widget? prefixIcon,
  bool border = true,
  bool enable = true,
  bool bold = false,
  bool isedit = false,
  TextAlign alignment = TextAlign.right,
  Function(String)? onSubmitted,
}) {
  return SizedBox(
    height: 45,
    child: Focus(
      onFocusChange: (value) {
        if (value) {
          controller.text = controller.text.replaceAll(",", "");
        } else {
          if (!controller.text.contains(",")) {
            controller.text = nF(controller.text);
          }
        }
      },
      child: TextFormField(
        enabled: enable,
        controller: controller,
        textAlign: alignment,
        keyboardType: InputType.nums,
        textInputAction: InputAction.done,
        obscureText: true,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        onTap: () {},
        style: bold
            ? const TextStyle(
                color: colorPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              )
            : const TextStyle(
                color: colorPrimary,
                fontWeight: FontWeight.normal,
                fontSize: 46,
              ),
        decoration: InputDecoration(
          hintText: title,
          contentPadding: const EdgeInsets.only(bottom: 0, left: 0),
          prefixIcon: prefixIcon,
          border: BorderStyles.textBottomBorder,
          focusedBorder:
              border ? BorderStyles.textBottomBorder : BorderStyles.noBorder,
          enabledBorder: (isedit || border)
              ? BorderStyles.textBottomBorder
              : BorderStyles.noBorder,
          disabledBorder: controller.text.isEmpty
              ? BorderStyles.textBottomBorder
              : BorderStyles.noBorder,
        ),
      ),
    ),
  );
}

Widget flatTextField({
  required String title,
  required TextEditingController controller,
  Widget? prefixIcon,
  bool border = true,
  bool enable = true,
  bool bold = false,
  bool isedit = false,
  TextAlign alignment = TextAlign.right,
  Function(String)? onSubmitted,
}) {
  return SizedBox(
    height: 25,
    child: Focus(
      onFocusChange: (value) {
        if (value) {
          controller.text = controller.text.replaceAll(",", "");
        } else {
          if (controller.text.isNotEmpty) {
            if (!controller.text.contains(",")) {
              controller.text = nF(controller.text);
            }
          }
        }
      },
      child: TextFormField(
        enabled: enable,
        controller: controller,
        textAlign: alignment,
        keyboardType: InputType.nums,
        textInputAction: InputAction.done,
        onChanged: (value) {},
        onFieldSubmitted: (value) {
          if (controller.text.isNotEmpty) {
            if (!controller.text.contains(",")) {
              controller.text = nF(controller.text);
            }
          }
        },
        onTap: () {},
        style: bold
            ? const TextStyle(
                color: colorBlack100,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            : const TextStyle(
                color: colorBlack100,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
        decoration: InputDecoration(
          hintText: title,
          contentPadding: const EdgeInsets.only(bottom: 7),
          prefixIcon: prefixIcon,
          border: BorderStyles.textBottomBorder,
          focusedBorder:
              border ? BorderStyles.textBottomBorder : BorderStyles.noBorder,
          enabledBorder: (isedit || border)
              ? BorderStyles.textBottomBorder
              : BorderStyles.noBorder,
          disabledBorder:
              border ? BorderStyles.textBottomBorder : BorderStyles.noBorder,
        ),
      ),
    ),
  );
}

roundedDropDownField({
  required String title,
  required String value,
  required List<DropdownMenuItem<String>> items,
  required Function(String?) onChanged,
  double fontSize = 14,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 10),
        child: Text(
          title,
          style: TextStyle(color: colorDark, fontSize: fontSize),
        ),
      ),
      SizedBox(
        height: 40,
        child: DropdownButtonFormField(
          isExpanded: true,
          isDense: true,
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: const InputDecoration(
            fillColor: colorWhite,
            filled: true,
            focusedBorder: BorderStyles.focusBorder,
            enabledBorder: BorderStyles.focusBorder,
            border: BorderStyles.textFieldBorder,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        ),
      ),
    ],
  );
}

Widget roundedTextField({
  required String title,
  required TextEditingController controller,
  double fontSize = 14,
  bool showTitle = true,
  FocusNode? focusNode,
  TextInputType? inputType = TextInputType.text,
  TextInputAction textAction = TextInputAction.next,
  TextCapitalization capital = TextCapitalization.none,
  BuildContext? context,
  FocusNode? nextFocus,
  bool? enabled = true,
  String? hint = "",
  bool unfocus = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool readOnly = false,
  TextAlign alignment = TextAlign.left,
  Function()? ontap,
  Function(String)? onSearch,
  Function(String)? onChanged,
  bool numformat = true,
  int maxLength = 100,
  bool asPassword = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      showTitle
          ? Padding(
              padding: const EdgeInsets.only(bottom: 2, top: 10),
              child: Text(
                title,
                style: TextStyle(color: colorDark, fontSize: fontSize),
              ),
            )
          : const SizedBox(height: 5),
      SizedBox(
        height: inputType == TextInputType.multiline ? 70 : 40,
        child: Focus(
          onFocusChange: (value) {
            if (inputType == InputType.nums) {
              if (numformat) {
                if (controller.text.isNotEmpty) {
                  if (!value) {
                    controller.text = nF(controller.text);
                  } else {
                    controller.text = controller.text.replaceAll(",", "");
                  }
                }
              }
            }
          },
          child: TextFormField(
            textAlign: alignment,
            enabled: enabled,
            readOnly: readOnly,
            controller: controller,
            cursorColor: colorPrimary,
            textCapitalization: capital,
            focusNode: focusNode,
            textInputAction: textAction,
            keyboardType: inputType,
            // maxLength: maxLength,
            enableInteractiveSelection: readOnly ? false : true,
            obscureText:
                (inputType == TextInputType.visiblePassword || asPassword)
                    ? true
                    : false,
            maxLines: inputType == TextInputType.multiline ? 3 : 1,
            minLines: inputType == TextInputType.multiline ? 3 : 1,
            onFieldSubmitted: (term) {
              if (textAction == TextInputAction.search) {
                wLogs("message");
                onSearch!(term);
              }
              if (textAction == TextInputAction.next) {
                wLogs(unfocus.toString());
                if (!unfocus) {
                  fieldFocusChange(context!, focusNode!, nextFocus!);
                }
              }
            },
            onTap: () {
              if (ontap != null) {
                ontap();
              }
            },
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: colorWhite,
              filled: true,
              hintText: hint!.isNotEmpty
                  ? hint
                  : "Masukkan " + title.replaceAll("*", "").trimLeft(),
              hintStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 13,
              ),
              focusedBorder: inputType == TextInputType.multiline
                  ? BorderStyles.focusBorderMulti
                  : BorderStyles.focusBorder,
              enabledBorder: inputType == TextInputType.multiline
                  ? BorderStyles.focusBorderMulti
                  : BorderStyles.focusBorder,
              border: inputType == TextInputType.multiline
                  ? BorderStyles.textFieldBorderMulti
                  : BorderStyles.textFieldBorder,
              contentPadding: const EdgeInsets.all(12.0),
            ),
            style: TextStyles.txtEdit,
            validator: (value) {
              if (value!.isEmpty) {
                return '$title tidak boleh kosong !';
              }
              return null;
            },
          ),
        ),
      ),
    ],
  );
}

InputDecoration roundDecoration = const InputDecoration(
  focusedBorder: BorderStyles.focusBorder,
  border: BorderStyles.textFieldBorder,
  contentPadding: EdgeInsets.only(left: 14, right: 14),
);

Widget numList(String num, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.only(bottom: 8, right: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorDarkGrey,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            num,
            style: const TextStyle(
              color: colorWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        labelText(desc, styles: const TextStyle(fontSize: 13)),
      ],
    ),
  );
}

Widget labelText(String title, {TextStyle? styles, double bottom = 8}) {
  return Flexible(
    child: Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: bottom),
      child: Text(
        title,
        style: styles ?? const TextStyle(color: colorDark),
      ),
    ),
  );
}

Widget customCheckBox({
  required bool isChecked,
  required Function onChanged,
  required Widget title,
  String direction = "left",
}) {
  if (direction == "left") {
    return Container(
      transform: Matrix4.translationValues(-5, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            alignment: Alignment.topCenter,
            child: Checkbox(
              onChanged: (value) => onChanged(value),
              value: isChecked,
              checkColor: colorWhite,
              fillColor: MaterialStateProperty.all(colorPrimary),
              side: const BorderSide(width: 1, color: colorText),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTapDown: (v) => onChanged(v),
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return Container(
      transform: Matrix4.translationValues(-5, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: GestureDetector(
              onTapDown: (v) => onChanged(v),
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title,
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 25,
            height: 25,
            alignment: Alignment.topCenter,
            child: Checkbox(
              onChanged: (value) => onChanged(value),
              value: isChecked,
              checkColor: colorWhite,
              fillColor: MaterialStateProperty.all(colorPrimary),
              side: const BorderSide(width: 1, color: colorText),
            ),
          ),
        ],
      ),
    );
  }
}

Widget searchField(
    String title, TextEditingController controller, Function(String) onSubmit) {
  return SizedBox(
    height: 40,
    child: TextFormField(
      controller: controller,
      cursorColor: colorPrimary,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onFieldSubmitted: (term) {
        onSubmit(term);
      },
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () => onSubmit(controller.text),
          child: Container(
            decoration: const BoxDecoration(
              color: colorTextLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Icon(
              Icons.search,
              color: colorWhite,
              size: 25,
            ),
          ),
        ),
        hintText: title,
        hintStyle: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
        focusedBorder: BorderStyles.focusBorder,
        border: BorderStyles.textFieldBorder,
        contentPadding: const EdgeInsets.only(left: 14, right: 14),
      ),
      style: TextStyles.txtEdit,
    ),
  );
}

bool _isHidePass = true;
void _togglePassword() {
  // setState(() {
  _isHidePass = !_isHidePass;
  // });
}

Widget passwordTextField(String title, TextEditingController _controller,
    FocusNode _focusNode, FocusNode _nextFocus,
    [BuildContext? context]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 15),
        child: Text(
          title,
          style: const TextStyle(color: colorDark),
        ),
      ),
      TextFormField(
        controller: _controller,
        cursorColor: colorPrimary,
        obscureText: _isHidePass,
        focusNode: _focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (term) {
          fieldFocusChange(context!, _focusNode, _nextFocus);
        },
        decoration: InputDecoration(
          hintText: title,
          suffixIcon: GestureDetector(
            onTap: () {
              _togglePassword();
            },
            child: Icon(
              _isHidePass ? Icons.visibility_off : Icons.visibility,
              color: _isHidePass ? Colors.grey : colorPrimary,
            ),
          ),
          hintStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
          focusedBorder: BorderStyles.focusBorder,
          border: BorderStyles.textFieldBorder,
          contentPadding: const EdgeInsets.all(14),
        ),
        style: TextStyles.txtEdit,
        validator: (value) {
          if (value!.isEmpty) {
            return '$title tidak boleh kosong !';
          }
          return null;
        },
      ),
    ],
  );
}

divider(
    {double bottom = 0, double left = 0, double ptop = 5, double pbottom = 5}) {
  return Container(
    padding: EdgeInsets.only(top: ptop, bottom: pbottom),
    margin: EdgeInsets.only(bottom: bottom, left: left),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: colorTextLight),
      ),
    ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

Widget rdButton({
  required String value,
  required String groupValue,
  required Function onChanged,
  required String text,
}) {
  return GestureDetector(
    onTapDown: (details) => onChanged(details),
    child: Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (v) {
            onChanged(v);
          },
          activeColor: colorPrimary,
        ),
        Text(text),
      ],
    ),
  );
}

Widget labelPrice({
  String? price,
  required double height,
  required double width,
  bool small = false,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      children: <Widget>[
        Positioned(
          top: small ? 70 : 20,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: price == '0' ? colorPurple : colorPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(
                price == '0' ? 'GRATIS' : "Rp. " + (price.toString()),
                style: TextStyle(
                  fontSize: small ? 10 : 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = colorText
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Future showPin({
  required BuildContext context,
  required dynamic nextAction,
  dynamic page = "",
}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (_) {
      return PinKeyBoard(
        nextAction: nextAction,
        page: page,
      );
    },
  );
}

class PinKeyBoard extends StatefulWidget {
  final dynamic nextAction;
  final dynamic page;
  const PinKeyBoard({Key? key, required this.nextAction, this.page})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PinKeyBoardState();
}

class _PinKeyBoardState extends State<PinKeyBoard> {
  TextEditingController p0 = TextEditingController();
  TextEditingController p1 = TextEditingController();
  TextEditingController p2 = TextEditingController();
  TextEditingController p3 = TextEditingController();
  TextEditingController p4 = TextEditingController();
  TextEditingController p5 = TextEditingController();
  TextEditingController p6 = TextEditingController();

  bool isCardSave = false;
  bool isWd = false;
  bool pinCorrect = true;
  int position = 1;
  setValue(String value) async {
    if (position < 7) {
      if (position == 1) {
        p1.text = value;
      } else if (position == 2) {
        p2.text = value;
      } else if (position == 3) {
        p3.text = value;
      } else if (position == 4) {
        p4.text = value;
      } else if (position == 5) {
        p5.text = value;
      } else if (position == 6) {
        p6.text = value;

        String pin = p1.text + p2.text + p3.text + p4.text + p5.text + p6.text;
        var s = await openSession();
        var spin = s.containsKey("my_pin") ? s.get("my_pin") : "123456";
        if (pin == spin) {
          if (widget.nextAction == "cardsave") {
            setState(() {
              isCardSave = true;
            });
          } else if (widget.nextAction == "wd") {
            setState(() {
              isWd = true;
            });
          } else {
            Navigator.pop(context, "success");
            Future.delayed(const Duration(milliseconds: 100)).then((_) {
              if (widget.nextAction == "page") {
                gotoPage(context, widget.page);
              }
            });
          }
          setState(() {
            pinCorrect = true;
          });
        } else {
          setState(() {
            pinCorrect = false;
            // position = 0;
          });
          // p1.clear();
          // p2.clear();
          // p3.clear();
          // p4.clear();
          // p5.clear();
          // p6.clear();
        }
      }
      setState(() {
        position += 1;
      });
    }
  }

  removeValue() {
    if (position > 1) {
      if (position == 7) {
        p6.clear();
      } else if (position == 6) {
        p5.clear();
      } else if (position == 5) {
        p4.clear();
      } else if (position == 4) {
        p3.clear();
      } else if (position == 3) {
        p2.clear();
      } else if (position == 2) {
        p1.clear();
        // showToast("sudah sudah mas", context: context);
      }
      setState(() {
        pinCorrect = true;
        position -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isCardSave
        ? Container(
            height: 300,
            decoration: const BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Stack(
                    children: [
                      const Center(
                          child: Text(
                        "Berhasil",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.pop(context, "success"),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
                divider(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/card-success.png',
                    height: 140,
                  ),
                ),
                const Center(
                  child: Text("Nomor Rekening Berhasil Ditambahkan"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
                  child: buttonSubmit(
                    text: "OK",
                    onPressed: () => Navigator.pop(context, "success"),
                    bradius: 5,
                    bwidth: double.infinity,
                  ),
                ),
              ],
            ),
          )
        : isWd
            ? Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Stack(
                        children: [
                          const Center(
                              child: Text(
                            "Tarik Saldo Berhasil",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => Navigator.pop(context, "success"),
                              child: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    ),
                    divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/wd-success.png',
                        height: 140,
                      ),
                    ),
                    const Center(
                      child: Text("Penarikan Saldo Anda Sedang Kami Proses"),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 40, right: 40),
                      child: buttonSubmit(
                        text: "OK",
                        onPressed: () => Navigator.pop(context, "success"),
                        bradius: 5,
                        bwidth: double.infinity,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Stack(
                        children: [
                          const Center(
                              child: Text(
                            "Masukkan PIN Anda",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    ),
                    divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 20,
                            child: pinTextField(
                              alignment: TextAlign.center,
                              title: "",
                              enable: false,
                              border: true,
                              controller: p1,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: pinTextField(
                              alignment: TextAlign.center,
                              title: "",
                              enable: false,
                              border: true,
                              controller: p2,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: pinTextField(
                              alignment: TextAlign.center,
                              title: "",
                              enable: false,
                              border: true,
                              controller: p3,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: pinTextField(
                              alignment: TextAlign.center,
                              title: "",
                              enable: false,
                              border: true,
                              controller: p4,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: pinTextField(
                              alignment: TextAlign.center,
                              title: "",
                              enable: false,
                              border: true,
                              controller: p5,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: pinTextField(
                              alignment: TextAlign.center,
                              title: "",
                              enable: false,
                              border: true,
                              controller: p6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // if (pinCorrect) const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(4.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!pinCorrect)
                            const Padding(
                              padding: EdgeInsets.only(right: 0),
                              child: Text(
                                "PIN Salah!, ",
                                style: TextStyle(color: colorRed100),
                              ),
                            ),
                          InkWell(
                            onTap: () => Navigator.pop(context, "lupa"),
                            child: const Text(
                              "Lupa PIN?",
                              style: TextStyle(color: colorPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => setValue("1"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Text(
                              "1",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("2"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 40,
                            child: const Text(
                              "2",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("3"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Text(
                              "3",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => setValue("4"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Text(
                              "4",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("5"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 40,
                            child: const Text(
                              "5",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("6"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Text(
                              "6",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => setValue("7"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Text(
                              "7",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("8"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 40,
                            child: const Text(
                              "8",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("9"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Text(
                              "9",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: colorText),
                              right: BorderSide(color: colorText),
                            ),
                          ),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 40,
                          child: const Text(
                            "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setValue("0"),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                                right: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 40,
                            child: const Text(
                              "0",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => removeValue(),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: colorText),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            child: const Icon(
                              Icons.backspace_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
  }
}

class MessageBorder extends ShapeBorder {
  final bool usePadding;

  const MessageBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 30));
    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 6)))
      ..moveTo(rect.bottomCenter.dx + 10, rect.bottomCenter.dy)
      ..relativeLineTo(10, -90)
      ..relativeLineTo(40, 90)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
