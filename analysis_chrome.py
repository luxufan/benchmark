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

lto_origin_labels = set()
lto_dyncastopt_labels = set()
lto_sanitize_labels = set()
lto_labels = set()


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
            if values[0] == 'thin-origin':
                origin_labels.add(entry['guid'])
            elif values[0] == 'thin':
                thinlto_labels.add(entry['guid'])
            elif values[0] == 'thin-dyncastopt':
                thinlto_dyncastopt_labels.add(entry['guid'])
            elif values[0] == 'thin-sanitize':
                sanitize_labels.add(entry['guid'])
            elif values[0] == 'lto-origin':
                lto_origin_labels.add(entry['guid'])
            elif values[0] == 'lto':
                lto_labels.add(entry['guid'])
            elif values[0] == 'lto-dyncastopt':
                lto_dyncastopt_labels.add(entry['guid'])
            elif values[0] == 'lto-sanitize':
                lto_sanitize_labels.add(entry['guid'])


    print(thinlto_labels)
    print(thinlto_dyncastopt_labels)
    print(origin_labels)
    print(sanitize_labels)
    print(lto_labels)
    print(lto_dyncastopt_labels)
    print(lto_origin_labels)
    print(lto_sanitize_labels)



    thinlto_ms = 0
    lto_ms = 0
    thinlto_unitless = 0
    lto_unitless = 0
    origin_ms = 0
    lto_origin_ms = 0
    origin_unitless = 0
    lto_origin_unitless = 0
    thinlto_dyncastopt_ms = 0
    lto_dyncastopt_ms = 0
    thinlto_dyncastopt_unitless = 0
    lto_dyncastopt_unitless = 0
    sanitize_ms = 0
    lto_sanitize_ms = 0
    sanitize_unitless = 0
    lto_sanitize_unitless = 0

    labels = ['dyn cast', 'dyn cast + opt', 'sanitizer']
    names = set()
    for entry in data:
        if 'sampleValues' not in entry or 'name' not in entry or 'diagnostics' not in entry:
            continue
        names.add(entry['name'])
        if entry['name'] == 'CSSQuotesCreate':
            continue
        if entry['name'] == 'ModifySelectorText':
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
        if label in lto_labels:
            if unit == 'unitless_biggerIsBetter':
                lto_unitless += samples_mean
            else:
                lto_ms += samples_mean
        elif label in lto_sanitize_labels:
            if unit == 'unitless_biggerIsBetter':
                lto_sanitize_unitless += samples_mean
            else:
                lto_sanitize_ms += samples_mean
        elif label in lto_dyncastopt_labels:
            if unit == 'unitless_biggerIsBetter':
                lto_dyncastopt_unitless += samples_mean
            else:
                lto_dyncastopt_ms += samples_mean
        elif label in lto_origin_labels:
            if unit == 'unitless_biggerIsBetter':
                lto_origin_unitless += samples_mean
            else:
                lto_origin_ms += samples_mean
    print(len(names))
    count = 6
    origin_ms = origin_ms / count
    origin_unitless = origin_unitless / count
    thinlto_ms = thinlto_ms / count
    thinlto_unitless = thinlto_unitless / count
    thinlto_dyncastopt_ms = thinlto_dyncastopt_ms / count
    thinlto_dyncastopt_unitless = thinlto_dyncastopt_unitless / count
    sanitize_ms = sanitize_ms / count
    sanitize_unitless = sanitize_unitless / count

    lto_origin_ms = lto_origin_ms / count
    lto_origin_unitless = lto_origin_unitless / count
    lto_ms = lto_ms / count
    lto_unitless = lto_unitless / count
    lto_dyncastopt_ms = lto_dyncastopt_ms / count
    lto_dyncastopt_unitless = lto_dyncastopt_unitless / count
    lto_sanitize_ms = lto_sanitize_ms / count
    lto_sanitize_unitless = lto_sanitize_unitless / count

    print('origin_ms:', origin_ms)
    print('origin_unitless:', origin_unitless)
    print('thinlto_ms:', thinlto_ms)
    print('thinlto_unitless:', thinlto_unitless)
    print('thinlto_dyncastopt_ms:', thinlto_dyncastopt_ms)
    print('thinlto_dyncastopt_unitless:', thinlto_dyncastopt_unitless)
    print('sanitize_ms:', sanitize_ms)
    print('sanitize_unitless:', sanitize_unitless)

    print('lto_origin_ms:', lto_origin_ms)
    print('lto_origin_unitless:', lto_origin_unitless)
    print('lto_ms:', lto_ms)
    print('lto_unitless:', lto_unitless)
    print('lto_dyncastopt_ms:', lto_dyncastopt_ms)
    print('lto_dyncastopt_unitless:', lto_dyncastopt_unitless)
    print('lto_sanitize_ms:', lto_sanitize_ms)
    print('lto_sanitize_unitless:', lto_sanitize_unitless)

    width = 0.3
    runtime_tests = [thinlto_ms, thinlto_dyncastopt_ms, sanitize_ms]
    runtime_tests = [(i - origin_ms) / origin_ms * 100 for i in runtime_tests]
    lto_runtime_tests = [lto_ms, lto_dyncastopt_ms, lto_sanitize_ms]
    lto_runtime_tests = [(i - lto_origin_ms) / lto_origin_ms * 100 for i in lto_runtime_tests]
    throughput_tests = [thinlto_unitless, thinlto_dyncastopt_unitless, sanitize_unitless]
    throughput_tests = [(i - origin_unitless) / origin_unitless * 100 for i in throughput_tests]
    print(throughput_tests)
    lto_throughput_tests = [lto_unitless, lto_dyncastopt_unitless, lto_sanitize_unitless]
    lto_throughput_tests = [(i - lto_origin_unitless ) * 100 / lto_origin_unitless for i in lto_throughput_tests]
    print("lto_throught:", lto_throughput_tests)
    binary_size = [1869084448, 1871785016, 1875788704 ]
    binary_size = [(i - 1865538540) / 1865538540 * 100 for i in binary_size]
    lto_binary_size = [1976811312, 1979893688, 1984748792]
    lto_binary_size = [(i - 1985283816) / 1985283826 * 100 for i in lto_binary_size]
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(17, 5))
    fig.subplots_adjust(right=0.8, hspace=0.3, wspace=0.4, bottom=0.26, top=0.82)
    fontsize = 17
    x = np.arange(3)

    thin_bar_color = "tab:orange"
    thin_edge_color = 'black'
    lto_bar_color = 'xkcd:azure'
    lto_edge_color = 'black'

    plt.rcParams.update({'font.size': 17})
    ### ThinLTO running time
    ax1.set_title("Run time overhead")
    #ax1.set_ylim(2000, 2800)
    ax1.bar(x, lto_runtime_tests, width, edgecolor=lto_edge_color, linewidth=1, color=lto_bar_color)
    ax1.bar(x + width, runtime_tests, width, edgecolor=thin_edge_color, linewidth=1, color=thin_bar_color)

    ax1.set_xticks(x + width/2, labels, fontsize=17)
    ax1.set_yticklabels(['{0}%'.format(round(x)) for x in ax1.get_yticks()], fontsize=fontsize)
    #ax1.set_ylabel('Miliseconds', fontsize=fontsize)
    ax1.tick_params(axis='x', labelrotation=25)
    plt.setp(ax1.xaxis.get_majorticklabels(), rotation=15, ha='right', rotation_mode='anchor', fontsize=17)
    # dx = -25/72.; dy = 0/72.
    # offset = matplotlib.transforms.ScaledTranslation(dx, dy, fig.dpi_scale_trans)
    # for label in ax1.xaxis.get_majorticklabels():
    #     label.set_transform(label.get_transform() + offset)

    ### FullLTO running time
    # ax4.set_title("Running time")
    # ax4.set_ylim(2000, 3600)
    # ax4.bar(['origin', 'dyncast_opt', 'sanitize', 'dyncast'], lto_runtime_tests, width, edgecolor='black', linewidth=1, color='tab:orange')
    # ax4.set_xticks(x, ['static_cast', 'dyncast_opt', 'sanitize', 'dyncast'], fontsize=fontsize)
    # ax4.set_yticklabels(['{0}'.format(round(x)) for x in ax1.get_yticks()], fontsize=fontsize)
    # ax4.set_ylabel('Macroseconds', fontsize=fontsize)
    # ax4.tick_params(axis='x', labelrotation=25)
    # plt.setp(ax1.xaxis.get_majorticklabels(), rotation=25, ha='right', rotation_mode='anchor', fontsize=17)

    ax2.set_title('Throughput')
    #ax2.set_ylim(360, 460)
    print(throughput_tests)
    print(lto_throughput_tests)
    print(throughput_tests)
    bars = []
    bar = ax2.bar(x, lto_throughput_tests, width, edgecolor=lto_edge_color, linewidth=1, color=lto_bar_color)
    bars.append(bar)
    bar = ax2.bar(x + width, throughput_tests, width, edgecolor=thin_edge_color, linewidth=1, color=thin_bar_color)
    ax2.set_xticks(x + width/2, labels, fontsize=fontsize)
    bars.append(bar)
    ax2.set_yticklabels(['{0}%'.format(round(x)) for x in ax2.get_yticks()], fontsize=fontsize)
    ax2.tick_params(axis='x', labelrotation=20)
    plt.setp(ax2.xaxis.get_majorticklabels(), rotation=15, ha='right', rotation_mode='anchor', fontsize=17)

    ax3.set_title('Binary size overhead')
    #ax3.set_ylim(1750, 1900)
    ax3.bar(x, lto_binary_size, width, edgecolor=lto_edge_color, linewidth=1, color=lto_bar_color)
    ax3.bar(x + width, binary_size, width, edgecolor=thin_edge_color, linewidth=1, color=thin_bar_color)
    ax3.set_xticks(x + width/2, labels, fontsize=fontsize)
    ax3.set_yticklabels(['{0}%'.format(round(x, 1)) for x in ax3.get_yticks()], fontsize=fontsize)
    #ax3.set_ylabel('MegaByte', fontsize=fontsize)
    ax3.tick_params(axis='x', labelrotation=20)
    ax3.legend(bars, ['LTO', 'ThinLTO'], loc='lower right', ncols=1, fontsize='17', bbox_to_anchor=(1.7, 0.3))
    plt.setp(ax3.xaxis.get_majorticklabels(), rotation=15, ha='right', rotation_mode='anchor', fontsize=17)

    plt.savefig("chrome.pdf")
