# rebuild

DATE=`eval date +%Y`-`eval date +%m`-`eval date +%d`-`eval date +%H`-`eval date +%M`
ROOT="/home/andi/chromium"


cd "${ROOT}/src"

echo "Setting default jdk to 1.8"
echo 3 | sudo /usr/bin/update-alternatives --config java > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config javac > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config javadoc > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config javap > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config jar > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config jarsigner > /dev/null

gn gen '--args=target_os="android" is_debug=false symbol_level=0 enable_nacl=false remove_webcore_debug_symbols=true' out/Default

autoninja -C out/Default monochrome_public_apk
autoninja -C out/Default chrome_modern_public_apk
autoninja -C out/Default chrome_public_apk

PUBLICAPK=$DATE-public
mkdir -p $ROOT/$PUBLICAPK
mv $ROOT/src/out/Default/apks/*.apk $ROOT/$PUBLICAPK/

gn gen '--args=target_os="android" is_debug=false symbol_level=0 enable_nacl=false remove_webcore_debug_symbols=true proprietary_codecs=true ffmpeg_branding="Chrome"' out/Default
autoninja -C out/Default monochrome_public_apk
autoninja -C out/Default chrome_modern_public_apk
autoninja -C out/Default chrome_public_apk

PRIVATEAPK=$DATE-private
mkdir -p $ROOT/$PRIVATEAPK
mv $ROOT/src/out/Default/apks/*.apk $ROOT/$PRIVATEAPK/
