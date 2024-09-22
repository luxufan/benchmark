#!/usr/bin/env python3
#
import json
import argparse

ignore_list = ['AttributeDescendantSelector', 'ClassDescendantSelector', 'ClassInvalidation', 'FocusUpdate', 
               'ModifySelectorText', 'PseudoClassSelectors', 'SelectorCountScaling', 'HasDescendantInAncestorPositionInvalidation',
               'HasDescendantInvalidationAllSubjects', 'HasDescendantInvalidationMultipleSubjects', 'HasDescendantInvalidationWith1NonMatchingHasRule',
               'HasDescendantInvalidationWithMultipleNonMatchingHasRules', 'HasDescendantInvalidationWithoutNonMatchingHasRule']

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('file')
    args = parser.parse_args()
    print(args.file)

    f = open(args.file)
    test_data = json.load(f)

    total = 0.0
    for test_case in test_data:
        if test_case['name'] not in ignore_list:
            samples = test_case['sampleValues']
            avg = sum(samples) / len(samples)
            total += avg

    print(total)
