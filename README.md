# Buddy

Buddy is an app that aims to help people passing through difficult situations, like crisis, depression, sadness, loss of a loved one or with suicidal thoughts. It shows daily notifications on the user's phone with helping, inspiring, encouraging, caring quotes and tips to help and make the person feel better. It also shows a list of contacts like phone numbers, websites, emails, of helping lines and institutions, if the user wants to talk with somebody and/or asking for more help.

## Getting Started

This project is made entirely with [Flutter](https://flutter.dev) and as a submission to the [Flutter Create contest](https://flutter.dev/create). It was developed having in mind all the rules and guidelines provided by the contest.

The app is prepared to run on iOS and Android.

To review the code (main.dart), please first use Dart Formatter (dartfmt) to make the code more easily readable. Because in order to keep the code small (under 5kb), I had to strip some unnecessary characters, spaces, indentation, which doesn't affect the code at all, just allows the file to be smaller. And it's permitted under the contest rules.

## More Details

This app will show a list of options for the user. Once the user selects one, it shows a dialog asking the user if he confirms starting receiving daily notifications with quotes and tips about the selected topic. The can confirm, close the dialog or cancel all notifications.

When the user confirms to receive daily notifications, the app will schedule the notifications in the system, natively on iOS and Android. The app can be closed then.

For the sake of this project, there's a [data.json](assets/data.json) file in the assets folder that holds the menu options and the quotes showed in the notifications. The app loads this file when it initiates, builds the menu and gets the quotes data. It could have been done reading an online REST API, but I wanted to keep it simple, reading the data locally. On a production version of this app, I would probably use an own backend server to manage the data and send push notifications, instead of local notifications.

## Dependencies

- [flare_flutter](https://pub.dartlang.org/packages/flare_flutter)
  - To be able to show the Flare animated objects.
- [flutter_local_notifications](https://pub.dartlang.org/packages/flutter_local_notifications)
  - To schedule and show local notifications on iOS and Android.
- [url_launcher](https://pub.dartlang.org/packages/url_launcher)
  - To open a URL on the native browser.
- [easy_listview](https://pub.dartlang.org/packages/easy_listview)
  - To have a more concise way to create and show a listview, with header and footer.
- [flutter_launcher_icons](https://pub.dartlang.org/packages/flutter_launcher_icons)
  - To create the app launch icon on the various formats for iOS and Android.

## Screenshots

<img src="https://github.com/cetorres/buddy/raw/master/screenshot1.png" width="300" /><img src="https://github.com/cetorres/buddy/raw/master/screenshot2.png" width="300" /><img src="https://github.com/cetorres/buddy/raw/master/screenshot3.png" width="300" /><img src="https://github.com/cetorres/buddy/raw/master/screenshot4.png" width="300" /><img src="https://github.com/cetorres/buddy/raw/master/screenshot5.png" width="300" />

## Design

The author created all the visual elements of the app:
- [App icon](assets/app_icon.png)
- [Buddy animated logo](assets/buddy.flr)
- [Bottom animated waves](assets/waves.flr)

The animated elements were create using [Flare](https://www.2dimensions.com/about-flare) free online tool and integrated into the app with [flare_flutter](https://pub.dartlang.org/packages/flare_flutter) package.

## Author

Carlos E. Torres

Senior software engineer, mobile solutions specialist, product manager, entrepreneur, tech startups lover and [Spiritist](https://www.spiritist.us/spiritism).

- Website: https://cetorres.com
- Email: cetorres@cetorres.com
- Github: https://github.com/cetorres
- LinkedIn: https://linkedin.com/in/cetorres
