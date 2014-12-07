#!/usr/bin/env ruby

require 'optparse'
require_relative './../lib/document/semantic_vector_set'

@options = {:output_file => "topic_clusters", :similarity_method=> :cosine_similarity,
            :similarity_threshold => 0.05}

def parse_options_from_cmd_line
    OptionParser.new do |opts|
        opts.banner =
        "Usage: generate_sentence_clusters.rb -f [-o] [-m] [-t]

        Generate an output file containing the cluster labels of a given set of files
        that contain sentence vectors.

        The following constraints exist:

        * The available methods that can be specifed with -m are:
          - cosine_similarity
          - euclidean_similarity

        * Similarity thresholds specified using -t must be greater than 0.0.

        The following default values exist:

        * -t threshold = 0.05
        * -m method = cosine_similarity
        * -o output = topic_clusters
        "

        opts.on( '-m', '-method METHOD', "Specify the similarity method to be used
          for comparing vectors") do |method|

          @options[:similarity_method] = method.to_sym
        end

        opts.on( '-t', '-threshold THRESHOLD', "Specify the threshold which determines
          how close two vectors must be in terms of similarity.") do |threshold|

          @options[:similarity_threshold] = threshold.to_f
        end

        opts.on( '-f', '--list FILE1,FILE2,FILEN', Array, "List of sentence vector files." ) do |file_list|
          @options[:file_list] = file_list
        end

        opts.on( '-o', '--output OUTPUT', "Specify the name for the output results file." ) do |output_file|
          @options[:output_file] = output_file
        end
    end.parse!
end

def construct_sentence_vector_set
  output_set = []
  @options[:file_list].each do |file_name|
    File.open(file_name).readlines.drop(1).each do |line|
      sentence_vector_with_label = line.split "\s"
      sentence_vector = sentence_vector_with_label.drop(1).map do |element|
        element.to_f
      end
      output_set << sentence_vector
    end
  end

  return output_set
end

def output_topic_clusters sentence_vector_set
  semantic_vector_set = SemanticVectorSet.new sentence_vector_set
  topic_clusters = semantic_vector_set.generate_topic_clusters

  File.open @options[:output_file], 'w' do |buffer|
    buffer.puts topic_clusters.retrieve_topic_sequence
  end
end

parse_options_from_cmd_line
sentence_vector_set = construct_sentence_vector_set
output_topic_clusters sentence_vector_set
