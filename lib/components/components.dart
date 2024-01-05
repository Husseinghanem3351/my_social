import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared/styles/icon_broken.dart';

Widget defaultTextBox ({
  bool textVisibility=false,
  TextEditingController? textBoxController,
  InputBorder? border,
  String? labelText,
  String? hintText,
  Widget? prefIcon,
  Widget? sufIcon,
  String? Function(String?)? validate,
  TextInputAction? inputAction,
  TextInputType? inputType,
})=> TextFormField(
  textInputAction: inputAction ,
  keyboardType: inputType,
  obscureText:textVisibility,
  validator:validate,
  controller:textBoxController ,
  decoration: InputDecoration(
    border: border,
    labelText: labelText,
    hintText: hintText,
    prefixIcon: prefIcon,
    suffixIcon: sufIcon,
  ),
);

Widget defaultButton({
  required void Function()? fun,
  required String text,
  double width=double.infinity,
  double height=40,
  Color backGroundColor =Colors.blueGrey,
  Color textColor =Colors.white,
  isUpperCase=false,
  double radius=3,
  required context
})=> Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backGroundColor,
      ),
      child: MaterialButton(
        onPressed: fun,
        child: Text(
          isUpperCase? text.toUpperCase():text,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: textColor,
          ),
        ),),
    );

    void navigateTo({
    required context,
    required Widget screen,}
    ){
      Navigator.push(
      context,MaterialPageRoute(builder: (context) => screen,)
      );
    }

    void pushAndReplacement({required context,
      required Widget screen}){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>screen,),
              (route) => false);
    }

void showToast({
  required String msg,
  Color color = Colors.white,
  Color textColor=Colors.black}) {
   // TextStyle textStyle = TextStyle(fontSize: 30, color: textColor);
  //double textWidth=_textSize(msg, textStyle,MediaQuery.of(context).size.width).width;
  // final SnackBar snackBarConst = SnackBar(
  //   width: textWidth,
  //   behavior: SnackBarBehavior.floating,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //   content: Text(
  //     msg,
  //     textAlign: TextAlign.center,
  //     maxLines: 5,
  //     overflow: TextOverflow.ellipsis,
  //     style: const TextStyle(
  //       fontSize: 15,
  //     ),
  //   ),
  //   duration: const Duration(
  //     seconds: 5,
  //   ),
  //   backgroundColor: color,
  // );
  Fluttertoast.showToast(msg: msg,backgroundColor: color,toastLength: Toast.LENGTH_LONG,textColor: textColor);
}

Size _textSize(String text, TextStyle style,double maxWidth) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  )
    ..layout(minWidth: 70, maxWidth: maxWidth*0.75);
  return textPainter.size;
}

PreferredSizeWidget defaultAppBar({
  List<Widget>? actions,
  String? title,
  required BuildContext context,
  double titleSpacing=0,
})=>AppBar(
  titleSpacing: titleSpacing,
  title: Text(title??''),
  actions: actions,
  leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: const Icon(IconBroken.Arrow___Left_2)),
);
