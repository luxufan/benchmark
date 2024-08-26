BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

rm -rf $PWDDIR/out/llvm
mkdir $PWDDIR/out/llvm

rm -rf $PWDDIR/out/llvm/thinlto-dyncastopt
mkdir $PWDDIR/out/llvm/thinlto-dyncastopt
rm -rf $PWDDIR/out/llvm/temp
mkdir $PWDDIR/out/llvm/temp
cd $PWDDIR/out/llvm/temp
cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld"
ninja opt
mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/thinlto-dyncastopt
mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/thinlto-dyncastopt/opt.stats

rm -rf $PWDDIR/out/llvm/thinlto
mkdir $PWDDIR/out/llvm/thinlto
rm -rf $PWDDIR/out/llvm/temp
mkdir $PWDDIR/out/llvm/temp
cd $PWDDIR/out/llvm/temp
cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
ninja opt
mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/thinlto
mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/thinlto/opt.stats

rm -rf $PWDDIR/out/llvm/fulllto-dyncastopt
mkdir $PWDDIR/out/llvm/fulllto-dyncastopt
rm -rf $PWDDIR/out/llvm/temp
mkdir $PWDDIR/out/llvm/temp
cd $PWDDIR/out/llvm/temp
cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=true"
ninja opt
mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto-dyncastopt
mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/fulllto-dyncastopt/opt.stats

rm -rf $PWDDIR/out/llvm/fulllto
mkdir $PWDDIR/out/llvm/fulllto
rm -rf $PWDDIR/out/llvm/temp
mkdir $PWDDIR/out/llvm/temp
cd $PWDDIR/out/llvm/temp
cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
ninja opt
mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto
mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/fulllto/opt.stats
