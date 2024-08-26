BASEDIR=$(dirname $0)
cd $BASEDIR

PWDDIR=$(pwd)
echo "$PWD"

#$PWDDIR/test-suites/envoy-perf/siege/siege.py $PWDDIR/out-pgo/envoy/envoy-static $PWDDIR/out-pgo/envoy/envoy-static .
$PWDDIR/test-suites/solidity/test/benchmarks/external.sh $PWDDIR/out-pgo/solidity/solc/solc
