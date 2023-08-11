// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:app_finance/_classes/app_data.dart';
import 'package:app_finance/_classes/currency/exchange.dart';
import 'package:app_finance/helpers/theme_helper.dart';
import 'package:app_finance/_classes/app_route.dart';
import 'package:app_finance/routes/abstract_page.dart';
import 'package:app_finance/widgets/home/account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AccountPage extends AbstractPage {
  final String? search;

  AccountPage({
    this.search,
  }) : super();

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends AbstractPageState<AccountPage> {
  @override
  String getTitle(context) {
    if (widget.search != null) {
      return AppLocalizations.of(context)!.search(widget.search!);
    }
    return AppLocalizations.of(context)!.accountHeadline;
  }

  @override
  Widget buildButton(BuildContext context, BoxConstraints constraints) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, AppRoute.accountAddRoute),
      tooltip: AppLocalizations.of(context)!.addAccountTooltip,
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget buildContent(BuildContext context, BoxConstraints constraints) {
    final helper = ThemeHelper(windowType: getWindowType(context));
    dynamic items;
    if (widget.search != null) {
      final scope = super
          .state
          .getList(AppDataType.accounts)
          .where((e) => e.title.toString().startsWith(widget.search!))
          .toList();
      final ex = Exchange(store: super.state);
      items = (
        total: scope.fold(0.0, (v, e) => v + ex.reform(e.details, e.currency, ex.getDefaultCurrency())),
        list: scope
      );
    } else {
      items = super.state.get(AppDataType.accounts);
    }
    return Column(
      children: [
        AccountWidget(
          margin: EdgeInsets.all(helper.getIndent()),
          title: AppLocalizations.of(context)!.accountHeadline,
          state: items,
          offset: MediaQuery.of(context).size.width - helper.getIndent() * 2,
        )
      ],
    );
  }
}
