# encoding: utf-8
module Admin::BaseHelper
  def prepare_resource(resource)
    r = [:admin]
    if resource.is_a? Array
      r += resource
    else
      r << resource
    end
    r
  end

  def admin_create_button(text, resource, options={})
    default_option = {:class => 'btn btn-small'}
    link_to text, new_polymorphic_path(prepare_resource(resource)), default_option.merge(options)
  end

  def admin_edit_button(text, resource, options={})
    default_option = {:class => 'btn btn-small'}
    link_to text, edit_polymorphic_path(prepare_resource(resource)), default_option.merge(options)
  end

  def admin_delete_button(resource, options={})
    default_option = {:class => 'btn btn-small btn-danger', :method => :delete, :data => {:confirm => '真的要删除吗?'}}
    link_to '删除', prepare_resource(resource), default_option.merge(options)
  end

  def dashboard_menu
    [
      {
        :name => '社区管理',
        :items => [
          ['运行状态', 'dashboard', admin_root_path],
          ['基本设置', 'settings', admin_site_settings_path],
          ['外观', 'palette', admin_appearance_path],
          ['用户', 'users', admin_users_path],
          ['位面节点', 'nodes', admin_planes_path],
          ['讨论话题', 'topics', admin_topics_path],
          ['页面', 'pages', admin_pages_path],
          ['广告位', 'ads', admin_advertisements_path],
          ['文件上传', 'cloud', admin_cloud_files_path],
          ['奖励记录', 'reward_history', admin_rewards_path],
        ]
      }
    ]
  end

  def page_publish_status(page)
    content_tag(:span, page.published? ? '已发布' : '草稿', :class => page.published? ? 'published' : 'draft')
  end
end
