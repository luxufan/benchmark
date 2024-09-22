#!/usr/bin/env python3
#
import json
import argparse

ignore_list = ['AttributeDescendantSelector', 'ClassDescendantSelector', 'ClassInvalidation', 'FocusUpdate', 
               'ModifySelectorText', 'PseudoClassSelectors', 'SelectorCountScaling', 'HasDescendantInAncestorPositionInvalidation',
               'HasDescendantInvalidationAllSubjects', 'HasDescendantInvalidationMultipleSubjects', 'HasDescendantInvalidationWith1NonMatchingHasRule',
               'HasDescendantInvalidationWithMultipleNonMatchingHasRules', 'HasDescendantInvalidationWithoutNonMatchingHasRule']

sanitize_label = 'f7dcc881-4cbe-4117-b5b2-92f2281de43a'
thinlto_dyncastopt_label = '81618fec-9c2e-4156-90e2-ce9c10294559'
thinlto_label = 'fbefeb5f-3a94-412f-939a-f1818c497190'
fulllto_dyncastopt_label = '8ea7ead0-4846-4008-ac40-091f26b9c0c1'
fulllto_label = '8e5b0ead-4d81-4680-ba28-db407412efec'

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('file')
    args = parser.parse_args()
    print(args.file)

    f = open(args.file)
    test_data = json.load(f)

    sanitize_total = 0.0
    thinlto_total = 0.0
    thinlto_dyncastopt_total = 0.0
    fulllto_total = 0.0
    fulllto_dyncastopt_total = 0.0
    for test_case in test_data:
        if test_case['name'] not in ignore_list:
            samples = test_case['sampleValues']
            print(test_case)
            label = test_case['diagnostics']['labels']
            avg = sum(samples) / len(samples)
            if label == thinlto_label:
                thinlto_total += avg
            elif label == thinlto_dyncastopt_label:
                thinlto_dyncastopt_total += avg
            elif label == fulllto_label:
                fulllto_total += avg
            elif label == fulllto_dyncastopt_label:
                fulllto_dyncastopt_total += avg

    print("thinlto: ", thinlto_total)
    print("thinlto_dyncastopt: ", thinlto_dyncastopt_total)
    print("fulllto: ", fulllto_total)
    print("fulllto_dyncastopt: ", fulllto_dyncastopt_total)
