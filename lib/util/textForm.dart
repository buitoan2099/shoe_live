import 'package:flutter/material.dart';

import 'colors.dart';

class TextForm {
  static Widget textSel(String text,{TextStyle? style,}) {
    return SelectableText(
      text,
      cursorColor: Colors.lightBlueAccent,
      showCursor: false,
      toolbarOptions: ToolbarOptions(
        copy: true,
        selectAll: true,
        cut: false,
        paste: true,
      ),
      style: style ??
          TextStyle(
            fontFamily: 'VariableFont_wght',
            fontWeight: FontWeight.w100,
            fontSize: 14,
            color: AppColors.gray,
          ),
    );
  }
}
