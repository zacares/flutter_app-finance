// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:app_finance/_classes/controller/exchange_controller.dart';
import 'package:app_finance/_classes/herald/app_locale.dart';
import 'package:app_finance/_classes/structure/currency/exchange.dart';
import 'package:app_finance/_classes/structure/invoice_app_data.dart';
import 'package:app_finance/_classes/structure/navigation/app_route.dart';
import 'package:app_finance/_classes/controller/focus_controller.dart';
import 'package:app_finance/_classes/storage/app_preferences.dart';
import 'package:app_finance/_classes/storage/app_data.dart';
import 'package:app_finance/_configs/display_helper.dart';
import 'package:app_finance/_configs/theme_helper.dart';
import 'package:app_finance/_ext/build_context_ext.dart';
import 'package:app_finance/pages/_interfaces/abstract_page_state.dart';
import 'package:app_finance/pages/bill/widgets/interface_bill_page_inject.dart';
import 'package:app_finance/design/form/currency_exchange_input.dart';
import 'package:app_finance/design/form/currency_selector.dart';
import 'package:app_finance/design/form/date_time_input.dart';
import 'package:app_finance/design/button/full_sized_button_widget.dart';
import 'package:app_finance/design/form/list_account_selector.dart';
import 'package:app_finance/design/form/simple_input.dart';
import 'package:app_finance/design/wrapper/required_widget.dart';
import 'package:app_finance/design/wrapper/row_widget.dart';
import 'package:app_finance/design/wrapper/single_scroll_wrapper.dart';
import 'package:app_finance/design/wrapper/text_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency_picker/flutter_currency_picker.dart';

class IncomeTab<T> extends StatefulWidget {
  final String? account;
  final String? description;
  final Currency? currency;
  final double? amount;
  final DateTime? createdAt;
  final AppData state;
  final bool isLeft;
  final FnBillPageCallback callback;

  const IncomeTab({
    super.key,
    required this.state,
    required this.callback,
    this.account,
    this.description,
    this.currency,
    this.amount,
    this.createdAt,
    this.isLeft = false,
  });

  @override
  IncomeTabState createState() => IncomeTabState();
}

class IncomeTabState<T extends IncomeTab> extends State<IncomeTab> {
  final focus = FocusController();
  String? account;
  Currency? accountCurrency;
  Currency? currency;
  late TextEditingController amount;
  late TextEditingController description;
  late ExchangeController exchange;
  late DateTime createdAt;
  bool hasErrors = false;

  @override
  void initState() {
    final value = AppPreferences.get(AppPreferences.prefAccount);
    final obj = widget.state.getByUuid(value ?? '');
    account = widget.account ?? obj?.uuid;
    currency = widget.currency ?? obj?.currency ?? Exchange.defaultCurrency;
    createdAt = widget.createdAt ?? DateTime.now();
    amount = TextEditingController(text: widget.amount != null ? widget.amount.toString() : '');
    description = TextEditingController(text: widget.description);
    accountCurrency = widget.state.getByUuid(account ?? '')?.currency;
    exchange = ExchangeController({},
        store: widget.state, targetController: amount, target: currency, source: [accountCurrency]);

    widget.callback((
      buildButton: buildButton,
      buttonName: getButtonName(),
      title: getTitle(),
    ));
    super.initState();
  }

  @override
  dispose() {
    description.dispose();
    exchange.dispose();
    amount.dispose();
    focus.dispose();
    super.dispose();
  }

  String getTitle() => AppLocale.labels.createBillHeader;

  bool hasFormErrors() {
    setState(() => hasErrors = account == null);
    return hasErrors;
  }

  void updateStorage() {
    String uuid = account ?? '';
    AppPreferences.set(AppPreferences.prefAccount, uuid);
    exchange.save();
    widget.state.add(InvoiceAppData(
      title: description.text,
      color: widget.state.getByUuid(uuid)?.color,
      account: uuid,
      details: double.tryParse(amount.text),
      currency: currency,
      createdAt: createdAt,
    ));
  }

  String getButtonName() => AppLocale.labels.createIncomeTooltip;

  Widget buildButton(BuildContext context, BoxConstraints constraints) {
    NavigatorState nav = Navigator.of(context);
    return FullSizedButtonWidget(
      constraints: constraints,
      controller: focus,
      setState: () => {
        setState(() {
          if (hasFormErrors()) {
            return;
          }
          updateStorage();
          nav.popAndPushNamed(AppRoute.homeRoute);
        })
      },
      title: getButtonName(),
      icon: Icons.save,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final indent = ThemeHelper.getIndent(2);
    double width = DisplayHelper.state().width - indent * 3;
    if (widget.isLeft) {
      width -= AbstractPageState.barHeight;
    }

    return SingleScrollWrapper(
      controller: focus,
      child: Container(
        margin: EdgeInsets.fromLTRB(indent, indent, indent, 240),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequiredWidget(
              title: AppLocale.labels.account,
              showError: hasErrors && account == null,
            ),
            ListAccountSelector(
              value: account,
              hintText: AppLocale.labels.titleAccountTooltip,
              state: widget.state,
              setState: (value) => setState(() {
                account = value;
                currency = widget.state.getByUuid(value).currency;
                accountCurrency = currency;
              }),
              width: width,
            ),
            ThemeHelper.hIndent2x,
            RowWidget(
              indent: indent,
              maxWidth: width + indent,
              chunk: const [125, null],
              children: [
                [
                  Text(
                    AppLocale.labels.currency,
                    style: textTheme.bodyLarge,
                  ),
                  CodeCurrencySelector(
                    value: currency?.code,
                    textTheme: textTheme,
                    colorScheme: context.colorScheme,
                    update: (value) => setState(() => currency = value),
                  ),
                ],
                [
                  TextWrapper(
                    AppLocale.labels.income,
                    style: textTheme.bodyLarge,
                  ),
                  SimpleInput(
                    controller: amount,
                    type: const TextInputType.numberWithOptions(decimal: true),
                    tooltip: AppLocale.labels.billSetTooltip,
                    formatter: [
                      SimpleInputFormatter.filterDouble,
                    ],
                  ),
                ],
              ],
            ),
            ThemeHelper.hIndent2x,
            CurrencyExchangeInput(
              width: width + indent,
              indent: indent,
              target: currency,
              controller: exchange,
              source: [accountCurrency],
            ),
            Text(
              AppLocale.labels.description,
              style: textTheme.bodyLarge,
            ),
            SimpleInput(
              controller: description,
              tooltip: AppLocale.labels.incomeTooltip,
            ),
            ThemeHelper.hIndent2x,
            Text(
              AppLocale.labels.balanceDate,
              style: textTheme.bodyLarge,
            ),
            DateTimeInput(
              width: width,
              value: createdAt,
              setState: (value) => setState(() => createdAt = value),
            ),
            ThemeHelper.formEndBox,
          ],
        ),
      ),
    );
  }
}
