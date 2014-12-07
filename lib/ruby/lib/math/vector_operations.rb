module Math
  module Vector

    def subtract vector_1, vector_2
      vector_1.zip(vector_2).map do |element_1, element_2|
        element_1 - element_2
      end
    end

    def dot_product vector_1, vector_2
      products = vector_1.zip(vector_2).map do |element_1, element_2|
        element_1 * element_2
      end
      products.inject 0 do |sum_so_far, value|
        sum_so_far + value
      end
    end

    def magnitude vector
      squares = vector.map do |x|
        x ** 2
      end
      sum_squares = squares.inject 0 do |sum_so_far, value|
        sum_so_far + value
      end
      Math.sqrt sum_squares
    end
  end
end
