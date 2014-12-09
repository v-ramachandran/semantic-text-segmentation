module Document
  module Segmenter

    ##
    # Create a gold set of segmentation results by creating a set of the count
    # of contiguous lines before a delimiter.
    #
    # input_file_name - The name of a file to read lines to be segmented
    # delimiter - A pattern against which a delimiter is checked. A line
    #   is considered a delimiter if the pattern match with a delimiter
    ##
    def segment_document_regions(input_file_name, delimiter, **options)

      delimiter_pattern = Regexp.new delimiter
      output_set = []

      segment_size = 0
      # Skip the first line when reading
      File.readlines(input_file_name).drop(1).each do |line|
        if line =~ delimiter_pattern
          output_set << segment_size
          segment_size = 0
        else
          segment_size = segment_size + 1
        end
      end
      return output_set
    end

    ##
    # Create a set of segmentation results (i.e. sequence of segment sizes)
    # from a sequence of segment labels from an input ffile.
    #
    # input_file_name - The name of a file to read lines that provide segment labels
    # initial_label - The label that begins as the reference point for each label in
    #   the provided file. This is useful if the current input file is a continuation
    #   of another input file.
    # initial_segment_size - The current size of the initial segment label. This is
    #   a useful parameter if the current input file is a continuation of another
    #   input file.
    ##
    def compute_segment_sizes(input_file_name, initial_label=nil, initial_segment_size=0)

      previous_label = initial_label
      segment_size = initial_segment_size
      result_set = []
      File.readlines(input_file_name).each do |line|

        if line == previous_label
          segment_size = segment_size + 1
        else
          result_set << {:size => segment_size, :label => previous_label} unless previous_label.nil?
          segment_size = 1
          previous_label = line
        end
      end
      
      # Add the last group unless the label is nil
      result_set << {:size => segment_size, :label => previous_label} unless previous_label.nil?
      return result_set
    end
  end
end
