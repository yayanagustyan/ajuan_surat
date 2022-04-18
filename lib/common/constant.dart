import 'package:flutter/material.dart';

import 'my_colors.dart';

abstract class InputType {
  static const text = TextInputType.text;
  static const nums = TextInputType.number;
  static const multiline = TextInputType.multiline;
  static const password = TextInputType.visiblePassword;
}

abstract class InputCaps {
  static const words = TextCapitalization.words;
  static const sentences = TextCapitalization.sentences;
  static const char = TextCapitalization.characters;
}

abstract class InputAction {
  static const next = TextInputAction.next;
  static const done = TextInputAction.done;
  static const search = TextInputAction.search;
}

//* Device size
double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Text Style
class TextStyles {
  static const TextStyle txtTitle = TextStyle(
    color: colorText,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    fontSize: 18,
  );
  static const TextStyle txtBody = TextStyle(
    color: colorText,
    fontFamily: 'Roboto',
    fontSize: 12,
  );

  static const TextStyle txtEdit = TextStyle(
    color: colorText,
    fontFamily: 'Roboto',
    fontSize: 16,
  );

  Text txtBodySM(String text, double size) {
    return Text(
      text.toUpperCase(),
      style:
          TextStyle(color: Colors.grey, fontFamily: 'Roboto', fontSize: size),
    );
  }

  Text txtBodyMD(String text, double size) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Roboto',
          fontSize: size,
          fontWeight: FontWeight.w500),
    );
  }
}

// Textfield Style
class BorderStyles {
  static const OutlineInputBorder ddfocusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    borderSide: BorderSide(color: colorWhite, width: 1.0),
  );

  static const OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: colorTextLight, width: 1.0),
  );

  static const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: colorTextLight, width: 1.0),
  );

  static const OutlineInputBorder focusBorderMulti = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: colorTextLight, width: 1.0),
  );

  static const OutlineInputBorder textFieldBorderMulti = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: colorTextLight, width: 1.0),
  );

  static const UnderlineInputBorder textBottomBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    borderSide: BorderSide(color: colorTextLight, width: 1.0),
  );

  static const UnderlineInputBorder textBottomBorderGreen =
      UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    borderSide: BorderSide(color: colorPrimary, width: 1.0),
  );

  static const UnderlineInputBorder noBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  );
}

const adjustData = [
  {"type": "Cash", "index": "Sep'21", "value": 120},
  {"type": "Cash", "index": "Okt'21", "value": 132},
  {"type": "Cash", "index": "Nov'21", "value": 101},
  {"type": "Cash", "index": "Des'21", "value": 134},
  {"type": "Cash", "index": "Jan'22", "value": 90},
  {"type": "Cash", "index": "Feb'22", "value": 230},
  {"type": "AR", "index": "Sep'21", "value": 220},
  {"type": "AR", "index": "Okt'21", "value": 182},
  {"type": "AR", "index": "Nov'21", "value": 191},
  {"type": "AR", "index": "Des'21", "value": 234},
  {"type": "AR", "index": "Jan'22", "value": 290},
  {"type": "AR", "index": "Feb'22", "value": 330},
  {"type": "AR", "index": "Mar'22", "value": 310},
  {"type": "AP", "index": "Sep'21", "value": 150},
  {"type": "AP", "index": "Okt'21", "value": 232},
  {"type": "AP", "index": "Nov'21", "value": 201},
  {"type": "AP", "index": "Des'21", "value": 154},
  {"type": "AP", "index": "Jan'22", "value": 190},
  {"type": "AP", "index": "Feb'22", "value": 330},
  {"type": "AP", "index": "Mar'22", "value": 410},
  {"type": "Cash", "index": "Mar'22", "value": 110},
];

List<String> alpha = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
];
