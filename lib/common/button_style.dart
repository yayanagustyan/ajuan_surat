import 'package:flutter/material.dart';

import 'constant.dart';
import 'my_colors.dart';

Widget buttonSubmit({
  required String text,
  required Function onPressed,
  final double bwidth = 100,
  final double bheight = 40,
  Color backgroundColor = colorPrimary,
  Color sideColor = colorPrimary,
  Color textColor = colorWhite,
  double bradius = 10,
  Widget? icon,
  double fontSize = 16,
}) {
  return SizedBox(
    width: bwidth,
    height: bheight,
    child: TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.resolveWith(
          (state) => backgroundColor,
        ),
        overlayColor: MaterialStateColor.resolveWith(
          (states) => backgroundColor == colorWhite ? textColor : colorWhite,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(color: sideColor),
            borderRadius: BorderRadius.circular(bradius),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) icon,
              Text(
                text,
                maxLines: 1,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
    ),
  );
}

// ignore: must_be_immutable
class ButtonSubmit extends StatelessWidget {
  final String txtButton;
  final Color backgroundColor;
  final Color sideColor;
  final GestureTapCallback onPressed;

  const ButtonSubmit({
    Key? key,
    required this.txtButton,
    this.backgroundColor = colorPrimary,
    this.sideColor = colorPrimary,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.0,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (state) => backgroundColor,
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(color: sideColor),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            txtButton.toString(),
            maxLines: 1,
            style: const TextStyle(
              color: colorWhite,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              fontSize: 16,
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}

class ButtonWidth extends StatelessWidget {
  final String? txtButton;
  final double? width;
  final Color? color;
  final GestureTapCallback? onPressed;

  const ButtonWidth({
    Key? key,
    required this.onPressed,
    required this.txtButton,
    required this.width,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (state) => color,
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                txtButton!,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 15),
              ),
            ],
          ),
        ),
        onPressed: () {
          onPressed!();
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonUpload extends StatelessWidget {
  final String? txtButton;
  Color? backgroundColor = colorPrimary;
  Color? sideColor = colorPrimary;
  IconData? icons;
  String? title;
  String? subtitle;
  final GestureTapCallback? onPressed;

  ButtonUpload({
    Key? key,
    required this.onPressed,
    required this.txtButton,
    this.icons,
    this.title,
    this.subtitle,
    this.backgroundColor,
    this.sideColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 30,
        minWidth: deviceWidth(context),
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title!,
                style: TextStyles.txtBody,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (state) => backgroundColor,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: sideColor!),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),

              // color: backgroundColor != null ? backgroundColor : colorPrimary,
              // splashColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      txtButton!,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      icons ?? Icons.cloud_upload,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                onPressed!();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                subtitle!,
                style: TextStyle(color: Colors.grey[400], fontSize: 11.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextButton roundedButton(
    {Color color = colorPrimary,
    required String text,
    required VoidCallback onPressed}) {
  return TextButton(
    onPressed: () {
      onPressed();
    },
    child: Text(
      text,
      style: const TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

TextButton roundedButtonBorder(
    {Color color = colorPurple,
    required String text,
    required VoidCallback onPressed}) {
  return TextButton(
    onPressed: () {
      onPressed();
    },
    child: Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
