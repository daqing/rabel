class OtherSideBlocksQuery
  def get!
    SideBlock.where(on_otherpage: true).default_order
  end
end
