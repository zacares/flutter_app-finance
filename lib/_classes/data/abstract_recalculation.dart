// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'dart:collection';
import 'package:app_finance/_classes/data/exchange.dart';
import 'package:app_finance/_classes/data/summary_app_data.dart';
import 'package:currency_picker/currency_picker.dart';

abstract class AbstractRecalculation {
  late Exchange exchange;
  late Currency? exchangeTo;

  double getDelta();

  double updateTotalMap(String uuid, HashMap<String, dynamic> hashTable) {
    final item = hashTable[uuid];
    return exchange.reform(item.details, item.currency, exchangeTo);
  }

  List<String>? getSummaryList(SummaryAppData? summary) {
    return summary?.list;
  }

  Future<void> updateTotal(
      SummaryAppData? summary, HashMap<String, dynamic> hashTable) async {
    var list = getSummaryList(summary);
    exchangeTo = await exchange.getDefaultCurrency();
    summary?.total = (list == null || list.isEmpty
        ? 0.0
        : list
            .map<double>((String uuid) => updateTotalMap(uuid, hashTable))
            .reduce((value, details) => value + details));
  }

  double getProgress(double amount, double progress, double delta) {
    if (amount > 0) {
      progress = (amount * progress + delta) / amount;
    } else {
      progress = 0.0;
    }
    return progress;
  }
}
