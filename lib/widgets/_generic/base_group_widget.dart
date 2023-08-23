// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:app_finance/_classes/herald/app_locale.dart';
import 'package:app_finance/_classes/structure/navigation/app_menu.dart';
import 'package:app_finance/charts/bar_vertical_group.dart';
import 'package:app_finance/charts/bar_vertical_single.dart';
import 'package:app_finance/charts/radial_bar_chart.dart';
import 'package:app_finance/_configs/theme_helper.dart';
import 'package:app_finance/widgets/_wrappers/row_widget.dart';
import 'package:app_finance/widgets/_wrappers/tap_widget.dart';
import 'package:flutter/material.dart';

class BaseGroupWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<dynamic> items;
  final List<double> progress;
  final List<Color> color;
  final double width;
  final double total;
  final String route;

  const BaseGroupWidget({
    super.key,
    required this.items,
    required this.title,
    required this.description,
    required this.color,
    required this.width,
    this.progress = const [],
    this.route = '',
    this.total = 0,
  });

  Widget buildCategory(BuildContext context, int index, bool toSwap) {
    final item = items[index];
    final tooltip = StringBuffer();
    tooltip.writeAll(
        ['${AppLocale.labels.title}: "${item.title}"\n', '${AppLocale.labels.details}: ${item.detailsFormatted}']);
    return TapWidget(
      tooltip: tooltip.toString(),
      route: '$route${item.uuid}',
      child: toSwap
          ? Column(
              children: [
                Icon(item.icon, size: 16.0, color: item.color),
                const SizedBox(height: 6.0),
                BarVerticalSingle(value: item.progress, height: 14.0, color: item.color ?? Colors.transparent),
              ],
            )
          : RadialBarChart(
              color: item.color,
              icon: item.icon,
              progress: progress[index],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double indent = ThemeHelper.getIndent();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final titleText = Text(
      title,
      style: textTheme.bodyMedium,
      overflow: TextOverflow.ellipsis,
    );
    double titleWidth = ThemeHelper.getTextWidth(titleText);
    if (titleWidth > width / 2) {
      titleWidth = width / 2;
    }
    final toSwap = items.length * 36 + items.length * indent * 2 > width - titleWidth - indent * 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TapWidget(
          route: AppMenu.search(route, title),
          tooltip: AppLocale.labels.search(title),
          child: RowWidget(
            indent: indent,
            alignment: MainAxisAlignment.start,
            maxWidth: width,
            chunk: [indent * 1.5, titleWidth, null],
            children: [
              [
                Padding(
                  padding: EdgeInsets.only(left: indent),
                  child: BarVerticalGroup(value: progress, height: 32.0, width: indent / 2, color: color),
                ),
              ],
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText,
                    Text(
                      description,
                      style: textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
              [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    items.length * 2,
                    (index) {
                      if (index % 2 != 0) {
                        return SizedBox(width: toSwap ? indent : indent * 2);
                      } else {
                        return buildCategory(context, index ~/ 2, toSwap);
                      }
                    },
                  ),
                ),
              ]
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
