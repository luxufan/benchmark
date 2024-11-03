BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

export PATH="${HOME}/benchmark/test-suites/chromium/depot_tools:$PATH"
#cd $PWDDIR/toolchain/llvm-project
#git checkout chrome-thinlto
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja
#
#rm -rf $PWDDIR/out/chromium/thinlto
#mkdir $PWDDIR/out/chromium/thinlto
#cd $PWDDIR/test-suites/chromium/chromium/src
#rm -rf out/thinlto
#gn gen out/thinlto
#git reset --hard HEAD
#git apply $PWDDIR/cmake/chromium/thinlto.patch
#cp $PWDDIR/cmake/chromium/args.gn out/thinlto/args.gn
#autoninja -C out/thinlto chrome
#mv out/default/chrome $PWDDIR/out/chromium/thinlto
#mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/thinlto/chrome.stats
#
#rm -rf $PWDDIR/out/chromium/thinlto-dyncastopt
#mkdir $PWDDIR/out/chromium/thinlto-dyncastopt
#cd $PWDDIR/test-suites/chromium/chromium/src
#rm -rf out/thinlto-dyncastopt
#gn gen out/thinlto-dyncastopt
#git reset --hard HEAD
#git apply $PWDDIR/cmake/chromium/thinlto-dyncastopt.patch
#cp $PWDDIR/cmake/chromium/args.gn out/thinlto-dyncastopt/args.gn
#autoninja -C out/thinlto-dyncastopt chrome
#mv out/thinlto-dyncastopt/chrome $PWDDIR/out/chromium/thinlto-dyncastopt
#mv out/thinlto-dyncastopt/chrome_exe_main_aura.stats $PWDDIR/out/chromium/thinlto-dyncastopt/chrome.stats
#
#cd $PWDDIR/toolchain/llvm-project
#git checkout clang-19-dyncast
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja


#rm -rf $PWDDIR/out/chromium
#mkdir $PWDDIR/out/chromium
#

rm -rf $PWDDIR/out/chromium/fulllto-dyncastopt
mkdir $PWDDIR/out/chromium/fulllto-dyncastopt
cd $PWDDIR/test-suites/chromium/chromium/src
rm -rf out/fulllto-dyncastopt
gn gen out/fulllto-dyncastopt
git reset --hard HEAD
git apply $PWDDIR/cmake/chromium/fulllto-dyncastopt.patch
cp $PWDDIR/cmake/chromium/args.gn out/fulllto-dyncastopt/args.gn
autoninja -C out/fulllto-dyncastopt chrome
cp out/fulllto-dyncastopt/chrome $PWDDIR/out/chromium/fulllto-dyncastopt
cp out/fulllto-dyncastopt/chrome_exe_main_aura.stats $PWDDIR/out/chromium/fulllto-dyncastopt/chrome.stats

#rm -rf $PWDDIR/out/chromium/fulllto
#mkdir $PWDDIR/out/chromium/fulllto
#cd $PWDDIR/test-suites/chromium/chromium/src
#rm -rf out/fulllto
#gn gen out/fulllto
#git reset --hard HEAD
#git apply $PWDDIR/cmake/chromium/fulllto.patch
#cp $PWDDIR/cmake/chromium/args.gn out/fulllto/args.gn
#autoninja -C out/fulllto chrome
#mv out/fulllto/chrome $PWDDIR/out/chromium/fulllto
#mv out/fulllto/chrome_exe_main_aura.stats $PWDDIR/out/chromium/fulllto/chrome.stats

#
#
#cd $PWDDIR/toolchain/llvm-project
#git checkout b963931eb8bda810e2a8ad08832402993b931d69
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja
#
#
#rm -rf $PWDDIR/out/chromium/sanitize
#mkdir $PWDDIR/out/chromium/sanitize
#cd $PWDDIR/test-suites/chromium/chromium/src
#rm -rf out/sanitize
#gn gen out/sanitize
##git reset --hard HEAD
##git apply $PWDDIR/cmake/chromium/thinlto.patch
#cp $PWDDIR/cmake/chromium/args-sanitize.gn out/sanitize/args.gn
#autoninja -C out/sanitize chrome
##mv out/default/chrome $PWDDIR/out/chromium/thinlto
##mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/thinlto/chrome.stats
##
##rm -rf $PWDDIR/out/chromium/origin
##mkdir $PWDDIR/out/chromium/origin
##cd $PWDDIR/test-suites/chromium/chromium/src
##rm -rf out/origin
##gn gen out/sanitize
###git reset --hard HEAD
###git apply $PWDDIR/cmake/chromium/thinlto.patch
##cp $PWDDIR/cmake/chromium/args-sanitize.gn out/sanitize/args.gn
##autoninja -C out/sanitize chrome
###mv out/default/chrome $PWDDIR/out/chromium/thinlto
###mv out/default/chrome_exe_main_aura.stats $PWDDIR/out/chromium/thinlto/chrome.stats
##
