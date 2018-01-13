# README


### Avoid patching device tree or rom source to add Chromium prebuilt to your Rom

- For Android 5 and below we are using ChromePublic.apk
- For Android 6 and newer we are using ChromeModernPublic.apk


### Note

There's no issue while installing the apks!

- Android Jelly Bean and newer: [Download ChromePublic.apk](https://github.com/andi34/prebuilt_chromium/raw/master/ChromePublic.apk)
- Android Lollipop and newer: [Download ChromeModernPublic.apk](https://github.com/andi34/prebuilt_chromium/raw/master/ChromeModernPublic.apk)
- Android Nougat and newer: [Download MonochromePublic.apk](https://github.com/andi34/prebuilt_chromium/raw/master/MonochromePublic.apk)


### Monochrome on Android 7+

To use prebuilt MonochromePublic.apk on Android 7+ you need to add chromium to frameworks/base/core/res/res/xml/config_webview_packages.xml
(Your can also add it to your device overlay).

```
<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright 2015 The Android Open Source Project
     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at
          http://www.apache.org/licenses/LICENSE-2.0
     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
-->

<webviewproviders>
    <!-- The default WebView implementation -->
    <webviewprovider description="Chromium" packageName="org.chromium.chrome" availableByDefault="true">
    </webviewprovider>
</webviewproviders>
```


### Chrome/Chromium on Lollipop requires an extra patch

On Android 5 ChromeModernPublic.apk can't be used as prebuilt without patching your Rom source:

Run these commands:
```
cd build
curl https://raw.githubusercontent.com/andi34/prebuilt_chromium/master/patches/Lollipop/0001-Fix-Chrome.patch | git am -
```


### Multiple Chrome APK Targets according to the build instructions

1. `chrome_public_apk` (ChromePublic.apk)
   * `minSdkVersion=16` (Jelly Bean).
   * Stores libchrome.so compressed within the APK.
   * Uses [Crazy Linker](https://cs.chromium.org/chromium/src/base/android/linker/BUILD.gn?rcl=6bb29391a86f2be58c626170156cbfaa2cbc5c91&l=9).
   * Shipped only for Android < 21, but still works fine on Android >= 21.
2. `chrome_modern_public_apk` (ChromeModernPublic.apk)
   * `minSdkVersion=21` (Lollipop).
   * Uses [Crazy Linker](https://cs.chromium.org/chromium/src/base/android/linker/BUILD.gn?rcl=6bb29391a86f2be58c626170156cbfaa2cbc5c91&l=9).
   * Stores libchrome.so uncompressed within the APK.
     * This APK is bigger, but the installation size is smaller since there is
       no need to extract the .so file.
3. `monochrome_public_apk` (MonochromePublic.apk)
   * `minSdkVersion=24` (Nougat).
   * Contains both WebView and Chrome within the same APK.
     * This APK is even bigger, but much smaller than SystemWebView.apk + ChromePublic.apk.
   * Stores libchrome.so uncompressed within the APK.
   * Does not use Crazy Linker (WebView requires system linker).
     * But system linker supports crazy linker features now anyways.
