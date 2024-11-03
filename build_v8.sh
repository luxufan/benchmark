BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

#cd $PWDDIR/toolchain/llvm-project
#git checkout clang-19-dyncast-frontend
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja

export PATH="${HOME}/benchmark/test-suites/chromium/depot_tools:$PATH"
#
#rm -rf $PWDDIR/out/v8
#mkdir $PWDDIR/out/v8
#
#rm -rf $PWDDIR/out/v8/fulllto
#mkdir $PWDDIR/out/v8/fulllto
#cd $PWDDIR/test-suites/v8/v8
#rm -rf out/default
#gn gen out/default
#cd $PWDDIR/test-suites/v8/v8/build
#git reset --hard HEAD
#cd $PWDDIR/test-suites/v8/v8
#git apply $PWDDIR/cmake/chromium/fulllto.patch
#cp $PWDDIR/cmake/chromium/lto-O2.gn out/default/args.gn
#autoninja -C out/default d8
#mv out/default/d8 $PWDDIR/out/v8/fulllto
#mv out/default/snapshot_blob.bin $PWDDIR/out/v8/fulllto
#mv out/default/embedded-empty.stats $PWDDIR/out/v8/fulllto/d8.stats
##
rm -rf $PWDDIR/out/v8/fulllto-dyncastopt
mkdir $PWDDIR/out/v8/fulllto-dyncastopt
cd $PWDDIR/test-suites/v8/v8
rm -rf out/default
gn gen out/default
cd $PWDDIR/test-suites/v8/v8/build
git reset --hard HEAD
cd $PWDDIR/test-suites/v8/v8
git apply $PWDDIR/cmake/chromium/fulllto-dyncastopt.patch
cp $PWDDIR/cmake/chromium/lto-O2.gn out/default/args.gn
autoninja -C out/default d8
mv out/default/d8 $PWDDIR/out/v8/fulllto-dyncastopt
mv out/default/snapshot_blob.bin $PWDDIR/out/v8/fulllto-dyncastopt
mv out/default/embedded-empty.stats $PWDDIR/out/v8/fulllto-dyncastopt/v8.stats

#cd $PWDDIR/toolchain/llvm-project
#git checkout chrome-thinlto
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja

#rm -rf $PWDDIR/out/v8/thinlto
#mkdir $PWDDIR/out/v8/thinlto
#cd $PWDDIR/test-suites/v8/v8
#rm -rf out/default
#gn gen out/default
#cd $PWDDIR/test-suites/v8/v8/build
#git reset --hard HEAD
#cd $PWDDIR/test-suites/v8/v8
#git apply $PWDDIR/cmake/chromium/thinlto.patch
#cp $PWDDIR/cmake/chromium/lto-O2.gn out/default/args.gn
#autoninja -C out/default d8
#mv out/default/d8 $PWDDIR/out/v8/thinlto
#mv out/default/snapshot_blob.bin $PWDDIR/out/v8/thinlto
#mv out/default/embedded-empty.stats $PWDDIR/out/v8/thinlto/d8.stats

#rm -rf $PWDDIR/out/v8/thinlto-dyncastopt
#mkdir $PWDDIR/out/v8/thinlto-dyncastopt
#cd $PWDDIR/test-suites/v8/v8
#rm -rf out/default
#gn gen out/default
#cd $PWDDIR/test-suites/v8/v8/build
#git reset --hard HEAD
#cd $PWDDIR/test-suites/v8/v8
#git apply $PWDDIR/cmake/chromium/thinlto-dyncastopt.patch
#cp $PWDDIR/cmake/chromium/lto-O2.gn out/default/args.gn
#autoninja -C out/default d8
#mv out/default/d8 $PWDDIR/out/v8/thinlto-dyncastopt
#mv out/default/snapshot_blob.bin $PWDDIR/out/v8/thinlto-dyncastopt
#mv out/default/embedded-empty.stats $PWDDIR/out/v8/thinlto-dyncastopt/d8.stats
