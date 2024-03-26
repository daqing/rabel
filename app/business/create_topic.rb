class CreateTopic
  def initialize(user, channel, params)
    @user = user
    @channel = channel
    @params = params
  end

  def perform
    @topic = @channel.topics.new(@params)
    @topic.user = @user

    return @topic if @topic.save
  end
end
