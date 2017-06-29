class HomeSideBlocksQuery
  def get!
    SideBlock.where(on_homepage: true).default_order
  end
end
