#!/usr/bin/env python3
#
import json
import sys
import os.path
import argparse

def create_init_benchmark_json():
    stats = {}
    stats["__version__"] = [18, 0, 0]
    stats["elapsed"] = 0.0
    stats["tests"] = []
    return stats

def combine_stats(stats, bench_result):
    all_tests = bench_result["tests"]

    binary_name = stats[stats.rfind('/') + 1:-6]
    binary_path = os.path.dirname(stats) + "/" + binary_name
    new_stats_dict = {"code": "PASS", "elapsed" : 0.0, "metrics" : {}, "name": binary_name, "output": ""}

    metrics = new_stats_dict["metrics"]
    metrics["exec_time"] = 0.0
    metrics["size"] = os.path.getsize(binary_path)
    with open(stats) as json_data:
        d = json.load(json_data)
        for metric in d:
            metrics[metric] = d[metric]

    all_tests.append(new_stats_dict)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('filenames', nargs='+')
    args = parser.parse_args()

    print(args.filenames)

    for f in args.filenames:
        file = open(f, "r")
        result_dict = json.load(file)
        for test in result_dict["tests"]:
            test["shortname"] = test["name"]
        file = open(f, "w")
        json.dump(result_dict, file, indent = 4)
