#!/usr/bin/env python

from sentence2vec.word2vec import Word2Vec, Sent2Vec, LineSentence
from argparse import ArgumentParser
import sys

def setup_argument_parser():
    parser = ArgumentParser()
    parser.add_argument("-i", "--input_files",
        help="Specify the sentence file name pattern. DEFAULT: '*.ref'",
        default="*.ref")
    parser.add_argument("-d", "--directory",
        help="Specify the source directory from which to retrieve files. DEFAULT: '.'",
        default=".")
    parser.add_argument("-s", "--size", type=int,
        help="Specify the size of the sentence vector. DEFAULT: 100",
        default=100)
    parser.add_argument("-w", "--window", type=int,
        help="Specify the window size for the word vector. DEFAULT: 5",
        default=5)
    return parser.parse_args()

def find_files(directory, pattern):
    output_files = []
    for file in os.listdir(directory):
        if fnmatch(file, pattern):
            file_path = os.path.join(directory,file)
            output_files.append(file_path)
    return output_files

##
# Derived from the demo.py file in sentence2vector codebase
##
def create_and_output_sentence_vectors(input_file, window, size):

    model = Word2Vec(LineSentence(input_file), size=size,
        window=window, sg=0, min_count=5, workers=8)
    model.save(input_file + '.w.model')
    model.save_word2vec_format(input_file + '.w.vec')
    
    model = Sent2Vec(LineSentence(input_file), model_file=input_file + '.w.model')
    model.save_sent2vec_format(input_file + '.s.vec')

if __name__ == "__main__":
    parsed_arguments = setup_argument_parser()
    sentence_files = find_files(parsed_arguments.directory, parsed_arguments.input_files)
    window = argument_parser.window
    size = argument_parser.size
    for sentence_file in sentence_files:
        create_and_output_sentence_vectors(sentence_file)
        print "Created sentence vectors for file {}".format(sentence_file)
