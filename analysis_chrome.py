#!/usr/bin/env python3
#
import json
import argparse

ignore_list = ['AttributeDescendantSelector', 'ClassDescendantSelector', 'ClassInvalidation', 'FocusUpdate', 
               'ModifySelectorText', 'PseudoClassSelectors', 'SelectorCountScaling', 'HasDescendantInvalidation', 'HasDescendantInAncestorPositionInvalidation',
               'HasDescendantInvalidationAllSubjects', 'HasDescendantInvalidationMultipleSubjects', 'HasDescendantInvalidationWith1NonMatchingHasRule',
               'HasDescendantInvalidationWithMultipleNonMatchingHasRules', 'HasDescendantInvalidationWithoutNonMatchingHasRule',
               'CSSPropertySetterGetter', 'CSSPropertySetterGetterMethods', 'CSSPropertyUpdateValue', 'HasInvalidationFiltering',
               'HasSiblingDescendantInvalidation', 'HasSiblingDescendant', 'HasSiblingDescendantInvalidationAllSubjects']
print(len(ignore_list))
sanitize_label = '8363c760-dc08-4752-8045-b3b37079d0e1'
thinlto_dyncastopt_label = '8e254d38-15c2-4c8a-9cf5-44ae459a9820'
thinlto_label = '661ac573-c1c8-4ffd-953c-06aaf4fc768c'
fulllto_dyncastopt_label = 'ab8601e5-60ba-457b-96d4-aa59c2440b58'
fulllto_label = '9feea995-c27a-4672-9c53-f43eebd861ec'

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
            elif label == sanitize_label:
                sanitize_total += avg

    print("thinlto: ", thinlto_total)
    print("thinlto_dyncastopt: ", thinlto_dyncastopt_total)
    print("fulllto: ", fulllto_total)
    print("fulllto_dyncastopt: ", fulllto_dyncastopt_total)
    print("sanitize: ", sanitize_total)
