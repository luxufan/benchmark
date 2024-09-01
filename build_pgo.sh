BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

#cd $PWDDIR/toolchain/llvm-project
#git checkout dyncast-pgo
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja clang lld

#$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -c $PWDDIR/toolchain/llvm-project/libcxxabi/src/private_typeinfo.cpp -isystem $PWDDIR/toolchain/llvm-project/libcxxabi/include -fPIC -o $PWDDIR/toolchain/llvm-project/build-release/bin/private_typeinfo.o -fdyncast-pgo

#rm -rf $PWDDIR/out-pgo/blender
#mkdir $PWDDIR/out-pgo/blender
#cp $PWDDIR/cmake/blender/dyncast-pgo/CMakeCache.txt $PWDDIR/test-suites/build_linux/CMakeCache.txt
#cd $PWDDIR/test-suites/blender
#make
#mv $PWDDIR/test-suites/build_linux/bin/blender $PWDDIR/out-pgo/blender
#
#rm -rf $PWDDIR/out-pgo/solidity
#mkdir $PWDDIR/out-pgo/solidity
#cd $PWDDIR/out-pgo/solidity
#cmake $PWDDIR/test-suites/solidity -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DCMAKE_CXX_FLAGS="-Wl,$PWDDIR/toolchain/llvm-project/build-release/bin/private_typeinfo.o -fdyncast-pgo" -DUSE_Z3=OFF
#ninja isoltest

#cd $PWDDIR/toolchain/llvm-project
#git checkout libc++-pgo
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja
#
#cd $PWDDIR
#
#export PATH="$PWDDIR/toolchain/llvm-project/build-release/bin:$PATH"
#echo "$(which clang)"
#
#
#rm -rf ~/bazel-bin
#mkdir ~/bazel-bin
#wget -O ~/bazel-bin/bazel https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-$([ $(uname -m) = "aarch64" ] && echo "arm64" || echo "amd64")
#chmod +x ~/bazel-bin/bazel
#export PATH="~/bazel-bin:$PATH"
#
#rm -rf $PWDDIR/out-pgo
#mkdir $PWDDIR/out-pgo
#
#rm -rf $PWDDIR/out-pgo/llvm
#mkdir $PWDDIR/out-pgo/llvm
#cd $PWDDIR/out-pgo/llvm
#cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DLLVM_USE_LINKER=lld -DCMAKE_CXX_FLAGS=-fuse-ld=lld -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="-stdlib=libc++ -Wl,-rpath,$PWDDIR/toolchain/llvm-project/build-release/bin/../lib/x86_64-unknown-linux-gnu/"
#ninja opt
#
#
#rm -rf $PWDDIR/out-pgo/envoy
#mkdir $PWDDIR/out-pgo/envoy
#cd $PWDDIR/test-suites/envoy
#
#bazel build --config=libc++ --copt="-Wno-error=thread-safety-reference-return" --linkopt="-fuse-ld=lld" --copt="-Wno-error=unused-command-line-argument" --copt="-fuse-ld=lld" envoy
#
#mv bazel-out/k8-fastbuild/bin/source/exe/envoy-static $PWDDIR/out-pgo/envoy/
#
rm -rf $PWDDIR/out-pgo/spec2006
mkdir $PWDDIR/out-pgo/spec2006
cd $PWDDIR/out-pgo/spec2006
cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ -DCMAKE_C_COMPILER=$PWDDIR/toolchain/llvm-project/build-release/bin/clang -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_CXX_FLAGS="-stdlib=libc++ -fuse-ld=lld -Wl,-rpath=$PWDDIR/toolchain/llvm-project/build-release/lib/x86_64-unknown-linux-gnu" -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External
ninja
