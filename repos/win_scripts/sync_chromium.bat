# Change to cloned src/ directory
cd repos\src
gclient sync -D --force --reset --no-history --jobs=3 --revision=%CHROMIUM_VERSION_TAG%
gclient runhooks
cd ..\..