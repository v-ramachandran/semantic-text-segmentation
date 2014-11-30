#!/usr/bin/env ruby

require 'optparse'
require_relative './../lib/document_tools/segmenter'

@options = {:file_list => [],
  :segment_delimiter => "^==========$",
  :output_file => "segment_results.csv"}

include Document::Segmenter

def parse_options_from_cmd_line
    OptionParser.new do |opts|
        opts.banner =
        "Usage: generate_segmentation_gold_set.rb [-f] [-d] [-o]

        Generate an output file containing counts of each segment in each file provided
        as input. TODO finish description.
        "

        opts.on( '-f', '--list FILE1,FILE2,FILEN', Array, "List of segmentation data set files." ) do |file_list|
          @options[:file_list] = file_list
        end

        opts.on( '-d', '--delimiter DELIMITER', "Delimiter pattern to determine the end of a segment." ) do |delimiter|
          @options[:segment_delimiter] = delimiter
        end

        opts.on( '-o', '--output OUTPUT', "Specify the name for the output results file." ) do |output_file|
          @options[:output_file] = output_file
        end
    end.parse!
end

def segment_and_output_file_segment_counts

  segment_results = {}
  @options[:file_list].each do |file_name|
    segment_set = segment_document_regions file_name, @options[:segment_delimiter]
    segment_results[file_name] = segment_set
  end

  File.open @options[:output_file], 'w' do |buffer|
    buffer.puts "segment_size,file_name"

    @options[:file_list].each do |file_name|
      segment_results[file_name].each do |segment_size|
        buffer.puts "#{segment_size},#{file_name}"
      end
    end
  end

end

parse_options_from_cmd_line
segment_and_output_file_segment_counts
puts "Finished processing file list and published segment counts"
