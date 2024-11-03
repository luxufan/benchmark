BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

#rm -rf $PWDDIR/out/llvm
#mkdir $PWDDIR/out/llvm

rm -rf $PWDDIR/out/llvm/thinlto-dyncastopt
mkdir $PWDDIR/out/llvm/thinlto-dyncastopt
rm -rf $PWDDIR/out/llvm/temp
mkdir $PWDDIR/out/llvm/temp
cd $PWDDIR/out/llvm/temp
cmake $PWDDIR/test-suites/llvm-project/llvm -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -Wl,-plugin-opt=-enable-range-check=true -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,-save-temps"
ninja opt
mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/thinlto-dyncastopt
mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/thinlto-dyncastopt/opt.stats
###
#rm -rf $PWDDIR/out/llvm/thinlto
#mkdir $PWDDIR/out/llvm/thinlto
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja check-llvm
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/thinlto
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/thinlto/opt.stats
###
rm -rf $PWDDIR/out/llvm/fulllto-dyncastopt
mkdir $PWDDIR/out/llvm/fulllto-dyncastopt
rm -rf $PWDDIR/out/llvm/temp
mkdir $PWDDIR/out/llvm/temp
cd $PWDDIR/out/llvm/temp
cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=true" -DLLVM_ENABLE_STD_DYN_CAST=ON
ninja opt
mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto-dyncastopt
mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/fulllto-dyncastopt/opt.stats

#rm -rf $PWDDIR/out/llvm/fulllto
#mkdir $PWDDIR/out/llvm/fulllto
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto
#mv $PWDDIR/out/llvm/temp/bin/newpmdriver.cpp.stats $PWDDIR/out/llvm/fulllto/opt.stats
#
#
#rm -rf $pwddir/out/llvm/origin-fulllto
#mkdir $pwddir/out/llvm/origin-fulllto
#rm -rf $pwddir/out/llvm/temp
#mkdir $pwddir/out/llvm/temp
#cd $pwddir/out/llvm/temp
#cmake $pwddir/test-suites/llvm-project/llvm -dcmake_build_type=release -dcmake_cxx_compiler=$pwddir/toolchain/llvm-project/build-release/bin/clang++ -dcmake_c_compiler=$pwddir/toolchain/llvm-project/build-release/bin/clang -dllvm_use_linker=lld -g ninja -dcmake_build_type=release -dllvm_enable_rtti=on -dllvm_targets_to_build=x86 -dcmake_cxx_flags="-flto -fwhole-program-vtables -wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $pwddir/out/llvm/temp/bin/opt $pwddir/out/llvm/origin-fulllto
#mv $pwddir/out/llvm/temp/bin/newpmdriver.cpp.stats $pwddir/out/llvm/origin/opt.stats
##
#rm -rf $PWDDIR/out/llvm/origin-thinlto
#mkdir $PWDDIR/out/llvm/origin-thinlto
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/origin-thinlto
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/origin/opt.stats

#rm -rf $PWDDIR/out/llvm/origin-virtual-fulllto
#mkdir $PWDDIR/out/llvm/origin-virtual-fulllto
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/origin-virtual-fulllto
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/origin/opt.stats
##
#rm -rf $PWDDIR/out/llvm/origin-virtual-thinlto
#mkdir $PWDDIR/out/llvm/origin-virtual-thinlto
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/origin-virtual-thinlto
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/origin/opt.stats
#
#rm -rf $PWDDIR/out/llvm/origin-fulllto-no-rtti
#mkdir $PWDDIR/out/llvm/origin-fulllto-no-rtti
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/origin-fulllto-no-rtti
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/origin/opt.stats

#rm -rf $PWDDIR/out/llvm/fulllto-dyncastopt-getopcode
#mkdir $PWDDIR/out/llvm/fulllto-dyncastopt-getopcode
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=true" -DLLVM_ENABLE_STD_DYN_CAST=ON
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto-dyncastopt-getopcode
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/fulllto-dyncastopt-getopcode/opt.stats
#
#rm -rf $PWDDIR/out/llvm/fulllto-getopcode
#mkdir $PWDDIR/out/llvm/fulllto-getopcode
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto-getopcode
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/origin/opt.stats
#
#rm -rf $PWDDIR/out/llvm/fulllto
#mkdir $PWDDIR/out/llvm/fulllto
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/fulllto
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/fulllto/opt.stats
#rm -rf $PWDDIR/out/llvm/no-range-check
#mkdir $PWDDIR/out/llvm/no-range-check
#rm -rf $PWDDIR/out/llvm/temp
#mkdir $PWDDIR/out/llvm/temp
#cd $PWDDIR/out/llvm/temp
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-flto -fwhole-program-vtables -Wl,--lto-whole-program-visibility -fvisibility=hidden -save-stats=obj -fuse-ld=lld -Wl,--plugin-opt=-enable-dyncastopt=true -Wl,-plugin-opt=-enable-range-check=false"
#ninja opt
#mv $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/no-range-check
#mv $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/no-range-check/opt.stats
