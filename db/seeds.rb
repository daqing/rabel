def create_dqpub_navlink
  [
    [I18n.t("navlink.dqpub.crypto"), "/crypto"],
    [I18n.t("navlink.dqpub.forex"), "/forex"],
    [I18n.t("navlink.dqpub.gold_silver"), "/gold-silver"],
    [I18n.t("navlink.dqpub.china_a_shares"), "/china-a-shares"],
    [I18n.t("navlink.dqpub.us_stocks"), "/us-stocks"],
    [I18n.t("navlink.dqpub.hk_stocks"), "/hong-kong-stocks"],
    [I18n.t("navlink.dqpub.futures"), "/futures"]
  ].each do |title, url|
    NavLink.create!(title:, url:)
  end
end

# create_dqpub_navlink
