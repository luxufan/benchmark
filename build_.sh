BASEDIR=$(dirname $0)

cd $BASEDIR

PWDDIR=$(pwd)

CLANG=$PWDDIR/toolchain/llvm-project/build-release/bin/clang
CLANGXX=$PWDDIR/toolchain/llvm-project/build-release/bin/clang++
SPEC2006=/home/tester/spec2006

THIN_OPT_FLAGS='-flto=thin -fwhole-program-vtables -fvisibility=hidden'
THIN_OPT_LDFLAGS='-flto=thin -fuse-ld=lld -save-stats=obj -Wl,--lto-whole-program-visibility'
THIN_FLAGS='-O2 -flto=thin -fwhole-program-vtables -fvisibility=hidden -Wl,--plugin-opt=-enable-dyncastopt=false'
THIN_LDFLAGS='-O2 -flto=thin -fuse-ld=lld -save-stats=obj -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false'

LTO_OPT_FLAGS='-O2 -flto -fwhole-program-vtables -fvisibility=hidden'
LTO_OPT_LDFLAGS='-O2 -flto -fuse-ld=lld -save-stats=obj -Wl,--lto-whole-program-visibility'
LTO_FLAGS='-O2 -flto -fwhole-program-vtables -fvisibility=hidden -Wl,--plugin-opt=-enable-dyncastopt=false'
LTO_LDFLAGS='-O2 -flto -fuse-ld=lld -save-stats=obj -Wl,--lto-whole-program-visibility -Wl,--plugin-opt=-enable-dyncastopt=false'
export PATH="${HOME}/benchmark/test-suites/chromium/depot_tools:$PATH"

if [ $# -eq 0 ]
then 
    echo "fail"
fi

function get_cflags {
    case $1 in 
	thinlto-dyncastopt) 
		echo $THIN_OPT_FLAGS;;
	thinlto)
		echo $THIN_FLAGS;;
	fulllto-dyncastopt)
		echo $LTO_OPT_FLAGS;;
	fulllto)
		echo $LTO_FLAGS;;
	esac
	
}

function get_ldflags {
    case $1 in 
	thinlto-dyncastopt) 
		echo $THIN_OPT_LDFLAGS;;
	thinlto)
		echo $THIN_LDFLAGS;;
	fulllto-dyncastopt)
		echo $LTO_OPT_LDFLAGS;;
	fulllto)
		echo $LTO_LDFLAGS;;
	esac
	
}

function insert_compile_time {
	sed -i "1a \"compile_time\": $1," $2
	sed -i 's/^\"/\t\"/' $2
}

function insert_memory {
	sed -i "1a \"memory\": $1," $2
	sed -i 's/^\"/\t\"/' $2
}

function insert_test_time {
	sed -i "1a \"test_time\": $1," $2
	sed -i 's/^\"/\t\"/' $2
}

function insert_test_memory {
	sed -i "1a \"test_memory\": $1," $2
	sed -i 's/^\"/\t\"/' $2
}
###-------------------------POVRay-----------------------###
#

function build_povray {
    local povray_cflags=$(get_cflags $1)
	local povray_ldflags=$(get_ldflags $1)

    rm -rf $PWDDIR/out/povray/$1
    mkdir $PWDDIR/out/povray/$1
    cd $PWDDIR/test-suites/povray
    make clean
	echo $povray_cflags
	echo $povray_ldflags
    ./configure CC=$CLANG CXX=$CLANGXX CFLAGS="$povray_cflags" CXXFLAGS="$povray_cflags" LDFLAGS="$povray_ldflags"
	/usr/bin/time -v make -j56 2> time.log
	cp unix/povray $PWDDIR/out/povray/$1/povray
	cp unix/disp_sdl.stats $PWDDIR/out/povray/$1/povray.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/povray/$1/povray.stats
	insert_memory $memory $PWDDIR/out/povray/$1/povray.stats
    cd $PWDDIR
}

function test_povray {
	local total_time=0
	local total_memory=0
	for i in {0..4}
	do
		printf '\n' | /usr/bin/time -v $PWDDIR/out/povray/$1/povray --benchmark 2> test.log
		local test_time=$(grep -E "User time .*" test.log | awk '{print $4}')
	  	local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		total_time=$(echo "$total_time + $test_time" | bc)
		total_memory=$(echo "$total_memory + $test_memory" | bc)
	done

	avg_time=$(printf %.3f $(echo "$total_time / 5" | bc -l))
	avg_mem=$(printf %.3f $(echo "$total_memory / 5" | bc -l))

	insert_test_time "$avg_time" $PWDDIR/out/povray/$1/povray.stats
	insert_test_memory "$avg_mem" $PWDDIR/out/povray/$1/povray.stats

}

###-------------------------Solidity---------------------###

function build_solidity {
	local solidity_cflags=$(get_cflags $1)
	local solidity_ldflags=$(get_ldflags $1)
	solidity_ldflags="$solidity_ldflags -Wl,--lto-validate-all-vtables-have-type-infos"

	rm -rf $PWDDIR/out/solidity/$1
	mkdir $PWDDIR/out/solidity/$1
	rm -rf $PWDDIR/out/solidity/temp
	mkdir $PWDDIR/out/solidity/temp
	cd $_
	cmake $PWDDIR/test-suites/solidity -G Ninja -DCMAKE_C_COMPILER=$CLANG -DCMAKE_CXX_COMPILER=$CLANGXX -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="$solidity_cflags" -DCMAKE_EXE_LINKER_FLAGS="$solidity_ldflags" -DUSE_Z3=OFF
	/usr/bin/time -v ninja solc 2> time.log
	mv $PWDDIR/out/solidity/temp/solc/solc $PWDDIR/out/solidity/$1
	mv $PWDDIR/out/solidity/temp/solc/main.cpp.stats $PWDDIR/out/solidity/$1/solc.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/solidity/$1/solc.stats
	insert_memory $memory $PWDDIR/out/solidity/$1/solc.stats
}

function test_solidity {
	local total_time=0
	local total_memory=0
	for i in {0..4}
	do
		local test_file=$PWDDIR/test-suites/solidity/test/benchmarks/external.sh 
		/usr/bin/time -v "$test_file" $PWDDIR/out/solidity/$1/solc > test.log 2>&1
	  	local test_time=$(grep "legacy" test.log | awk '{print $6}' | awk '{total += $1} END {print total}')
	  	local memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		total_time=$(echo "$total_time + $test_time" | bc)
		total_memory=$(echo "$total_memory + $memory" | bc)
	done

	avg_time=$(printf %.3f $(echo "$total_time / 5" | bc -l))
	avg_mem=$(printf %.3f $(echo "$total_memory / 5" | bc -l))

	insert_test_time "$avg_time" $PWDDIR/out/solidity/$1/solc.stats
	insert_test_memory "$avg_mem" $PWDDIR/out/solidity/$1/solc.stats
}


###-------------------------Z3---------------------------###
function build_z3 {
	local z3_cflags=$(get_cflags $1)
	local z3_ldflags=$(get_ldflags $1)
	rm -rf $PWDDIR/out/z3/$1
	mkdir $PWDDIR/out/z3/$1
	rm -rf $PWDDIR/out/z3/temp
	mkdir $PWDDIR/out/z3/temp
	cd $_
	cmake $PWDDIR/test-suites/z3 -G Ninja -DCMAKE_C_COMPILER=$CLANG -DCMAKE_CXX_COMPILER=$CLANGXX -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="$z3_cflags" -DCMAKE_EXE_LINKER_FLAGS="$z3_ldflags"
	/usr/bin/time -v ninja z3 2> time.log
	mv $PWDDIR/out/z3/temp/z3 $PWDDIR/out/z3/$1
	mv $PWDDIR/out/z3/temp/approx_nat.cpp.stats $PWDDIR/out/z3/$1/z3.stats
	local z3_build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local z3_memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $z3_build_time $PWDDIR/out/z3/$1/z3.stats
	insert_memory $z3_memory $PWDDIR/out/z3/$1/z3.stats
}

function test_z3 {
	local total_time=0
	local total_memory=0
	for i in {0..4}
	do
		/usr/bin/time -v $PWDDIR/out/z3/$1/z3 $PWDDIR/test-suites/incremental/QF_BV/20170501-Heizmann-UltimateAutomizer/gcd_1_true-unreach-call_true-no-overflow.i.smt2 > test.log 2>&1
		local test_time=$(grep -E "User time .*" test.log | awk '{print $4}')
	  	local memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		total_time=$(echo "$total_time + $test_time" | bc)
		total_memory=$(echo "$total_memory + $memory" | bc)
	done
	
	local avg_time=$(printf %.3f $(echo "$total_time / 5" | bc -l))
	local avg_mem=$(printf %.3f $(echo "$total_memory / 5" | bc -l))

	insert_test_time "$avg_time" $PWDDIR/out/z3/$1/z3.stats
	insert_test_memory "$avg_mem" $PWDDIR/out/z3/$1/z3.stats
}
	

###--------------------------Envoy-----------------------###
function build_envoy {
	export PATH="$PWDDIR/toolchain/llvm-project/build-release/bin:$PATH"
	export PATH="~/bazel-bin:$PATH"
	local envoy_cflags=$(get_cflags $1)
	local envoy_ldflags=$(get_ldflags $1)
	local cflags="--copt=-Wno-error=thread-safety-reference-return --copt=-Wno-error=unused-command-line-argument --copt=-fuse-ld=lld"
	local ldflags=""
	for i in $envoy_cflags 
	do 
		cflags="$cflags --copt=$i "
	done
	for i in $envoy_ldflags 
	do 
		ldflags="$ldflags --linkopt=$i "
	done

	echo $cflags

	rm -rf $PWDDIR/out/envoy/$1
	mkdir $PWDDIR/out/envoy/$1
	cd $PWDDIR/test-suites/envoy
	bazel clean
	bazel build --config=libc++ $cflags $ldflags envoy
	/usr/bin/time -v clang++ @bazel-out/k8-fastbuild/bin/source/exe/envoy-static-2.params 2> time.log
	mv bazel-out/k8-fastbuild/bin/source/exe/envoy-static $PWDDIR/out/envoy/$1/
	mv bazel-out/k8-fastbuild/bin/source/exe/version_linkstamp.stats $PWDDIR/out/envoy/$1/envoy-static.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/envoy/$1/envoy-static.stats
	insert_memory $memory $PWDDIR/out/envoy/$1/envoy-static.stats
}

function test_envoy {
	cd $PWDDIR/test-suites/envoy-perf/siege
	local binary=$PWDDIR/out/envoy/$1/envoy-static
	local stat=$PWDDIR/out/envoy/$1/envoy-static.stats
	/usr/bin/time -v $PWDDIR/test-suites/envoy-perf/siege/siege.py $binary $binary . > test.log 2>&1  
	local test_time=$(grep "Throughput" test.log | awk '{print $2}')
	local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
	insert_test_time $test_time $stat
	insert_test_memory $test_memory $stat
}

###------------------------Blender-----------------------------###

function build_blender {
	rm -rf $PWDDIR/out/blender/$1
	mkdir $PWDDIR/out/blender/$1
	cd $PWDDIR/test-suites/blender
	./build_files/utils/make_update.py --use-linux-libraries
	local ccachefile=$PWDDIR/test-suites/build_linux/CMakeCache.txt
	if [ ! -f $ccachefile ]
	then 
		rm -rf $PWDDIR/test-suites/build_linux
		CC=$CLANG CXX=$CLANXX make
	fi

	local cflags=$(get_cflags $1)
	local ldflags=$(get_ldflags $1)
	cflags="$cflags $ldflags -Wl,--undefined-version"
	sed -i -E "s/CMAKE_CXX_FLAGS:.*/CMAKE_CXX_FLAGS:STRING=$cflags/" $ccachefile
	sed -i -E "s/CMAKE_C_FLAGS:.*/CMAKE_C_FLAGS:STRING=$cflags/" $ccachefile
	/usr/bin/time -v make 2> time.log
	cp $PWDDIR/test-suites/build_linux/bin/blender $PWDDIR/out/blender/$1
	cp $PWDDIR/test-suites/build_linux/bin/creator.cc.stats $PWDDIR/out/blender/$1/blender.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/blender/$1/blender.stats
	insert_memory $memory $PWDDIR/out/blender/$1/blender.stats
}

function test_blender {
	local stat=$PWDDIR/out/blender/$1/blender.stats
	local binary=$PWDDIR/out/blender/$1/blender
	cp $binary $PWDDIR/test-suites/build_linux/bin/
	cd $PWDDIR/test-suites/blender/tests/performance
	/usr/bin/time -v $PWDDIR/test-suites/blender/tests/performance/benchmark.py run default 2> test.log
	local test_time=$(grep "User time" test.log | awk '{print $4}')
	local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
	insert_test_time $test_time $stat
	insert_test_memory $test_memory $stat
}

###---------------------------spec2006-------------------------###

function build_spec {
	local cflags=$(get_cflags $1)
	local ldflags=$(get_ldflags $1)
	rm -rf $PWDDIR/out/spec2006/$1
	mkdir $PWDDIR/out/spec2006/$1
	cd $_
	cmake $PWDDIR/test-suites/llvm-test-suite -DCMAKE_CXX_COMPILER=$CLANGXX -DCMAKE_C_COMPILER=$CLANG -DTEST_SUITE_SPEC2006_ROOT=/home/tester/spec2006 -DCMAKE_CXX_FLAGS="$cflags" -DCMAKE_C_FLAGS="$cflags" -DCMAKE_EXE_LINKER_FLAGS="$ldflags" -G Ninja -DTEST_SUITE_BENCHMARKING_ONLY=ON -DTEST_SUITE_SUBDIRS=External
	/usr/bin/time -v ninja 471.omnetpp 2> time.log
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/spec2006/$1/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats
	insert_memory $memory $PWDDIR/out/spec2006/$1/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats
	
	/usr/bin/time -v ninja 447.dealII 2> time.log
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/spec2006/$1/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats
	insert_memory $memory $PWDDIR/out/spec2006/$1/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats
}

function test_spec {
	cd $PWDDIR/out/spec2006/$1
	local omn_total_time=0
	local omn_total_memory=0
	for i in {0..4}
	do
		local test_time=$(/usr/bin/time -v $PWDDIR/toolchain/llvm-project/build-release/bin/llvm-lit -v -j 1 External/SPEC/CINT2006/471.omnetpp -o results.json 2> test.log | grep "exec_time" | awk '{print $2}')
		local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		omn_total_time=$(echo "$omn_total_time + $test_time" | bc)
		omn_total_memory=$(echo "$omn_total_memory + $test_memory" | bc)
	done

	local avg_time=$(printf %.3f $(echo "$omn_total_time / 5" | bc -l))
	local avg_mem=$(printf %.3f $(echo "$omn_total_memory / 5" | bc -l))
	insert_test_time $avg_time $PWDDIR/out/spec2006/$1/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats
	insert_memory $avg_mem $PWDDIR/out/spec2006/$1/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats

	local deal_total_time=0
	local deal_total_memory=0
	for i in {0..4}
	do
		local test_time=$(/usr/bin/time -v $PWDDIR/toolchain/llvm-project/build-release/bin/llvm-lit -v -j 1 External/SPEC/CFP2006/447.dealII -o results.json 2> test.log | grep "exec_time" | awk '{print $2}')
		local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		deal_total_time=$(echo "$deal_total_time + $test_time" | bc)
		deal_total_memory=$(echo "$deal_total_memory + $test_memory" | bc)
	done

	local avg_time=$(printf %.3f $(echo "$deal_total_time / 5" | bc -l))
	local avg_mem=$(printf %.3f $(echo "$deal_total_memory / 5" | bc -l))
	insert_test_time $avg_time $PWDDIR/out/spec2006/$1/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats
	insert_test_memory $avg_mem $PWDDIR/out/spec2006/$1/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats
}

###---------------------------llvm-----------------------------###
function build_llvm {
	local cflags=$(get_cflags $1)
	local ldflags=$(get_ldflags $1)
	rm -rf $PWDDIR/out/llvm/$1
	mkdir $PWDDIR/out/llvm/$1
	rm -rf $PWDDIR/out/llvm/temp
	mkdir $PWDDIR/out/llvm/temp
	cd $_
	local flags="$cflags $ldflags"
	cmake $PWDDIR/test-suites/llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$CLANGXX -DCMAKE_C_COMPILER=$CLANG -G Ninja -DLLVM_ENABLE_RTTI=ON -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_CXX_FLAGS="$flags" -DCMAKE_C_FLAGS="$flags" 
	/usr/bin/time -v ninja opt 2> time.log
	cp $PWDDIR/out/llvm/temp/bin/opt $PWDDIR/out/llvm/$1
	cp $PWDDIR/out/llvm/temp/bin/NewPMDriver.cpp.stats $PWDDIR/out/llvm/$1/opt.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/llvm/$1/opt.stats
	insert_memory $memory $PWDDIR/out/llvm/$1/opt.stats
}

###-----------------------------v8-------------------------###
function build_v8 {
    rm -rf $PWDDIR/out/v8/$1
	mkdir $PWDDIR/out/v8/$1
	cd $PWDDIR/test-suites/v8/v8
	rm -rf out/default
	gn gen out/default
	cd $PWDDIR/test-suites/v8/v8/build
	git reset --hard HEAD
	git apply $PWDDIR/cmake/v8/$1.patch
	cd $PWDDIR/test-suites/v8/v8
	cp $PWDDIR/cmake/chromium/lto-O2.gn out/default/args.gn
	/usr/bin/time -v autoninja -C out/default d8 2> time.log
	cp out/default/d8 $PWDDIR/out/v8/$1
	cp out/default/snapshot_blob.bin $PWDDIR/out/v8/$1
	cp out/default/embedded-empty.stats $PWDDIR/out/v8/$1/d8.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/v8/$1/d8.stats
	insert_memory $memory $PWDDIR/out/v8/$1/d8.stats
}

function test_v8 {
	export PATH="${HOME}/benchmark/test-suites/chromium/depot_tools:$PATH"
	source ~/.venv/bin/activate
	local total_time=0
	local total_memory=0
	for i in {0..4}
	do
		/usr/bin/time -v $PWDDIR/test-suites/v8/v8/test/benchmarks/csuite/csuite.py sunspider baseline $PWDDIR/out/v8/$1/d8 2> test.log
		local test_time=$(grep -E "User time .*" test.log | awk '{print $4}')
	  	local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		total_time=$(echo "$total_time + $test_time" | bc)
		total_memory=$(echo "$total_memory + $test_memory" | bc)
	done
	
	local avg_time=$(printf %.3f $(echo "$total_time / 5" | bc -l))
	local avg_mem=$(printf %.3f $(echo "$total_memory / 5" | bc -l))

	insert_test_time "$avg_time" $PWDDIR/out/v8/$1/d8.stats
	insert_test_memory "$avg_mem" $PWDDIR/out/v8/$1/d8.stats
}

###-------------------------chrome-------------------------###

function build_chrome {
	rm -rf $PWDDIR/out/chromium/$1
	mkdir $PWDDIR/out/chromium/$1
	cd $PWDDIR/test-suites/chromium/chromium/src
	git reset --hard HEAD
	rm -rf out/$1
	gn gen out/$1
	git apply $PWDDIR/cmake/chromium/$1.patch
	cp $PWDDIR/cmake/chromium/args.gn out/$1/args.gn
	/usr/bin/time -v autoninja -C out/$1 chrome 2> time.log
	cp out/$1/chrome $PWDDIR/out/chromium/$1
	cp out/$1/chrome_exe_main_aura.stats $PWDDIR/out/chromium/$1/chrome.stats
	local build_time=$(grep -E "User time .*" time.log | awk '{print $4}')
	local memory=$(grep "Maximum resident set" time.log | awk '{print $6}')
	insert_compile_time $build_time $PWDDIR/out/chromium/$1/chrome.stats
	insert_memory $memory $PWDDIR/out/chromium/$1/chrome.stats
}

function test_chrome {
	export PATH="${HOME}/benchmark/test-suites/chromium/depot_tools:$PATH"
	local total_time=0
	local total_memory=0
	for i in {0..4}
	do
		/usr/bin/time -v xvfb-run -s "-screen 0 1024x768x24" $PWDDIR/test-suites/chromium/chromium/src/tools/perf/run_benchmark blink_perf.css --browser=exact --browser-executable=$PWDDIR/test-suites/chromium/chromium/src/out/$1/chrome --extra-browser-args="--no-sandbox --disable-dev-shm-usage --disable-gpu" --results-label="$1" 2> test.log
		local test_time=$(grep -E "User time .*" test.log | awk '{print $4}')
	  	local test_memory=$(grep "Maximum resident set" test.log | awk '{print $6}')
		total_time=$(echo "$total_time + $test_time" | bc)
		total_memory=$(echo "$total_memory + $test_memory" | bc)
	done
	
	local avg_time=$(printf %.3f $(echo "$total_time / 5" | bc -l))
	local avg_mem=$(printf %.3f $(echo "$total_memory / 5" | bc -l))

	insert_test_time "$avg_time" $PWDDIR/out/chromium/$1/chrome.stats
	insert_test_memory "$avg_mem" $PWDDIR/out/chromium/$1/chrome.stats
}

benchmark_to_build=()
version_to_build=()
while [ -n "$1" ]
do
    case $1 in
		-b=*|--benchmark=*)
		case "${1#*=}" in
		all)
			benchmark_to_build+=('z3')
			benchmark_to_build+=('solidity')
			benchmark_to_build+=('povray')
			benchmark_to_build+=('envoy')
			benchmark_to_build+=('blender')
			benchmark_to_build+=('llvm')
			benchmark_to_build+=('v8')
			benchmark_to_build+=('spec2006')
			benchmark_to_build+=('chrome');;
		*)
			benchmark_to_build+=("${1#*=}");;
		esac
		shift;;
		-v=*|--version=*)
		case "${1#*=}" in
		all)
			version_to_build+=('thinlto')
			version_to_build+=('thinlto-dyncastopt')
			version_to_build+=('fulllto-dyncastopt')
			version_to_build+=('fulllto');;
		lto)
			version_to_build+=("fulllto");;
		lto-opt)
			version_to_build+=("fulllto-dyncastopt");;
		thin)
			version_to_build+=("thinlto");;
		thin-opt)
			version_to_build+=("thinlto-dyncastopt");;
		esac
		shift;;
		-*|--*)
		echo "Unknown options!"
		echo "Usage:"
		echo "    -b or --benchmark, the valid values are envoy|povray|solidity|z3|blender|spec2006"
		echo "    -v or --version, the valid version are lto|lto-opt|thin|thin-opt"
		exit 1
	esac
done

for benchmark in "${benchmark_to_build[@]}"
do
	case $benchmark in
		povray)
		for version in "${version_to_build[@]}"
		do 
			build_povray $version
			test_povray $version
		done;;
		solidity)
		for version in "${version_to_build[@]}"
		do
			build_solidity $version
			test_solidity $version
		done;;
		z3)
		for version in "${version_to_build[@]}"
		do
			build_z3 $version
			test_z3 $version
		done;;
		envoy)
		for version in "${version_to_build[@]}"
		do
			build_envoy $version
			test_envoy $version
		done;;
		blender)
		for version in "${version_to_build[@]}"
		do
			build_blender $version
			test_blender $version
		done;;
		spec2006)
		for version in "${version_to_build[@]}"
		do
			build_spec $version
			test_spec $version
		done;;
		llvm)
		for version in "${version_to_build[@]}"
		do 
			build_llvm $version
		done;;
		v8)
		for version in "${version_to_build[@]}"
		do
			build_v8 $version
			test_v8 $version
		done;;
		chrome)
		for version in "${version_to_build[@]}"
		do
			build_chrome $version
			test_chrome $version
		done;;
	esac
done
