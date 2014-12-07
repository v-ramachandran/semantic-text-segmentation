require_relative "vector_operations"

module Math
  module Similarity

    include Math::Vector

    ##
    # https://www.bionicspirit.com/blog/2012/01/16/cosine-similarity-euclidean-distance.html
    ##
    def cosine_similarity vector_1, vector_2
      return dot_product(vector_1, vector_2) / (magnitude(vector_1) * magnitude(vector_2))
    end


    def euclidean_similarity vector_1, vector_2
      return magnitude(subtract(vector_1, vector_2))
    end

    def compute_centroid vector_set
      vector_set.transpose.map do |column_vector|
        column_sum = column_vector.inject 0.0 do |sum_so_far, value|
          sum_so_far + value
        end
        column_sum / column_vector.size
      end
    end
  end
end
