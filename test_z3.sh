version=(thinlto thinlto-dyncastopt fulllto fulllto-dyncastopt)

for v in "${version[@]}"
do
    echo "$v"
    time { out/z3/$v/z3 test-suites/incremental/QF_BV/20170501-Heizmann-UltimateAutomizer/gcd_1_true-unreach-call_true-no-overflow.i.smt2 > /dev/null; out/z3/$v/z3 test-suites/incremental/QF_BV/2019-Mann/digital-estimation-convergence-bmc-inc_fwd.smt2 > /dev/null; }
done
