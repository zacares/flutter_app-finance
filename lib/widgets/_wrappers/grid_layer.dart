// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:app_finance/_configs/theme_helper.dart';
import 'package:app_finance/widgets/_wrappers/row_widget.dart';
import 'package:flutter/material.dart';

class GridLayer extends StatelessWidget {
  final double padding;
  final int crossAxisCount;
  final List<dynamic> children;
  final List<dynamic> rules;

  const GridLayer({
    super.key,
    required this.padding,
    required this.crossAxisCount,
    required this.children,
    required this.rules,
  });

  @override
  Widget build(BuildContext context) {
    fnItem(int index) => children[index] is Function ? children[index]() : children[index];
    fnList(List<dynamic> scope) => scope.map((e) => e is List ? fnList(e).cast<Widget>().toList() : fnItem(e));
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: rules.length > 1
          ? RowWidget(
              indent: padding,
              maxWidth: ThemeHelper.getWidth(context, 2),
              chunk: List.filled(crossAxisCount, null),
              children: fnList(rules).cast<List<Widget>>().toList(),
            )
          : Column(
              children: fnList(rules.first).cast<Widget>().toList(),
            ),
    );
  }
}
