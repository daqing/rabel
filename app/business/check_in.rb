class CheckIn
  def self.call(user)
    today = Date.today
    return if CheckedInAtQuery.new(user, today).get!

    @checkin = user.checkins.build(checkin_date: today)
    @checkin.save

    return unless CheckedInAtQuery.new(@user, today.yesterday).get!

    user.increment(:continuous_checkins)
    user.save
  end
end
