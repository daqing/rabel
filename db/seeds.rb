def create_default_navlinks
  [
    ["论坛", "/forum"],
    ["成员", "/people"],
    ["动态", "/feed"],
    ["聊天室", "/chat"],
    ["关于", "/about"]
  ].each do |title, url|
    NavLink.create!(title:, url:)
  end
end

create_default_navlinks
