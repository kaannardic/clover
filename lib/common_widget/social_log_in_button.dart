import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget butonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
        @required this.butonText,
        this.butonColor: Colors.blue,
        this.textColor: Colors.white,
        this.radius: 16,
        this.yukseklik: 45,
        this.butonIcon,
        this.onPressed})
      : assert(butonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: yukseklik,
        child: CupertinoButton(
          padding: EdgeInsets.all(10),
          onPressed: onPressed,
          //shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              butonIcon != null
                  ? butonIcon
                  : Container(),

              Text(
                butonText,
                style: TextStyle(color: textColor),
              ),
              butonIcon != null
                  ? Opacity(opacity:0, child: butonIcon)
                  : Container(),
            ],
          ),
          color: butonColor,
        ),
      ),
    );
  }
}
