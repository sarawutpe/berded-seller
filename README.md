# berded manager


flutter pub run flutter_launcher_icons:main
flutter run --release

flutter build apk
flutter build appbundle

com.codemobiles.berded.manager


connect android adb via wifi
-----------------------------
adb devices
adb tcpip 5555
adb shell ip addr show wlan0
adb connect 192.168.0.114
