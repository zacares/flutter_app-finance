// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'dart:collection';
import 'package:app_finance/_classes/data/account_app_data.dart';
import 'package:app_finance/_classes/data/account_recalculation.dart';
import 'package:app_finance/_classes/data/bill_app_data.dart';
import 'package:app_finance/_classes/data/bill_recalculation.dart';
import 'package:app_finance/_classes/data/budget_app_data.dart';
import 'package:app_finance/_classes/data/budget_recalculation.dart';
import 'package:app_finance/_classes/data/currency_app_data.dart';
import 'package:app_finance/_classes/data/goal_app_data.dart';
import 'package:app_finance/_classes/data/goal_recalculation.dart';
import 'package:app_finance/_classes/data/summary_app_data.dart';
import 'package:app_finance/_classes/data/transaction_log.dart';
import 'package:app_finance/_classes/data/transaction_log_data.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum AppDataType {
  goals,
  bills,
  accounts,
  budgets,
  currencies,
}

enum AppAccountType {
  account,
  cash,
  debitCard,
  creditCard,
  deposit,
  credit,
}

class AppData extends ChangeNotifier {
  bool isLoading = false;

  final _account = {
    AppAccountType.account: (),
    AppAccountType.cash: (),
    AppAccountType.debitCard: (),
    AppAccountType.creditCard: (),
    AppAccountType.deposit: (),
    AppAccountType.credit: (),
  };

  final _hashTable = HashMap<String, dynamic>();

  final _history = HashMap<String, List<TransactionLogData>>();

  final _data = {
    AppDataType.goals: SummaryAppData(total: 0, list: []),
    AppDataType.bills: SummaryAppData(total: 0, list: []),
    AppDataType.accounts: SummaryAppData(total: 0, list: []),
    AppDataType.budgets: SummaryAppData(total: 0, list: []),
    AppDataType.currencies: SummaryAppData(total: 0, list: [])
  };

  AppData() : super() {
    isLoading = true;
    TransactionLog.load(this)
        .then((success) => notifyListeners())
        .then((success) => isLoading = false);
  }

  void _set(AppDataType property, dynamic value) {
    _hashTable[value.uuid] = value;
    _data[property]?.add(value.uuid);
    if (!isLoading) {
      TransactionLog.save(value);
      notifyListeners();
    }
  }

  dynamic add(AppDataType property, dynamic value) {
    value.uuid = const Uuid().v4();
    _update(property, null, value);
    return getByUuid(value.uuid);
  }

  void addLog(uuid, dynamic initial, dynamic value,
      [String? ref, DateTime? updatedAt]) {
    if (_history[uuid] == null) {
      _history[uuid] = [];
    }
    if (initial != value) {
      _history[uuid]!.add(TransactionLogData(
        timestamp: updatedAt,
        ref: ref,
        name: 'details',
        changedFrom: initial,
        changedTo: value,
      ));
    }
  }

  void update(AppDataType property, String uuid, dynamic value,
      [bool createIfMissing = false]) {
    var initial = getByUuid(uuid, false);
    if (initial != null) {
      addLog(uuid, initial.details, value.details, null, value.updatedAt);
    }
    if (initial != null || createIfMissing) {
      _update(property, initial, value);
    }
  }

  double reform(double? amount, Currency? origin, Currency? target) {
    amount ??= 0.0;
    if (origin?.code != target?.code) {
      CurrencyAppData? ex = getByUuid('${origin?.code}-${target?.code}');
      if (ex == null) {
        ex = CurrencyAppData(
          currency: target,
          currencyFrom: origin,
        );
        add(AppDataType.currencies, ex);
      }
      amount *= ex.details;
    }
    return amount;
  }

  void _update(AppDataType property, dynamic initial, dynamic change) {
    switch (property) {
      case AppDataType.accounts:
        return _updateAccount(initial, change);
      case AppDataType.bills:
        return _updateBill(initial, change);
      case AppDataType.budgets:
        return _updateBudget(initial, change);
      case AppDataType.goals:
        return _updateGoal(initial, change);
      case AppDataType.currencies:
        return _updateCurrency(initial, change);
    }
  }

  void _updateAccount(AccountAppData? initial, AccountAppData change) {
    var calc = AccountRecalculation(change: change, initial: initial)
        .updateTotal(_data[AppDataType.accounts], _hashTable);
    if (initial != null) {
      var goalList = getList(AppDataType.goals, false)
          .where((dynamic goal) => goal.progress < 1.0);
      calc.updateGoals(goalList);
    }
    _set(AppDataType.accounts, change);
  }

  void _updateBill(BillAppData? initial, BillAppData change) {
    AccountAppData? currAccount = getByUuid(change.account, false);
    AccountAppData? prevAccount;
    BudgetAppData? currBudget = getByUuid(change.category, false);
    BudgetAppData? prevBudget;
    if (initial != null) {
      prevAccount = getByUuid(initial.account, false);
      if (prevAccount != null) {
        _data[AppDataType.accounts]?.add(initial.account);
      }
      prevBudget = getByUuid(initial.category, false);
      if (prevBudget != null) {
        _data[AppDataType.budgets]?.add(initial.category);
      }
    }
    final rec =
        BillRecalculation(change: change, initial: initial, reform: reform)
            .updateTotal(_data[AppDataType.bills], _hashTable);
    if (currAccount != null) {
      rec.updateAccounts(currAccount, prevAccount);
      _data[AppDataType.accounts]?.add(change.account);
    }
    if (currBudget != null) {
      rec.updateBudget(currBudget, prevBudget);
      _data[AppDataType.budgets]?.add(change.category);
    }
    _set(AppDataType.bills, change);
  }

  void _updateBudget(BudgetAppData? initial, BudgetAppData change) {
    BudgetRecalculation(change: change, initial: initial)
        .updateBudget()
        .updateTotal(_data[AppDataType.budgets], _hashTable);
    _set(AppDataType.budgets, change);
  }

  void _updateGoal(GoalAppData? initial, GoalAppData change) {
    GoalRecalculation(change: change, initial: initial)
        .updateGoal()
        .updateTotal(_data[AppDataType.goals], _hashTable);
    _set(AppDataType.goals, change);
  }

  void _updateCurrency(CurrencyAppData? initial, CurrencyAppData change) {
    _set(AppDataType.currencies, change);
    // TBD: Update totals for Budget and Account
  }

  dynamic get(AppDataType property) {
    return (
      list: getList(property),
      total: getTotal(property),
    );
  }

  List<dynamic> getList(AppDataType property, [bool isClone = true]) {
    SummaryAppData(total: 1, list: ['test']);
    return (_data[property]?.list ?? [])
        .map((uuid) => getByUuid(uuid, isClone))
        .where((element) => !element.hidden)
        .toList();
  }

  double getTotal(AppDataType property) {
    return _data[property]?.total ?? 0.0;
  }

  dynamic getByUuid(String uuid, [bool isClone = true]) {
    var obj = isClone ? _hashTable[uuid]?.clone() : _hashTable[uuid];
    obj?.setState(this);
    return obj;
  }

  dynamic getType(AppAccountType property) {
    return _account[property];
  }

  List<TransactionLogData>? getLog(String uuid) {
    return _history[uuid]?.reversed.toList();
  }
}
