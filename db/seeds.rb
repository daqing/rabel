def create_default_navlinks
  [
    ["论坛", "/forum"],
    ["成员", "/people"],
    ["动态", "/feed"],
    ["聊天室", "/chat"],
    ["关于", "/page/about"]
  ].each do |title, url|
    NavLink.create!(title:, url:)
  end
end

create_default_navlinks

Page.create!(key: "about", title: "关于", content: "关于我们的介绍", published: true)
