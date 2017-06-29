class NextTopicQuery
  def initialize(channel, topic)
    @channel = channel
    @topic = topic
  end

  def get!
    @channel.topics.where("id > ?", @topic.id).order('created_at ASC').first
  end
end
