# ![Fingrom Logo](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/logo/main.svg) Financial Accounting Application
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/) 
[![Check Status](https://github.com/lyskouski/app-finance/actions/workflows/push_to_main.yml/badge.svg?branch=main)](https://github.com/lyskouski/app-finance/actions/workflows/push_to_main.yml)
[![Build Status](https://github.com/lyskouski/app-finance/actions/workflows/build.yml/badge.svg)](https://github.com/lyskouski/app-finance/actions/workflows/build.yml)

[![Unit Tests Coverage](https://lyskouski.github.io/app-finance/coverage/unit_coverage_badge.svg)](https://github.com/lyskouski/app-finance/tree/main/test/unit/)
[![Widget Tests Coverage](https://lyskouski.github.io/app-finance/coverage/widget_coverage_badge.svg)](https://github.com/lyskouski/app-finance/tree/main/test/widget)
[![End-To-End Coverage](https://lyskouski.github.io/app-finance/coverage/e2e_coverage_badge.svg)](https://github.com/lyskouski/app-finance/tree/main/test/e2e)

**Fingrom** -- Open-source cross-platform financial accounting application. Use for free without Ads and limitations.

[!] **Release to Marketplaces is scheduled for November 1st** __(but may be slightly changed since a longer review process for Windows)__

| Type                     | Alpha Version         | Pre-Release                   | Release                       |
| ------------------------ | ----------------------| ----------------------------- | ----------------------------- |
| ![Apple](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/apple.png) iOS (Apple Store)        | [fingrom_iOS.ipa](https://github.com/lyskouski/app-finance/releases/latest) | [TestFlight: Fingrom](https://testflight.apple.com/join/93ECy9ZB) | _(postponed availability)_ |
| ![Apple](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/apple.png) macOS (Apple Store)      | [fingrom_macOS.zip](https://github.com/lyskouski/app-finance/releases/latest) | Not available for testing | _(postponed availability)_ |
| ![Android](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/android.png) Android (Google Play)    | [fingrom_Android.aab](https://github.com/lyskouski/app-finance/releases/latest) | [[on hold]](https://github.com/lyskouski/app-finance/issues/129) | [[on hold]](https://github.com/lyskouski/app-finance/issues/129) |
| ![Android](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/android.png) Android (Galaxy Store)   | [fingrom_Android.aab](https://github.com/lyskouski/app-finance/releases/latest) | [[in review]](https://github.com/lyskouski/app-finance/issues/284) | [[in review]](https://github.com/lyskouski/app-finance/issues/284) |
| ![Android](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/android.png) Android (Huawei Gallery) | [fingrom_Android.aab](https://github.com/lyskouski/app-finance/releases/latest) | ? | _(postponed availability)_ |
| ![Linux](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/linux.png) Linux (Snap Store)       | [fingrom_LinuxSnap.snap](https://github.com/lyskouski/app-finance/releases/latest) | [![Fingrom](https://snapcraft.io/fingrom/badge.svg)](https://snapcraft.io/fingrom) | [![Fingrom](https://snapcraft.io/fingrom/badge.svg)](https://snapcraft.io/fingrom) |
| ![Linux](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/linux.png) Linux (Flathub)          | [[pending]](https://github.com/lyskouski/app-finance/issues/350) | [[pending]](https://github.com/lyskouski/app-finance/issues/350) | [[pending]](https://github.com/lyskouski/app-finance/issues/350) |
| ![Windows](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/windows.png) Windows (Partner Center) | [fingrom_Windows.zip](https://github.com/lyskouski/app-finance/releases/latest) | [App Center: Fingrom](https://appcenter.ms/orgs/terCAD/apps/Fingrom) | [[in review]](https://github.com/lyskouski/app-finance/issues/209) |
| ![Web Browsers](https://github.com/lyskouski/app-finance/blob/main/docs/mockups/icons/web.png) Web                      | [Fingrom](https://lyskouski.github.io/app-finance/) | [pending] | _(postponed availability)_ |


## Functionality
- Accounting (Account Type, Currency/Cryptocurrency)
  - Simple grouping via `/` (in name) for the main page
  - Transactions log
  - Freeze amount by Update date (to import previous history)
- Budget Categories
  - Simple grouping via `/` (in name) for the main page
  - With limits restate:
    - Renewed at the beginning of each month
    - Configurable limits per month
    - Relatives (0.0 ... 1.0) to Income
  - Or, without limitations by showing a spent amount
- Bills, Transfers, Incomes (Invoices)
- Goals Definition
- Exchange rates, Default Currency for Summary
- Metrics: 
  - Budget:
    - Forecast (with Monte Carlo simulation)
  - Account:
    - Candlestick (OHLC) Chart
    - Income Health Radar
    - Currency Distribution
  - Bills:
    - YTD Expenses
    - Bar Race for Categories
  - Goals Gauge Chart
  - Currency Historical Chart
- Synchronization between devices (P2P) 
- Recovery via WebDav or a direct File
- Import from `CSV`, `QIF`, `OFX` files for Bills and Invoices
- Data encryption
- Localization: 2 languages
- User Experience
  - Configurable Main Page (multiple configurations per `width x height` set)
  - Responsive & Adaptive Design
    - Adaptive navigation panel (top, bottom, right) and tabs (top, left)
  - Theme Mode (dark, light, system) with Palette definition (system, custom, personal -- colors selector)
  - Preserve last choice for Account, Budget, and Currency
  - Auto-scroll to the focused element on Form
  - Expand / Collapse sections on Main Page
  - Swipe for a quick access to Edit and Delete actions
  - Zoom in/out (from 60% up to 200%) via "Settings"
  - Shortcuts

| Description                         | Shortcut                       |
| ----------------------------------- | ------------------------------ |
| Open / Close the Navigation Drawer  | `Shift` + `Enter`              |
| Navigate Up                         | `up`                           |
| Navigate Down                       | `down`                         |
| Open Selected                       | `Enter`                        |
| Zoom In                             | `Ctrl` + `+`                   |
| Zoom In (with mouse)                | `Ctrl` + `scroll down`         |
| Zoom Out                            | `Ctrl` + `-`                   |
| Zoom Out (with mouse)               | `Ctrl` + `scroll up`           |
| Reset Zoom                          | `Ctrl` + `0`                   |
| Add new Transaction                 | `Ctrl` + `N`                   |
| Return Back                         | `Ctrl` + `Backspace`           |
[//]: # ( | Edit Selected Item                  | `Ctrl` + `E`                   | )
[//]: # ( | Delete Selected Item                | `Ctrl` + `D`                   | )

## Support (Sponsorship)

As an open-source project, subscribing will not unlock any additional features in the app. However, it would serve as 
an investment in the continuous evolution and improvement of the application. So, if you'd like to contribute 
financially towards the efforts, please consider these options:

* [Github Sponsorship](https://github.com/users/lyskouski/sponsorship)
* [Paypal](https://www.paypal.me/terCAD)
* [Patreon](https://www.patreon.com/terCAD)
* [Donorbox](https://donorbox.org/tercad)

Or, [treat me to :coffee:](https://www.buymeacoffee.com/lyskouski).

## Contributions

Any made contribution **is greatly appreciated** (also, by mentioning in `Contributors` section and `Release` notes
as a gratitude), check [Contribution Section](./CONTRIBUTING.md) for more details.

However, if it's been chosen a contribution (not just typo corrections) to this repo, you agree that you're giving
me a non-exclusive license to use that content, as I (and my possible team) deem appropriate. You probably guessed 
that already, but I just wanted to be extra clear on that.

## License & Copyright

The content herein are all &copy; 2023 **terCAD Team** (Viachaslau Lyskouski).

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivs 4.0 Unported License</a>.
