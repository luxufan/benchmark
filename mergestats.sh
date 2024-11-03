cp  out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
cp  out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
cp  out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
cp  out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/eth-index_n.cc.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats
cp  out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/447.dealII.stats
cp  out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats
cp  out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/447.dealII.stats
cp  out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/auto_derivative_function.cc.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats
#rm -rf result
#mkdir result

#./statscombiner.py out/envoy/fulllto/envoy-static.stats out/blender/fulllto/blender.stats out/llvm/fulllto/opt.stats out/v8/fulllto/d8.stats out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto/solc.stats out/chromium/fulllto/chrome.stats
#mv result.json result/fulllto.json
#
#./statscombiner.py out/envoy/fulllto-dyncastopt/envoy-static.stats out/blender/fulllto-dyncastopt/blender.stats out/llvm/fulllto-dyncastopt/opt.stats out/v8/fulllto-dyncastopt/v8.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto-dyncastopt/solc.stats test-suites/chromium/chromium/src/out/Default/chrome.stats out/z3/fulllto-dyncastopt/z3.stats
#mv result.json result/candidates.json
#
#./statscombiner.py out/envoy/thinlto/envoy-static.stats out/blender/thinlto/blender.stats out/llvm/thinlto/opt.stats out/v8/thinlto/d8.stats out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto/solc.stats out/chromium/thinlto/chrome.stats
#mv result.json result/thinlto.json
#
#./statscombiner.py out/envoy/thinlto-dyncastopt/envoy-static.stats out/blender/thinlto-dyncastopt/blender.stats out/llvm/thinlto-dyncastopt/opt.stats out/v8/thinlto-dyncastopt/d8.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto-dyncastopt/solc.stats out/chromium/thinlto-dyncastopt/chrome.stats
#mv result.json result/thinlto-dyncastopt.json

#./statscombiner.py out/envoy/fulllto/envoy-static.stats out/blender/fulllto/blender.stats out/llvm/fulllto/opt.stats out/spec2006/fulllto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto/solc.stats out/z3/fulllto/z3.stats out/chromium/chromium/fulllto/chrome.stats out/povray/fulllto/povray.stats  out/v8/fulllto/d8.stats
#mv result.json result/fulllto-with-rtti-clean.json

./statscombiner.py out/envoy/fulllto-dyncastopt/envoy-static.stats out/blender/fulllto-dyncastopt/blender.stats out/llvm/fulllto-dyncastopt/opt.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto-dyncastopt/solc.stats out/z3/fulllto-dyncastopt/z3.stats out/povray/fulllto-dyncastopt/povray.stats out/chromium/fulllto-dyncastopt/chrome.stats out/v8/fulllto-dyncastopt/d8.stats
mv result.json result/fulllto-dyncastopt-type-tree.json


#./statscombiner.py out/envoy/thinlto/envoy-static.stats out/blender/thinlto/blender.stats out/llvm/thinlto/opt.stats out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto/solc.stats out/z3/thinlto/z3.stats out/povray/thinlto/povray.stats out/chromium/thinlto/chrome.stats out/v8/thinlto/d8.stats
#mv result.json result/thinlto-new.json
#
#./statscombiner.py out/envoy/thinlto-dyncastopt/envoy-static.stats out/blender/thinlto-dyncastopt/blender.stats out/llvm/thinlto-dyncastopt/opt.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto-dyncastopt/solc.stats out/z3/thinlto-dyncastopt/z3.stats out/povray/thinlto-dyncastopt/povray.stats out/chromium/thinlto-dyncastopt/chrome.stats out/v8/thinlto-dyncastopt/d8.stats
#mv result.json result/thinlto-dyncastopt-new.json
#./statscombiner.py out/envoy/fulllto-dyncastopt/envoy-static.stats out/blender/fulllto-dyncastopt/blender.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/fulllto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/fulllto-dyncastopt/solc.stats out/z3/fulllto-dyncastopt/z3.stats out/povray/fulllto-dyncastopt/povray.stats 
#mv result.json result/fulllto-dyncastopt-rtti-use.json
#
#./statscombiner.py out/envoy/thinlto/envoy-static.stats out/blender/thinlto/blender.stats out/llvm/thinlto/opt.stats out/spec2006/thinlto/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto/solc.stats out/z3/thinlto/z3.stats out/povray/thinlto/povray.stats
#mv result.json result/thinlto-rtti.json
#
#./statscombiner.py out/envoy/thinlto-dyncastopt/envoy-static.stats out/blender/thinlto-dyncastopt/blender.stats out/llvm/thinlto-dyncastopt/opt.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CINT2006/471.omnetpp/471.omnetpp.stats out/spec2006/thinlto-dyncastopt/External/SPEC/CFP2006/447.dealII/447.dealII.stats out/solidity/thinlto-dyncastopt/solc.stats out/z3/thinlto-dyncastopt/z3.stats out/povray/thinlto-dyncastopt/povray.stats
#mv result.json result/thinlto-dyncastopt-rtti.json
