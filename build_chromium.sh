BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

cd $PWDDIR/toolchain/llvm-project
git checkout clang-19-dyncast
rm -rf build-release
mkdir build-release
cd build-release

cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja

ninja

export PATH="${HOME}/benchmark/test-suites/chromium/depot_tools:$PATH"

rm -rf $PWDDIR/out/chromium
mkdir $PWDDIR/out/chromium

rm -rf $PWDDIR/out/chromium/fulllto
mkdir $PWDDIR/out/chromium/fulllto
cd $PWDDIR/test-suites/chromium/chromium/src
rm -rf out/default
gn gen out/default
git reset --hard HEAD
git apply $PWDDIR/cmake/chromium/fulllto.patch
cp $PWDDIR/cmake/chromium/args.gn out/default/args.gn
autoninja -C out/default chrome
mv out/default/chrome $PWDDIR/out/chromium/fulllto
mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/fulllto/chrome.stats

rm -rf $PWDDIR/out/chromium/fulllto-dyncastopt
mkdir $PWDDIR/out/chromium/fulllto-dyncastopt
cd $PWDDIR/test-suites/chromium/chromium/src
rm -rf out/default
gn gen out/default
git reset --hard HEAD
git apply $PWDDIR/cmake/chromium/fulllto-dyncastopt.patch
cp $PWDDIR/cmake/chromium/args.gn out/default/args.gn
autoninja -C out/default chrome
mv out/default/chrome $PWDDIR/out/chromium/fulllto-dyncastopt
mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/fulllto-dyncastopt/chrome.stats




cd $PWDDIR/toolchain/llvm-project
git checkout ecc3d8a29e23e8710e104c37c1a4f82d5c127479
rm -rf build-release
mkdir build-release
cd build-release

cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja

ninja

rm -rf $PWDDIR/out/chromium/thinlto
mkdir $PWDDIR/out/chromium/thinlto
cd $PWDDIR/test-suites/chromium/chromium/src
rm -rf out/default
gn gen out/default
git reset --hard HEAD
git apply $PWDDIR/cmake/chromium/thinlto.patch
cp $PWDDIR/cmake/chromium/args.gn out/default/args.gn
autoninja -C out/default chrome
mv out/default/chrome $PWDDIR/out/chromium/thinlto
mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/thinlto/chrome.stats

rm -rf $PWDDIR/out/chromium/thinlto-dyncastopt
mkdir $PWDDIR/out/chromium/thinlto-dyncastopt
cd $PWDDIR/test-suites/chromium/chromium/src
rm -rf out/default
gn gen out/default
git reset --hard HEAD
git apply $PWDDIR/cmake/chromium/thinlto-dyncastopt.patch
cp $PWDDIR/cmake/chromium/args.gn out/default/args.gn
autoninja -C out/default chrome
mv out/default/chrome $PWDDIR/out/chromium/thinlto-dyncastopt
mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/thinlto-dyncastopt/chrome.stats
