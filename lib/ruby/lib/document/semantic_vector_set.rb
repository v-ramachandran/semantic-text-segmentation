require_relative "topic_cluster_set"

class SemanticVectorSet

  def initialize vector_set
    @vector_set = vector_set
  end

  def generate_topic_clusters cluster_method: :cosine_similarity, threshold: 0.05

    topic_cluster_set = TopicClusterSet.new cluster_method, threshold
    @vector_set.each do |vector|
      topic_cluster_set.add_vector vector
    end

    return topic_cluster_set
  end
end
