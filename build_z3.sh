BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

# Build llvm project
#cd toolchain/llvm-project
#git checkout dyncast
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja


#rm -rf $PWDDIR/out/z3
#mkdir $PWDDIR/out/z3

#rm -rf $PWDDIR/out/z3/thinlto-dyncastopt
#mkdir $PWDDIR/out/z3/thinlto-dyncastopt
#rm -rf $PWDDIR/out/z3/temp
#mkdir $PWDDIR/out/z3/temp
#cd $PWDDIR/out/z3/temp
#cmake $PWDDIR/test-suites/z3 -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto=thin -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility" -DUSE_Z3=OFF
#ninja z3
#mv $PWDDIR/out/z3/temp/z3 $PWDDIR/out/z3/thinlto-dyncastopt
#mv $PWDDIR/out/z3/temp/approx_nat.cpp.stats $PWDDIR/out/z3/thinlto-dyncastopt/z3.stats
#
#rm -rf $PWDDIR/out/z3/thinlto
#mkdir $PWDDIR/out/z3/thinlto
#rm -rf $PWDDIR/out/z3/temp
#mkdir $PWDDIR/out/z3/temp
#cd $PWDDIR/out/z3/temp
#cmake $PWDDIR/test-suites/z3 -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto=thin -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false" -DUSE_Z3=OFF
#ninja z3
#mv $PWDDIR/out/z3/temp/z3 $PWDDIR/out/z3/thinlto
#mv $PWDDIR/out/z3/temp/approx_nat.cpp.stats $PWDDIR/out/z3/thinlto/z3.stats
##
rm -rf $PWDDIR/out/z3/fulllto-dyncastopt
mkdir $PWDDIR/out/z3/fulllto-dyncastopt
rm -rf $PWDDIR/out/z3/temp
mkdir $PWDDIR/out/z3/temp
cd $PWDDIR/out/z3/temp
cmake $PWDDIR/test-suites/z3 -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility" -DUSE_Z3=OFF
ninja z3
mv $PWDDIR/out/z3/temp/z3 $PWDDIR/out/z3/fulllto-dyncastopt
mv $PWDDIR/out/z3/temp/approx_nat.cpp.stats $PWDDIR/out/z3/fulllto-dyncastopt/z3.stats

#rm -rf $PWDDIR/out/z3/fulllto
#mkdir $PWDDIR/out/z3/fulllto
#rm -rf $PWDDIR/out/z3/temp
#mkdir $PWDDIR/out/z3/temp
#cd $PWDDIR/out/z3/temp
#cmake $PWDDIR/test-suites/z3 -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false" -DUSE_Z3=OFF
#ninja z3
#mv $PWDDIR/out/z3/temp/z3 $PWDDIR/out/z3/fulllto
#mv $PWDDIR/out/z3/temp/approx_nat.cpp.stats $PWDDIR/out/z3/fulllto/z3.stats
##
#rm -rf $PWDDIR/out/z3/pgo
#mkdir $PWDDIR/out/z3/pgo
#rm -rf $PWDDIR/out/z3/temp
#mkdir $PWDDIR/out/z3/temp
#cd $PWDDIR/out/z3/temp
#cmake $PWDDIR/test-suites/z3 -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false ~/benchmark/toolchain/llvm-project/build-release/lib/clang/18/lib/x86_64-unknown-linux-gnu/libclang_rt.profile.a -save-stats=obj -fuse-ld=lld" -DUSE_Z3=OFF
#ninja z3
#mv $PWDDIR/out/z3/temp/z3 $PWDDIR/out/z3/pgo
