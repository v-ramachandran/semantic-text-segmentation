#!/usr/bin/env ruby

require 'optparse'
require_relative './../lib/document_tools/segmenter'

@options = {:file_list => [],
  :output_file => "segment_size_results.csv"}

include Document::Segmenter

def parse_options_from_cmd_line
    OptionParser.new do |opts|
        opts.banner =
        "Usage: count_segmentation_sizes.rb [-f] [-o]

        Generate an output file containing counts of each segment label in each file provided
        as input. TODO finish description.
        "

        opts.on( '-f', '--list FILE1,FILE2,FILEN', Array, "List of segmentation data set files." ) do |file_list|
          @options[:file_list] = file_list
        end

        opts.on( '-o', '--output OUTPUT', "Specify the name for the output results file." ) do |output_file|
          @options[:output_file] = output_file
        end
    end.parse!
end

def output_segment_counts_to_file

  segment_sizes = []
  previous_label = nil
  segment_size = 0
  @options[:file_list].each do |file_name|

    unless segment_sizes.empty?
      last_segment = segment_sizes.pop
      previous_label = last_segment[:label]
      segment_size = last_segment[:size]
    end
    intermediate_segment_sizes = compute_segment_sizes file_name, previous_label, segment_size
    segment_sizes.concat intermediate_segment_sizes
  end

  File.open @options[:output_file], 'w' do |buffer|
    buffer.puts "segment_size,label"

    segment_sizes.each do |segment_size|
      buffer.puts "#{segment_size[:size]},#{segment_size[:label]}"
    end
  end
end

parse_options_from_cmd_line
output_segment_counts_to_file
puts "Finished processing file list and published segment counts"
