mv  out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
mv  out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
mv  out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
mv  out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats

mv  out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/447.dealII.stats
mv  out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats
mv  out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/447.dealII.stats
mv  out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats
rm -rf result
mkdir result

./statscombiner.py out/envoy/fulllto/envoy-static.stats out/blender/fulllto/blender.stats out/llvm/fulllto/opt.stats out/v8/fulllto/d8.stats out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto/solc.stats out/chromium/fulllto/chrome.stats
mv result.json result/fulllto.json

./statscombiner.py out/envoy/fulllto-dyncastopt/envoy-static.stats out/blender/fulllto-dyncastopt/blender.stats out/llvm/fulllto-dyncastopt/opt.stats out/v8/fulllto-dyncastopt/d8.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto-dyncastopt/solc.stats out/chromium/fulllto-dyncastopt/chrome.stats
mv result.json result/fulllto-dyncastopt.json

./statscombiner.py out/envoy/thinlto/envoy-static.stats out/blender/thinlto/blender.stats out/llvm/thinlto/opt.stats out/v8/thinlto/d8.stats out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto/solc.stats out/chromium/thinlto/chrome.stats
mv result.json result/thinlto.json

./statscombiner.py out/envoy/thinlto-dyncastopt/envoy-static.stats out/blender/thinlto-dyncastopt/blender.stats out/llvm/thinlto-dyncastopt/opt.stats out/v8/thinlto-dyncastopt/d8.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto-dyncastopt/solc.stats out/chromium/thinlto-dyncastopt/chrome.stats
mv result.json result/thinlto-dyncastopt.json
