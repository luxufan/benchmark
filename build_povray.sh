BASEDIR=$(dirname $0)                                                                                                                                                        
cd $BASEDIR                                                                                                                                                                  
                                                                                                                                                                             
PWDDIR=$(pwd)                                                                                                                                                                
echo "$PWD" 

#rm -rf out/povray
#mkdir out/povray

rm -rf $PWDDIR/out/povray/thinlto-dyncastopt
mkdir $PWDDIR/out/povray/thinlto-dyncastopt

cd $PWDDIR/test-suites/povray

make clean
./configure CC=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang CXX=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang++ CFLAGS="-fuse-ld=lld -fwhole-program-vtables -flto=thin -fvisibility=hidden" CXXFLAGS="-fvisibility=hidden -fwhole-program-vtables -fuse-ld=lld -flto=thin" LDFLAGS="-save-stats=obj -Wl,--lto-whole-program-visibility"
make -j56

mv unix/povray $PWDDIR/out/povray/thinlto-dyncastopt/povray
mv unix/disp_sdl.stats $PWDDIR/out/povray/thinlto-dyncastopt/povray.stats
#
rm -rf $PWDDIR/out/povray/thinlto
mkdir $PWDDIR/out/povray/thinlto

cd $PWDDIR/test-suites/povray
make clean

./configure CC=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang CXX=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang++ CFLAGS="-fuse-ld=lld -flto=thin -fvisibility=hidden -fwhole-program-vtables" CXXFLAGS="-fvisibility=hidden -fwhole-program-vtables -fuse-ld=lld -flto=thin" LDFLAGS="-save-stats=obj -Wl,--lto-whole-program-visibility -Wl,-plugin-opt=-enable-dyncastopt=false"
make -j56
mv unix/povray $PWDDIR/out/povray/thinlto/povray
mv unix/disp_sdl.stats $PWDDIR/out/povray/thinlto/povray.stats

rm -rf $PWDDIR/out/povray/fulllto-dyncastopt
mkdir $PWDDIR/out/povray/fulllto-dyncastopt

cd $PWDDIR/test-suites/povray

make clean
./configure CC=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang CXX=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang++ CFLAGS="-fuse-ld=lld -fwhole-program-vtables -fvisibility=hidden  -flto" CXXFLAGS="-fwhole-program-vtables -fvisibility=hidden -fuse-ld=lld -flto" LDFLAGS="-save-stats=obj -Wl,--lto-whole-program-visibility"
make -j56

mv unix/povray $PWDDIR/out/povray/fulllto-dyncastopt/povray
mv unix/disp_sdl.stats $PWDDIR/out/povray/fulllto-dyncastopt/povray.stats

rm -rf $PWDDIR/out/povray/fulllto
mkdir $PWDDIR/out/povray/fulllto

cd $PWDDIR/test-suites/povray
make clean

./configure CC=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang CXX=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang++ CFLAGS="-fuse-ld=lld -flto -fvisibility=hidden -fwhole-program-vtables" CXXFLAGS="-fwhole-program-vtables -fvisibility=hidden -fuse-ld=lld -flto" LDFLAGS="-save-stats=obj -Wl,--lto-whole-program-visibility -Wl,-plugin-opt=-enable-dyncastopt=false"
make -j56
mv unix/povray $PWDDIR/out/povray/fulllto/povray
mv unix/disp_sdl.stats $PWDDIR/out/povray/fulllto/povray.stats
#
#rm -rf $PWDDIR/out/povray/pgo
#mkdir $PWDDIR/out/povray/pgo
#
#cd $PWDDIR/test-suites/povray
#make clean
#
#./configure CC=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang CXX=/home/tester/benchmark/toolchain/llvm-project/build-release/bin/clang++ CFLAGS="-fuse-ld=lld -flto=thin -fvisibility=hidden -fwhole-program-vtables" CXXFLAGS="-fvisibility=hidden -fwhole-program-vtables -fuse-ld=lld -flto=thin ~/benchmark/toolchain/llvm-project/build-release/lib/clang/18/lib/x86_64-unknown-linux-gnu/libclang_rt.profile.a " LDFLAGS="~/benchmark/toolchain/llvm-project/build-release/lib/clang/18/lib/x86_64-unknown-linux-gnu/libclang_rt.profile.a -save-stats=obj -Wl,--lto-whole-program-visibility -Wl,-plugin-opt=-enable-dyncastopt=false"
#make -j56
#mv unix/povray $PWDDIR/out/povray/pgo/povray
