#fetch --nohooks android
# Chromium
#
# Versions
# 70 = alpha
# 69 = beta
# 68 = stable
#
#
# https://groups.google.com/a/chromium.org/forum/#!topic/chromium-dev/WBSeL0E6-70
# https://groups.google.com/a/chromium.org/forum/#!topic/chromium-dev/e0zOss0bHaU
# https://www.chromium.org/developers/how-tos/build-instructions-android-webview
# https://github.com/scheib/chromium/blob/master/docs/android_build_instructions.md
# https://chromium.googlesource.com/chromium/src/+/master/docs/android_build_instructions.md
#

DATE=`eval date +%Y`-`eval date +%m`-`eval date +%d`-`eval date +%H`-`eval date +%M`
ROOT="/home/andi/chromium"


cd "${ROOT}/src"

gclient sync --with_branch_heads
git fetch

PATCHPATH="/home/andi/chromium/patches/69"
git checkout 69.0.3497.5

gclient sync

for patches in "${PATCHPATH[@]}"; do
    cd "${ROOT}/src"
    git am --whitespace=nowarn "${patches}"/*
    cd "${ROOT}/src"
done

rm -rf out

echo "Setting default jdk to 1.8"
echo 3 | sudo /usr/bin/update-alternatives --config java > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config javac > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config javadoc > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config javap > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config jar > /dev/null
echo 3 | sudo /usr/bin/update-alternatives --config jarsigner > /dev/null

gn gen '--args=target_os="android" is_debug=false symbol_level=0 enable_nacl=false remove_webcore_debug_symbols=true' out/Default

ninja -C out/Default monochrome_public_apk
ninja -C out/Default chrome_modern_public_apk
ninja -C out/Default chrome_public_apk

PUBLICAPK=$DATE-public
mkdir -p $ROOT/$PUBLICAPK
mv $ROOT/src/out/Default/apks/*.apk $ROOT/$PUBLICAPK/

gn gen '--args=target_os="android" is_debug=false symbol_level=0 enable_nacl=false remove_webcore_debug_symbols=true proprietary_codecs=true ffmpeg_branding="Chrome"' out/Default
ninja -C out/Default monochrome_public_apk
ninja -C out/Default chrome_modern_public_apk
ninja -C out/Default chrome_public_apk

PRIVATEAPK=$DATE-private
mkdir -p $ROOT/$PRIVATEAPK
mv $ROOT/src/out/Default/apks/*.apk $ROOT/$PRIVATEAPK/
