# abuabdallah_store

A store application

## Getting Started

To Generate intl_messages.arb use below cmd
    flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localizations.dart



To convert intl_ar.arb and intl_en.arb to dart files then use below

    flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \
     --no-use-deferred-loading lib/localizations.dart lib/l10n/intl_*.arb



     flutter clean && rm ios/Podfile.lock pubspec.lock && rm -rf ios/Pods ios/Runner.xcworkspace

if flutter.h not found then do below commands

rm ios/Flutter/Flutter.podspec && flutter clean




copy paste issue fixed on BETA 1.23.0-18.1.pre which released at  16/0ct/2020


 pod update --repo-update