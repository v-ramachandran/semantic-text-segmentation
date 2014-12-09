#!/usr/bin/env python

import os
import sys
from segeval import pk, window_diff

from pandas import read_csv
from fnmatch import fnmatch
from argparse import ArgumentParser

def setup_argument_parser():
    parser = ArgumentParser()
    parser.add_argument("-d", "--directories", nargs="+",
        help="Specify the source directories from which to retrieve files. DEFAULT: '.'",
        default=".")
    parser.add_argument("-r", "--results",
        help="Specify the pattern of the CSV files containing segmentation results. DEFAULT: '*_output_size.csv'",
        default="*_output_size.csv")
    parser.add_argument("-g", "--gold_sets",
        help="Specify the pattern of the CSV files containing the gold set results. DEFAULT: '*.refgold'",
        default="*.refgold")

    return parser.parse_args()

def match(directory,pattern):
    output_files = []
    for file in os.listdir(directory):
        if fnmatch(file, pattern):
            file_path = os.path.join(directory,file)
            output_files.append(file_path)
    return output_files

def retrieve_gold_set_vector(parsed_arguments):
    output_vector = []
    gold_set_files = []
    for directory in parsed_arguments.directories:
        gold_set_files.extend(match(directory, parsed_arguments.gold_sets))
    for file in gold_set_files:
        segment_sizes = read_csv(file).segment_size
        output_vector.extend(segment_sizes)
    return output_vector

def retrieve_result_set_vector(parsed_arguments):
    output_vector = []
    result_set_files = []
    for directory in parsed_arguments.directories:
        result_set_files.extend(match(directory, parsed_arguments.results))
    for file in result_set_files:
        segment_sizes = read_csv(file).segment_size
        output_vector.extend(segment_sizes)
    return output_vector

if __name__ == "__main__":
    parsed_arguments = setup_argument_parser()
    gold_set_values = retrieve_gold_set_vector(parsed_arguments)
    result_set_values = retrieve_result_set_vector(parsed_arguments)

    print "Printing Comparison Statistics:"
    print "P_k value: {}".format(pk(gold_set_values, result_set_values))
    print "WindowDiff value: {}".format(window_diff(gold_set_values, result_set_values))
