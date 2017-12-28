if [ -f ./ChromePublic.apk ]; then
	if [ -d ./ChromePublic ]; then
		rm -rf ChromePublic
	fi

	unzip ChromePublic.apk -d ChromePublic
	rm -rf ./ChromePublic/AndroidManifest.xml
	rm -rf ./ChromePublic/classes.dex
	rm -rf ./ChromePublic/resources.arsc
	rm -rf ./ChromePublic/assets
	rm -rf ./ChromePublic/META-INF
	rm -rf ./ChromePublic/res

	cp ChromePublic.apk ./ChromePublic/ChromePublic.apk

	zip -d ./ChromePublic/ChromePublic.apk lib/armeabi-v7a/libchrome.so
	zip -d ./ChromePublic/ChromePublic.apk lib/armeabi-v7a/libchromium_android_linker.so
fi
