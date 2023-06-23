// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:app_finance/data.dart';
import 'package:app_finance/helpers/theme_helper.dart';
import 'package:app_finance/routes.dart' as routes;
import 'package:app_finance/routes/abstract_page.dart';
import 'package:app_finance/widgets/home/base_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';

class AccountViewPage extends AbstractPage {
  String uuid;

  AccountViewPage({
    required this.uuid,
    required AppData state,
  }) : super(state: state);

  @override
  AccountViewPageState createState() => AccountViewPageState();
}

class AccountViewPageState extends AbstractPageState<AccountViewPage> {
  @override
  String getTitle(context) {
    final item = widget.state.get('accounts', widget.uuid);
    String? title = item!.title;
    return title ?? '';
  }

  void deactivateAccount(BuildContext context) {
    var data = widget.state.state['accounts'];
    final index = data['list'].indexWhere((item) => item.uuid == widget.uuid);
    if (index != -1) {
      setState(() {
        data['total'] -= data['list'][index].details;
        var curr = data['list'][index];
        data['list'][index] = (
          uuid: curr.uuid,
          title: curr.title,
          description: curr.description,
          details: curr.details,
          progress: curr.progress,
          color: curr.color,
          hidden: true,
        );
        widget.state.set('accounts', data);
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget buildButton(BuildContext context, BoxConstraints constraints) {
    String route =
        routes.accountEditRoute.replaceAll('uuid:', 'uuid:${widget.uuid}');
    double indent =
        ThemeHelper(windowType: getWindowType(context)).getIndent() * 4;
    return Container(
      margin: EdgeInsets.only(left: indent),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        FloatingActionButton(
          onPressed: () => deactivateAccount(context),
          tooltip: AppLocalizations.of(context)!.deleteAccountTooltip,
          child: const Icon(Icons.delete),
        ),
        FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, route),
          tooltip: AppLocalizations.of(context)!.editAccountTooltip,
          child: const Icon(Icons.edit),
        ),
      ]),
    );
  }

  @override
  Widget buildContent(
      BuildContext context, BoxConstraints constraints, AppData state) {
    final item = widget.state.get('accounts', widget.uuid);
    var theme = ThemeHelper(windowType: getWindowType(context));
    double indent =
        ThemeHelper(windowType: getWindowType(context)).getIndent() * 2;
    double offset = MediaQuery.of(context).size.width - indent * 3;
    final locale = Localizations.localeOf(context).toString();
    final NumberFormat formatter = NumberFormat.currency(
      locale: locale,
      symbol: '\$',
      decimalDigits: 2,
    );
    return Column(
      children: [
        BaseLineWidget(
          uuid: item.uuid,
          title: item.title,
          description: item.description,
          details: formatter.format(item.details),
          progress: item.progress,
          color: item.color,
          offset: offset,
          route: routes.accountViewRoute,
        )
      ],
    );
  }
}
