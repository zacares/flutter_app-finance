// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:app_finance/_classes/controller/exchange_controller.dart';
import 'package:app_finance/_classes/herald/app_locale.dart';
import 'package:app_finance/_classes/structure/currency/exchange.dart';
import 'package:app_finance/_classes/structure/invoice_app_data.dart';
import 'package:app_finance/_classes/structure/navigation/app_route.dart';
import 'package:app_finance/_classes/controller/focus_controller.dart';
import 'package:app_finance/_classes/storage/app_data.dart';
import 'package:app_finance/_configs/screen_helper.dart';
import 'package:app_finance/_configs/theme_helper.dart';
import 'package:app_finance/_ext/build_context_ext.dart';
import 'package:app_finance/pages/bill/widgets/interface_bill_page_inject.dart';
import 'package:app_finance/design/form/currency_exchange_input.dart';
import 'package:app_finance/design/form/date_time_input.dart';
import 'package:app_finance/design/button/full_sized_button_widget.dart';
import 'package:app_finance/design/wrapper/required_widget.dart';
import 'package:app_finance/design/wrapper/row_widget.dart';
import 'package:app_finance/design/form/currency_selector.dart';
import 'package:app_finance/design/form/list_account_selector.dart';
import 'package:app_finance/design/form/simple_input.dart';
import 'package:app_finance/design/wrapper/single_scroll_wrapper.dart';
import 'package:app_finance/design/wrapper/text_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency_picker/flutter_currency_picker.dart';

class TransferTab<T> extends StatefulWidget {
  final String? accountFrom;
  final String? accountTo;
  final double? amount;
  final String? description;
  final Currency? currency;
  final DateTime? createdAt;
  final AppData state;
  final bool isLeft;
  final FnBillPageCallback callback;

  const TransferTab({
    super.key,
    required this.state,
    required this.callback,
    this.accountFrom,
    this.accountTo,
    this.amount,
    this.description,
    this.currency,
    this.createdAt,
    this.isLeft = false,
  });

  @override
  TransferTabState createState() => TransferTabState();
}

class TransferTabState<T extends TransferTab> extends State<T> {
  final focus = FocusController();
  String? accountFrom;
  String? accountTo;
  Currency? accountFromCurrency;
  Currency? accountToCurrency;
  late TextEditingController amount;
  late TextEditingController description;
  late ExchangeController exchange;
  late DateTime createdAt;
  Currency? currency;
  bool hasErrors = false;
  bool isPushed = false;

  @override
  void initState() {
    accountFrom = widget.accountFrom;
    accountTo = widget.accountTo;
    createdAt = widget.createdAt ?? DateTime.now();
    amount = TextEditingController(text: widget.amount != null ? widget.amount.toString() : '');
    description = TextEditingController(text: widget.description);
    currency = widget.currency ?? Exchange.defaultCurrency;
    exchange = ExchangeController({}, store: widget.state, targetController: amount, target: currency, source: []);

    widget.callback((
      buildButton: buildButton,
      buttonName: getButtonName(),
      title: getTitle(),
    ));
    super.initState();
  }

  @override
  dispose() {
    isPushed = false;
    amount.dispose();
    description.dispose();
    focus.dispose();
    super.dispose();
  }

  bool hasFormErrors() {
    setState(() => hasErrors = accountFrom == null || accountTo == null);
    return hasErrors;
  }

  String getTitle() => AppLocale.labels.createBillHeader;

  void updateStorage() {
    final uuid = accountFrom ?? '';
    widget.state.add(InvoiceAppData(
      title: description.text,
      color: widget.state.getByUuid(uuid)?.color,
      account: accountTo ?? '',
      accountFrom: uuid,
      details: double.tryParse(amount.text),
      currency: currency,
      createdAt: createdAt,
    ));
  }

  String getButtonName() => AppLocale.labels.createTransferTooltip;

  Widget buildButton(BuildContext context, BoxConstraints constraints) {
    final nav = Navigator.of(context);
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
    double width = ScreenHelper.state().width - indent * 3;
    if (widget.isLeft) {
      width -= ThemeHelper.barHeight;
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
              title: AppLocale.labels.accountFrom,
              showError: hasErrors && accountFrom == null,
            ),
            ListAccountSelector(
              value: accountFrom,
              hintText: AppLocale.labels.accountFrom,
              state: widget.state,
              setState: (value) => setState(() {
                accountFrom = value;
                accountFromCurrency = widget.state.getByUuid(accountFrom!)?.currency;
                currency ??= accountFromCurrency;
              }),
              width: width,
            ),
            ThemeHelper.hIndent2x,
            RequiredWidget(
              title: AppLocale.labels.accountTo,
              showError: hasErrors && accountTo == null,
            ),
            ListAccountSelector(
              value: accountTo,
              hintText: AppLocale.labels.accountTo,
              state: widget.state,
              setState: (value) => setState(() {
                accountTo = value;
                accountToCurrency = widget.state.getByUuid(value)?.currency;
                currency = accountToCurrency;
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
                    AppLocale.labels.expenseTransfer,
                    style: textTheme.bodyLarge,
                  ),
                  SimpleInput(
                    controller: amount,
                    type: const TextInputType.numberWithOptions(decimal: true),
                    tooltip: AppLocale.labels.billSetTooltip,
                    formatter: [SimpleInputFormatter.filterDouble],
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
              source: [accountFromCurrency, accountToCurrency],
            ),
            Text(
              AppLocale.labels.description,
              style: textTheme.bodyLarge,
            ),
            SimpleInput(
              controller: description,
              tooltip: AppLocale.labels.transferTooltip,
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
