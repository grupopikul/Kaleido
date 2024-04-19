# Commits
$env:DEPOT_TOOLS_COMMIT="1dae848"
$env:CHROMIUM_VERSION_TAG="124.0.6367.60"

$env:TAR_URL="https://chromium.googlesource.com/chromium/src.git/+archive/refs/tags/${Env:CHROMIUM_VERSION_TAG}.tar.gz"
# Tell gclient to use local Vistual Studio install
$env:DEPOT_TOOLS_WIN_TOOLCHAIN=0

# cd to repos directory
cd repos

# Get depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
cd depot_tools

# Add cloned depot_tools directory to PATH
$env:path = "$pwd;$pwd\bootstrap-3_8_0_chromium_8_bin\python\bin;$env:path"
echo $env:path
$env:GCLIENT_PY3=0

# We're checking out a specific commit, don't autoupdate
$env:DEPOT_TOOLS_UPDATE=0

# Reset to proper commit
# Note: You can clone individual branches/tags but not commits
git reset --hard ${Env:DEPOT_TOOLS_COMMIT}
git clean -ffd
git --no-pager log -2

cd ..
fetch --nohooks --no-history chromium

cd src
git reset --hard
git fetch origin 'refs/tags/${Env:CHROMIUM_VERSION_TAG}:refs/tags/${Env:CHROMIUM_VERSION_TAG}'
git checkout ${Env:CHROMIUM_VERSION_TAG}
git clean -ffd

cd ..\..

# gclient may not like it not having a .git
