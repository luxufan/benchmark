BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

#rm -rf $PWDDIR/out/spec2006
#mkdir $PWDDIR/out/spec2006

#rm -rf $PWDDIR/out/spec2006/thinlto-dyncastopt
#mkdir $PWDDIR/out/spec2006/thinlto-dyncastopt
#cd $PWDDIR/out/spec2006/thinlto-dyncastopt
#cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_C_FLAGS=-fuse-ld=lld -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -O2 -fuse-ld=lld -fvisibility=hidden" -DCMAKE_EXE_LINKER_FLAGS="-flto=thin -fuse-ld=lld -Wl,-save-temps -Wl,--lto-whole-program-visibility -save-stats=obj -Wl,--plugin-opt=-enable-dyncastopt=true" -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External
#ninja
##
#rm -rf $PWDDIR/out/spec2006/thinlto
#mkdir $PWDDIR/out/spec2006/thinlto
#cd $PWDDIR/out/spec2006/thinlto
#cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_C_FLAGS=-fuse-ld=lld -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -O2 -fuse-ld=lld -fvisibility=hidden" -DCMAKE_EXE_LINKER_FLAGS="-flto=thin -fuse-ld=lld -Wl,--lto-whole-program-visibility -save-stats=obj -Wl,--plugin-opt=-enable-dyncastopt=false" -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External
#ninja
#
#rm -rf $PWDDIR/out/spec2006/fulllto
#mkdir $PWDDIR/out/spec2006/fulllto
#cd $PWDDIR/out/spec2006/fulllto
#cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_C_FLAGS=-fuse-ld=lld -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -O2 -fuse-ld=lld -fvisibility=hidden" -DCMAKE_EXE_LINKER_FLAGS="-flto -fuse-ld=lld -Wl,--lto-whole-program-visibility -save-stats=obj -Wl,--plugin-opt=-enable-dyncastopt=false" -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External
#ninja

rm -rf $PWDDIR/out/spec2006/fulllto-dyncastopt
mkdir $PWDDIR/out/spec2006/fulllto-dyncastopt
cd $PWDDIR/out/spec2006/fulllto-dyncastopt
cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_C_FLAGS=-fuse-ld=lld -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -O2 -fuse-ld=lld -fvisibility=hidden" -DCMAKE_EXE_LINKER_FLAGS="-flto -fuse-ld=lld -Wl,--save-temps=internalize -Wl,--lto-whole-program-visibility -save-stats=obj -Wl,--plugin-opt=-enable-dyncastopt=true" -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External -DCMAKE_VERBOSE_MAKEFILE=ON
ninja

#rm -rf $PWDDIR/out/spec2006/pgo
#mkdir $PWDDIR/out/spec2006/pgo
#cd $PWDDIR/out/spec2006/pgo
#cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_C_FLAGS=-fuse-ld=lld -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -O2 -fuse-ld=lld -fvisibility=hidden" -DCMAKE_EXE_LINKER_FLAGS="-flto=thin -fuse-ld=lld -Wl,--lto-whole-program-visibility -save-stats=obj -Wl,--plugin-opt=-enable-dyncastopt=false ~/benchmark/toolchain/llvm-project/build-release/lib/clang/18/lib/x86_64-unknown-linux-gnu/libclang_rt.profile.a " -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External
#ninja 471.omnetpp 447.dealII
