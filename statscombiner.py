#!/usr/bin/env python3
#
import json
import sys

def create_init_benchmark_json():
    stats = {}
    stats["__version__"] = [18, 0, 0]
    stats["elapsed"] = 0.0
    stats["tests"] = []
    return stats

def combine_stats(stats, bench_result):
    all_tests = bench_result["tests"]

    binary_name = stats[:-5]
    new_stats_dict = {"code": "PASS", "elapsed" : 0.0, "metrics" : {}, "name": binary_name, "output": ""}

    metrics = new_stats_dict["metrics"]
    metrics["exec_time"] = 0.0
    with open(stats) as json_data:
        d = json.load(json_data)
        for metric in d:
            metrics[metric] = d[metric]

    all_tests.append(new_stats_dict)

if __name__ == "__main__":
    result_dict = create_init_benchmark_json()

    for i in range(1, len(sys.argv)):
        combine_stats(sys.argv[i], result_dict)

    with open('result.json', 'w') as f:
        json.dump(result_dict, f, indent=4)
