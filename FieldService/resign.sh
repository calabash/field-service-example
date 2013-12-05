#!/bin/bash
tmp_resign_apk_path="/tmp/tmp_path_for_resigned.apk"
echo $tmp_resign_apk_path
rm $tmp_resign_apk_path
zip $1 -d "META-INF/*"
jarsigner -keystore ~/.android/debug.keystore -storepass android -keypass android $1 androiddebugkey
$ANDROID_HOME/tools/zipalign 4 $1 $tmp_resign_apk_path
mv $tmp_resign_apk_path $1
