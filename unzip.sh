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
fi
