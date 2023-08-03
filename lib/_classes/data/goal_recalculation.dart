// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'package:app_finance/_classes/data/abstract_recalculation.dart';
import 'package:app_finance/_classes/data/goal_app_data.dart';

class GoalRecalculation extends AbstractRecalculation {
  GoalAppData change;
  GoalAppData? initial;

  GoalRecalculation({
    required this.change,
    this.initial,
  });

  @override
  double getDelta() {
    if (initial != null && !change.hidden) {
      return getProgress(initial!.details, initial!.progress, change.details - initial!.details);
    } else {
      return 0.0;
    }
  }

  GoalRecalculation updateGoal() {
    change.progress = getDelta();
    return this;
  }
}
