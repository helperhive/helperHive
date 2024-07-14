import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

toastMessage({
  required BuildContext context,
  required String message,
  DelightSnackbarPosition? position,
  Icon? leadingIcon,
  Color? messageColor,
  Color? toastColor,
}) {
  // final double width = MediaQuery.of(context).size.width;
  late DelightToastBar? toastBar;
  toastBar = DelightToastBar(
    position: position ?? DelightSnackbarPosition.bottom,
    autoDismiss: true,
    builder: (context) => SizedBox(
      // color: toastColor ?? Colors.white,
      // margin:
      //     EdgeInsets.symmetric(horizontal: width > webscreensize ? 200 : width),
      width: 450,
      child: ToastCard(
        trailing: IconButton(
            onPressed: () => toastBar?.remove(),
            icon: const Icon(Icons.cancel_outlined)),
        leading: leadingIcon ??
            const Icon(
              Icons.flutter_dash,
              size: 28,
            ),
        title: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: messageColor ?? Colors.black),
        ),
      ),
    ),
  );
  toastBar.show(context);
}
