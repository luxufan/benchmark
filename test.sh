BASEDIR=$(dirname $0)
cd $BASEDIR
PWDDIR=$(pwd)

# Test envoy
rm -rf test-result
mkdir test-result

rm -rf test-result/thinlto
mkdir test-result/thinlto
$PWDDIR/test-suites/envoy-perf/siege/siege.py $PWDDIR/out/envoy/thinlto-dyncastopt/envoy-static $PWDDIR/out/envoy/thinlto-dyncastopt/envoy-static $PWDDIR/test-result
rm -rf test-result/fulllto
mkdir test-result/fulllto
$PWDDIR/test-suites/envoy-perf/siege/siege.py $PWDDIR/out/envoy/fulllto/envoy-static $PWDDIR/out/envoy/fulllto-dyncastopt/envoy-static $PWDDIR/test-result

# Test 


