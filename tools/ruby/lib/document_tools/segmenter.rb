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
          puts segment_size
          output_set << segment_size
          segment_size = 0
        else
          segment_size = segment_size + 1
        end
      end
      return output_set
    end
  end
end
