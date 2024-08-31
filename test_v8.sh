test-suites/v8/v8/test/benchmarks/csuite/csuite.py sunspider baseline out/v8/fulllto/d8
test-suites/v8/v8/test/benchmarks/csuite/csuite.py sunspider compare out/v8/fulllto-dyncastopt/d8

test-suites/v8/v8/test/benchmarks/csuite/csuite.py sunspider baseline out/v8/thinlto/d8
test-suites/v8/v8/test/benchmarks/csuite/csuite.py sunspider compare out/v8/thinlto-dyncastopt/d8

test-suites/v8/v8/test/benchmarks/csuite/csuite.py -r 10 octane baseline out/v8/fulllto/d8
test-suites/v8/v8/test/benchmarks/csuite/csuite.py -r 10 octane compare out/v8/fulllto-dyncastopt/d8

test-suites/v8/v8/test/benchmarks/csuite/csuite.py -r 10 octane baseline out/v8/thinlto/d8
test-suites/v8/v8/test/benchmarks/csuite/csuite.py -r 10 octane compare out/v8/thinlto-dyncastopt/d8
