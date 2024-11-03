BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

#cd toolchain/llvm-project
#git checkout dyncast
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja

rm -rf $PWDDIR/out/llvm/shared
mkdir $PWDDIR/out/llvm/shared
cd $PWDDIR/out/llvm/shared
cmake $PWDDIR/test-suites/llvm-project/llvm -DLLVM_BUILD_LLVM_DYLIB=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-fPIC -flto=thin -fwhole-program-vtables -Wl,--lto-whole-program-visibility -save-stats=obj -fuse-ld=lld"
ninja
