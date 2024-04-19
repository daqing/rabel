[
  [I18n.t("navlink.crypto"), "/crypto"],
  [I18n.t("navlink.forex"), "/forex"],
  [I18n.t("navlink.gold_silver"), "/gold-silver"],
  [I18n.t("navlink.china_a_shares"), "/china-a-shares"],
  [I18n.t("navlink.us_stocks"), "/us-stocks"],
  [I18n.t("navlink.hk_stocks"), "/hong-kong-stocks"],
  [I18n.t("navlink.futures"), "/futures"]
].each do |title, url|
  NavLink.create!(title:, url:)
end
