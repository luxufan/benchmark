#!/usr/bin/env python3
#
import json
import argparse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.transforms

ignore_list = ['AttributeDescendantSelector', 'ClassDescendantSelector', 'ClassInvalidation', 'FocusUpdate', 
               'ModifySelectorText', 'PseudoClassSelectors', 'SelectorCountScaling', 'HasDescendantInvalidation', 'HasDescendantInAncestorPositionInvalidation',
               'HasDescendantInvalidationAllSubjects', 'HasDescendantInvalidationMultipleSubjects', 'HasDescendantInvalidationWith1NonMatchingHasRule',
               'HasDescendantInvalidationWithMultipleNonMatchingHasRules', 'HasDescendantInvalidationWithoutNonMatchingHasRule',
               'CSSPropertySetterGetter', 'CSSPropertySetterGetterMethods', 'CSSPropertyUpdateValue', 'HasInvalidationFiltering',
               'HasSiblingDescendantInvalidation', 'HasSiblingDescendant', 'HasSiblingDescendantInvalidationAllSubjects']

origin_labels = set()
thinlto_dyncastopt_labels = set()
sanitize_labels = set()
thinlto_labels = set()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('file')
    args = parser.parse_args()

    f = open(args.file)
    data = json.load(f)

    # find label
    #
    for entry in data:
        if 'type' in entry and entry['type'] == 'GenericSet':
            values = entry['values']
            if values[0] == 'origin':
                origin_labels.add(entry['guid'])
            elif values[0] == 'thinlto':
                thinlto_labels.add(entry['guid'])
            elif values[0] == 'thinlto-dyncastopt':
                thinlto_dyncastopt_labels.add(entry['guid'])
            elif values[0] == 'sanitize':
                sanitize_labels.add(entry['guid'])

    print(thinlto_labels)
    print(thinlto_dyncastopt_labels)
    print(origin_labels)
    print(sanitize_labels)



    thinlto_ms = 0
    thinlto_unitless = 0
    origin_ms = 0
    origin_unitless = 0
    thinlto_dyncastopt_ms = 0
    thinlto_dyncastopt_unitless = 0
    sanitize_ms = 0
    sanitize_unitless = 0

    for entry in data:
        if 'sampleValues' not in entry or 'name' not in entry or 'diagnostics' not in entry:
            continue
        samples_mean = sum(entry['sampleValues']) / len(entry['sampleValues'])
        unit = entry['unit']
        label = entry['diagnostics']['labels']
        if label in thinlto_labels:
            if unit == 'unitless_biggerIsBetter':
                thinlto_unitless += samples_mean
            else:
                thinlto_ms += samples_mean
        elif label in sanitize_labels:
            if unit == 'unitless_biggerIsBetter':
                sanitize_unitless += samples_mean
            else:
                sanitize_ms += samples_mean
        elif label in thinlto_dyncastopt_labels:
            if unit == 'unitless_biggerIsBetter':
                thinlto_dyncastopt_unitless += samples_mean
            else:
                thinlto_dyncastopt_ms += samples_mean
        elif label in origin_labels:
            if unit == 'unitless_biggerIsBetter':
                origin_unitless += samples_mean
            else:
                origin_ms += samples_mean
    origin_ms = origin_ms / 4
    origin_unitless = origin_unitless / 4
    thinlto_ms = thinlto_ms / 4
    thinlto_unitless = thinlto_unitless / 4
    thinlto_dyncastopt_ms = thinlto_dyncastopt_ms / 4
    thinlto_dyncastopt_unitless = thinlto_dyncastopt_unitless / 4
    sanitize_ms = sanitize_ms / 4
    sanitize_unitless = sanitize_unitless / 4

    print('origin_ms:', origin_ms)
    print('origin_unitless:', origin_unitless)
    print('thinlto_ms:', thinlto_ms)
    print('thinlto_unitless:', thinlto_unitless)
    print('thinlto_dyncastopt_ms:', thinlto_dyncastopt_ms)
    print('thinlto_dyncastopt_unitless:', thinlto_dyncastopt_unitless)
    print('sanitize_ms:', sanitize_ms)
    print('sanitize_unitless:', sanitize_unitless)

    width = 0.3
    runtime_tests = [origin_ms, thinlto_dyncastopt_ms, sanitize_ms, thinlto_ms]
    throughput_tests = [origin_unitless, thinlto_dyncastopt_unitless, sanitize_unitless, thinlto_unitless]
    binary_size = [1865495424, 1871746200, 1875745584, 1869047064]
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(12, 4.5))
    fig.subplots_adjust(hspace=0.3, wspace=0.4, bottom=0.2)
    fontsize = 15
    plt.rcParams.update({'font.size': 15})
    x = np.arange(4)

    ax1.set_title("Running time")
    ax1.set_ylim(2800, 3600)
    ax1.bar(['origin', 'dyncast_opt', 'sanitize', 'dyncast'], runtime_tests, width, edgecolor='black', linewidth=1, color='tab:orange')
    ax1.set_xticks(x, ['static_cast', 'dyncast_opt', 'sanitize', 'dyncast'], fontsize=fontsize)
    ax1.set_yticklabels(['{0}'.format(round(x)) for x in ax1.get_yticks()], fontsize=fontsize)
    ax1.set_ylabel('Macroseconds', fontsize=fontsize)
    ax1.tick_params(axis='x', labelrotation=25)
    plt.setp(ax1.xaxis.get_majorticklabels(), rotation=25, ha='right', rotation_mode='anchor', fontsize=17)
    # dx = -25/72.; dy = 0/72.
    # offset = matplotlib.transforms.ScaledTranslation(dx, dy, fig.dpi_scale_trans)
    # for label in ax1.xaxis.get_majorticklabels():
    #     label.set_transform(label.get_transform() + offset)


    plt.rcParams.update({'font.size': 15})
    throughput_tests = [i/1000 for i in throughput_tests]
    ax2.set_title('Throughtput')
    ax2.set_ylim(350, 420)
    print(throughput_tests)
    labels = ['static_cast', 'dyncast_opt', 'sanitize', 'dyncast']
    ax2.bar(labels, throughput_tests, width, edgecolor='darkblue', linewidth=1, color='deepskyblue')
    ax2.set_xticks(x, labels, fontsize=fontsize)
    ax2.set_yticklabels(['{0}'.format(round(x)) for x in ax2.get_yticks()], fontsize=fontsize)
    ax2.set_ylabel('Thousand runs', fontsize=fontsize)
    ax2.tick_params(axis='x', labelrotation=25)
    plt.setp(ax2.xaxis.get_majorticklabels(), rotation=25, ha='right', rotation_mode='anchor', fontsize=17)

    ax3.set_title('Binary size')
    binary_size = [i/(1024 * 1024) for i in binary_size]
    ax3.set_ylim(1750, 1800)
    labels = ['static_cast', 'dyncast_opt', 'sanitize', 'dyncast']
    ax3.bar(labels, binary_size, width, edgecolor='black', linewidth=1, color='dimgrey')
    ax3.set_xticks(x, labels, fontsize=fontsize)
    ax3.set_yticklabels(['{0}'.format(round(x)) for x in ax3.get_yticks()], fontsize=fontsize)
    ax3.set_ylabel('MegaByte', fontsize=fontsize)
    ax3.tick_params(axis='x', labelrotation=25)
    plt.setp(ax3.xaxis.get_majorticklabels(), rotation=25, ha='right', rotation_mode='anchor', fontsize=17)

    plt.savefig("chrome")

    # sanitize_total = 0.0
    # thinlto_total = 0.0
    # thinlto_dyncastopt_total = 0.0
    # fulllto_total = 0.0
    # fulllto_dyncastopt_total = 0.0
    # i = 0
    # for test_case in test_data:
    #     # if i == 0:
    #     print(test_case)
    #     i += 1
    #     # if test_case['name'] not in ignore_list:
    #     #     samples = test_case['sampleValues']
    #     #     label = test_case['diagnostics']['labels']
    #     #     avg = sum(samples) / len(samples)
    #     #     if label == thinlto_label:
    #     #         thinlto_total += avg
    #     #     elif label == thinlto_dyncastopt_label:
    #     #         thinlto_dyncastopt_total += avg
    #     #     elif label == fulllto_label:
    #     #         fulllto_total += avg
    #     #     elif label == fulllto_dyncastopt_label:
    #     #         fulllto_dyncastopt_total += avg
    #     #     elif label == sanitize_label:
    #     #         sanitize_total += avg

    # print("thinlto: ", thinlto_total)
    # print("thinlto_dyncastopt: ", thinlto_dyncastopt_total)
    # print("fulllto: ", fulllto_total)
    # print("fulllto_dyncastopt: ", fulllto_dyncastopt_total)
    # print("sanitize: ", sanitize_total)
