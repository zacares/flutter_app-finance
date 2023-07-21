// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:app_finance/data.dart';
import 'package:app_finance/helpers/theme_helper.dart';
import 'package:app_finance/routes/account_add_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountTab extends AccountAddPage {
  final Function() setState;

  AccountTab({
    required this.setState,
  }) : super();

  @override
  AccountTabState createState() => AccountTabState();
}

class AccountTabState extends AccountAddPageState<AccountTab> {
  @override
  void triggerActionButton(BuildContext context) {
    setState(() {
      if (hasFormErrors()) {
        return;
      }
      updateStorage();
      (widget as AccountTab).setState();
    });
  }

  @override
  Widget build(BuildContext context) {
    double indent =
        ThemeHelper(windowType: getWindowType(context)).getIndent() * 2;
    return Consumer<AppData>(builder: (context, appState, _) {
      state = appState;
      return Padding(
        padding: EdgeInsets.only(top: indent),
        child: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            floatingActionButton: buildButton(context, constraints),
            body: buildContent(context, constraints),
          );
        }),
      );
    });
  }
}
