class CheckIn < Fanli::Base
  def initialize(user)
    @user = user
  end

  def perform
    today = Date.today
    return if CheckedInAtQuery.new(@user, today).get!

    @checkin = @user.checkins.build(checkin_date: today)
    @checkin.save

    if CheckedInAtQuery.new(@user, today.yesterday).get!
      @user.increment(:continuous_checkins)
      @user.save
    end
  end
end
