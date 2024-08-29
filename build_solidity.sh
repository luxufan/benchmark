BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

# Build llvm project
cd toolchain/llvm-project
git checkout remotes/origin/dyncast
rm -rf build-release
mkdir build-release
cd build-release

cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja

ninja


rm -rf $PWDDIR/out/solidity
mkdir $PWDDIR/out/solidity

rm -rf $PWDDIR/out/solidity/thinlto-dyncastopt
mkdir $PWDDIR/out/solidity/thinlto-dyncastopt
rm -rf $PWDDIR/out/solidity/temp
mkdir $PWDDIR/out/solidity/temp
cd $PWDDIR/out/solidity/temp
cmake $PWDDIR/test-suites/solidity -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto=thin -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility" -DUSE_Z3=OFF
ninja solc
mv $PWDDIR/out/solidity/temp/solc/solc $PWDDIR/out/solidity/thinlto-dyncastopt
mv $PWDDIR/out/solidity/temp/solc/main.cpp.stats $PWDDIR/out/solidity/thinlto-dyncastopt/solc.stats

rm -rf $PWDDIR/out/solidity/thinlto
mkdir $PWDDIR/out/solidity/thinlto
rm -rf $PWDDIR/out/solidity/temp
mkdir $PWDDIR/out/solidity/temp
cd $PWDDIR/out/solidity/temp
cmake $PWDDIR/test-suites/solidity -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto=thin -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false" -DUSE_Z3=OFF
ninja solc
mv $PWDDIR/out/solidity/temp/solc/solc $PWDDIR/out/solidity/thinlto
mv $PWDDIR/out/solidity/temp/solc/main.cpp.stats $PWDDIR/out/solidity/thinlto/solc.stats

rm -rf $PWDDIR/out/solidity/fulllto-dyncastopt
mkdir $PWDDIR/out/solidity/fulllto-dyncastopt
rm -rf $PWDDIR/out/solidity/temp
mkdir $PWDDIR/out/solidity/temp
cd $PWDDIR/out/solidity/temp
cmake $PWDDIR/test-suites/solidity -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility" -DUSE_Z3=OFF
ninja solc
mv $PWDDIR/out/solidity/temp/solc/solc $PWDDIR/out/solidity/fulllto-dyncastopt
mv $PWDDIR/out/solidity/temp/solc/main.cpp.stats $PWDDIR/out/solidity/fulllto-dyncastopt/solc.stats

rm -rf $PWDDIR/out/solidity/fulllto
mkdir $PWDDIR/out/solidity/fulllto
rm -rf $PWDDIR/out/solidity/temp
mkdir $PWDDIR/out/solidity/temp
cd $PWDDIR/out/solidity/temp
cmake $PWDDIR/test-suites/solidity -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-flto -save-stats=obj -fwhole-program-vtables -fuse-ld=lld -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false" -DUSE_Z3=OFF
ninja solc
mv $PWDDIR/out/solidity/temp/solc/solc $PWDDIR/out/solidity/fulllto
mv $PWDDIR/out/solidity/temp/solc/main.cpp.stats $PWDDIR/out/solidity/fulllto/solc.stats

