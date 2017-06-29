class StickyTopicsQuery
  def get!(n)
    Topic.where(sticky: true).order('updated_at DESC').limit(n)
  end
end
