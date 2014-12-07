require_relative "../math/similarity"
require_relative "topic_cluster_set"

class TopicClusterSet
  include Math::Similarity

  def initialize similarity_method=:cosine_similarity, similarity_threshold=0.05
    @current_cluster = nil
    @cluster_set = []
    @similarity_method = similarity_method
    @similarity_threshold = similarity_threshold
  end

  def add_vector vector
    unless @current_cluster.nil?
      add_vector_to_cluster vector
    else
      @current_cluster = initialize_prototype_cluster vector
    end
  end

  def retrieve_topic_count
    @cluster_set.size + 1
  end

  def retrieve_topic_sequence
    current_label = 1
    topic_sequence = []

    @cluster_set.each do |prototype_cluster|
      add_cluster_label_to_set prototype_cluster[:cluster], current_label, topic_sequence
      current_label = current_label + 1
    end

    add_cluster_label_to_set @current_cluster[:cluster], current_label, topic_sequence

    return topic_sequence
  end

  def retrieve_topic_size_sequence
    size_sequence = []

    @cluster_set.each do |prototype_cluster|
      size_sequence << prototype_cluster[:cluster].size
    end

    return size_sequence
  end

  private

  def initialize_prototype_cluster vector
    return :prototype=> vector, :cluster=> [vector]
  end

  def add_vector_to_cluster vector
    similarity_measure = send @similarity_method, vector, @current_cluster[:prototype]
    if similarity_measure <= @similarity_threshold
      @current_cluster[:cluster] << vector
      @current_cluster[:prototype] = compute_centroid @current_cluster[:cluster]
    else
      @cluster_set << @current_cluster
      @current_cluster = initialize_prototype_cluster vector
    end
  end

  def add_cluster_label_to_set cluster, label, set
    cluster_size = cluster.size
    cluster_size.times do
      set << label
    end
  end
end
