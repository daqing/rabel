class HomeTopicsQuery
  def get!(n)
    Topic.where(sticky: false).order('involved_at DESC').limit(n)
  end
end
