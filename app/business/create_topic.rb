class CreateTopic
  def self.call(user, channel, params)
    @topic = channel.topics.new(params)
    @topic.user = user

    @topic if @topic.save
  end
end
