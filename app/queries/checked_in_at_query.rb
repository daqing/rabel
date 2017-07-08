class CheckedInAtQuery
  def initialize(user, date)
    @user = user
    @date = date
  end

  def get!
    @user.checkins.where(checkin_date: @date).exists?
  end
end
