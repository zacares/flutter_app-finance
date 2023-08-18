// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:app_finance/_classes/controller/focus_controller.dart';
import 'package:app_finance/_configs/theme_helper.dart';
import 'package:app_finance/widgets/_forms/abstract_input.dart';
import 'package:app_finance/widgets/_forms/date_input.dart';
import 'package:app_finance/widgets/_wrappers/row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends AbstractInput {
  final Function setState;
  @override
  // ignore: overridden_fields
  final DateTime value;
  final TextStyle? style;
  final double? width;

  DateTimeInput({
    super.key,
    required this.setState,
    required this.value,
    this.style,
    this.width,
  });

  void onTap(BuildContext context) {
    DatePicker.showTimePicker(context, showTitleActions: true, currentTime: value, onConfirm: (dateTime) {
      setState(dateTime);
      FocusController.onEditingComplete(focusOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    double indent = ThemeHelper.getIndent(2);
    double offset = width ?? ThemeHelper.getWidth(context, 4);
    final locale = Localizations.localeOf(context).toString();
    final DateFormat formatterTime = DateFormat.Hms(locale);
    bool isFocused = FocusController.isFocused(focusOrder, value);

    if (!focus.hasFocus && isFocused) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!focus.hasFocus) {
          onTap(context);
        }
      });
    }

    return RowWidget(
      indent: indent,
      maxWidth: offset,
      chunk: const [0.6, 0.4],
      children: [
        [
          DateInput(
            value: value,
            setState: setState,
            style: style,
          ),
        ],
        [
          Container(
            color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.3),
            child: ListTile(
              focusNode: focus,
              autofocus: isFocused,
              title: Text(
                formatterTime.format(value),
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
              onTap: () => onTap(context),
            ),
          ),
        ],
      ],
    );
  }
}
