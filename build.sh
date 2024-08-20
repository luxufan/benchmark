BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

# Build llvm project
#cd toolchain/llvm-project
#git checkout remotes/origin/dyncast
#rm -rf build-release
#mkdir build-release
#cd build-release
#
#cmake ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DLLVM_FORCE_ENABLE_STATS=ON -G Ninja
#
#ninja
#
cd $BASEDIR

export PATH="$PWDDIR/toolchain/llvm-project/build-release/bin:$PATH"
echo "$(which clang)"


rm -rf ~/bazel-bin
mkdir ~/bazel-bin
wget -O ~/bazel-bin/bazel https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-$([ $(uname -m) = "aarch64" ] && echo "arm64" || echo "amd64")
chmod +x ~/bazel-bin/bazel
export PATH="~/bazel-bin:$PATH"

mkdir out
rm -rf out/envoy
mkdir out/envoy
rm -rf out/envoy/thinlto-dyncastopt
mkdir out/envoy/thinlto-dyncastopt

cd test-suites/envoy

bazel build --config=libc++ --copt="-Wno-error=thread-safety-reference-return" --linkopt="-fuse-ld=lld" --linkopt="-save-stats=obj" --linkopt="-flto=thin" --linkopt="-Wl,--lto-whole-program-visibility" --copt="-Wno-error=unused-command-line-argument" --copt="-fwhole-program-vtables" --copt="-fuse-ld=lld" --copt="-flto=thin" --copt="-O2" envoy

# To get the statisitcs file
clang++ @bazel-out/k8-fastbuild/bin/source/exe/envoy-static-2.params

mv bazel-out/k8-fastbuild/bin/source/exe/envoy-static $PWDDIR/out/envoy/thinlto-dyncastopt/
mv bazel-out/k8-fastbuild/bin/source/exe/version_linkstamp.stats $PWDDIR/out/envoy/thinlto-dyncastopt/envoy-static.stats

rm -rf $PWDDIR/out/envoy/thinlto
mkdir $PWDDIR/out/envoy/thinlto

cd $PWDDIR/test-suites/envoy
bazel build --config=libc++ --copt="-Wno-error=thread-safety-reference-return" --linkopt="-fuse-ld=lld" --linkopt="-save-stats=obj" --linkopt="-flto=thin" --linkopt="-Wl,--lto-whole-program-visibility" --linkopt="-Wl,--plugin-opt=-enable-dyncastopt=false" --copt="-Wno-error=unused-command-line-argument" --copt="-fwhole-program-vtables" --copt="-fuse-ld=lld" --copt="-flto=thin" --copt="-O2" envoy

clang++ @bazel-out/k8-fastbuild/bin/source/exe/envoy-static-2.params

mv bazel-out/k8-fastbuild/bin/source/exe/envoy-static $PWDDIR/out/envoy/thinlto/
mv bazel-out/k8-fastbuild/bin/source/exe/version_linkstamp.stats $PWDDIR/out/envoy/thinlto/envoy-static.stats

##### Full lto
rm -rf $PWDDIR/out/envoy/fulllto
mkdir $PWDDIR/out/envoy/fulllto

cd $PWDDIR/test-suites/envoy
bazel build --config=libc++ --copt="-Wno-error=thread-safety-reference-return" --linkopt="-fuse-ld=lld" --linkopt="-save-stats=obj" --linkopt="-flto" --linkopt="-Wl,--lto-whole-program-visibility" --linkopt="-Wl,--plugin-opt=-enable-dyncastopt=false" --copt="-Wno-error=unused-command-line-argument" --copt="-fwhole-program-vtables" --copt="-fuse-ld=lld" --copt="-flto" --copt="-O2" envoy

clang++ @bazel-out/k8-fastbuild/bin/source/exe/envoy-static-2.params
mv bazel-out/k8-fastbuild/bin/source/exe/envoy-static $PWDDIR/out/envoy/fulllto/
mv bazel-out/k8-fastbuild/bin/source/exe/version_linkstamp.stats $PWDDIR/out/envoy/fulllto/envoy-static.stats

##### Full lto with dyncastopt
rm -rf $PWDDIR/out/envoy/fulllto-dyncastopt
mkdir $PWDDIR/out/envoy/fulllto-dyncastopt

cd $PWDDIR/test-suites/envoy
bazel build --config=libc++ --copt="-Wno-error=thread-safety-reference-return" --linkopt="-fuse-ld=lld" --linkopt="-save-stats=obj" --linkopt="-flto" --linkopt="-Wl,--lto-whole-program-visibility" --copt="-Wno-error=unused-command-line-argument" --copt="-fwhole-program-vtables" --copt="-fuse-ld=lld" --copt="-flto" --copt="-O2" envoy

clang++ @bazel-out/k8-fastbuild/bin/source/exe/envoy-static-2.params
mv bazel-out/k8-fastbuild/bin/source/exe/envoy-static $PWDDIR/out/envoy/fulllto-dyncastopt/
mv bazel-out/k8-fastbuild/bin/source/exe/version_linkstamp.stats $PWDDIR/out/envoy/fulllto-dyncastopt/envoy-static.stats
#
##### Build blender
rm -rf $PWDDIR/out/blender
mkdir $PWDDIR/out/blender

cd $PWDDIR/test-suites/blender
./build_files/utils/make_update.py --use-linux-libraries

rm -rf $PWDDIR/test-suites/build_linux
CC=$PWDDIR/toolchain/llvm-project/build-release/bin/clang CXX=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++ make

rm -rf $PWDDIR/out/blender/thinlto
mkdir $PWDDIR/out/blender/thinlto
cp $PWDDIR/cmake/blender/thinlto/CMakeCache.txt $PWDDIR/test-suites/build_linux/CMakeCache.txt
make
mv $PWDDIR/test-suites/build_linux/bin/blender $PWDDIR/out/blender/thinlto
mv $PWDDIR/test-suites/build_linux/bin/creator.cc.stats $PWDDIR/out/blender/thinlto/x.stats

rm -rf $PWDDIR/out/blender/thinlto-dyncastopt
mkdir $PWDDIR/out/blender/thinlto-dyncastopt
cp $PWDDIR/cmake/blender/thinlto-dyncastopt/CMakeCache.txt $PWDDIR/test-suites/build_linux/CMakeCache.txt
make
mv $PWDDIR/test-suites/build_linux/bin/blender $PWDDIR/out/blender/thinlto-dyncastopt
mv $PWDDIR/test-suites/build_linux/bin/creator.cc.stats $PWDDIR/out/blender/thinlto-dyncastopt/x.stats

rm -rf $PWDDIR/out/blender/fulllto
mkdir $PWDDIR/out/blender/fulllto
cp $PWDDIR/cmake/blender/fulllto/CMakeCache.txt $PWDDIR/test-suites/build_linux/CMakeCache.txt
make
mv $PWDDIR/test-suites/build_linux/bin/blender $PWDDIR/out/blender/fulllto
mv $PWDDIR/test-suites/build_linux/bin/creator.cc.stats $PWDDIR/out/blender/fulllto/x.stats


rm -rf $PWDDIR/out/blender/fulllto-dyncastopt
mkdir $PWDDIR/out/blender/fulllto-dyncastopt
cp $PWDDIR/cmake/blender/fulllto-dyncastopt/CMakeCache.txt $PWDDIR/test-suites/build_linux/CMakeCache.txt
make
mv $PWDDIR/test-suites/build_linux/bin/blender $PWDDIR/out/blender/fulllto-dyncastopt
mv $PWDDIR/test-suites/build_linux/bin/creator.cc.stats $PWDDIR/out/blender/fulllto-dyncastopt/x.stats
