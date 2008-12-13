module ActiveRecord::ConnectionAdapters::SchemaStatements
  def add_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{to_table}"
    execute "alter table #{from_table} add constraint \
      #{constraint_name} foreign key (#{from_column}) references #{to_table}(id)"
  end

  def set_auto_increment(table_name, number)
    execute "ALTER TABLE #{quote_table_name(table_name)} AUTO_INCREMENT=#{number}"
  end

  def load_fixture(fixture, dir = 'test/fixtures')
    require 'active_record/fixtures'
    Fixtures.create_fixtures(dir, fixture)
  end
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :short_jp => '%m月%d日',
  :long_jp => '%Y年%m月%d日'
)
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :short_jp => '%m月%d日 %H時%M分',
  :long_jp => '%Y年%m月%d日 %H時%M分',
  :time_jp => '%H時%M分S秒',
  :hour_and_minuet_jp => '%H時%M分'
)

module ApplicationHelper
  def br(str)
    str.gsub(/\r\n|\r|\n/, '<br />')
  end
 
  def hbr(str)
    str = html_escape(str)
    str.gsub(/\r\n|\r|\n/, '<br />')
  end

  def web_root
    request.protocol+request.host_with_port
  end

  def free_dial?(str)
    /^(0120|0800)/ =~ str ? true : false
  end

  def notice
    content_tag(:div, flash[:notice], :class => 'notice') if flash[:notice]
  end

  def warn
    content_tag(:div, flash[:warn], :class => 'warn') if flash[:warn]
  end

  def focus(element)
    content_tag(:script, "document.getElementById('#{element}').focus()", :type => "text/javascript")
  end

  def meta_description(description)
    "<meta name=\"description\" content=\"#{description}\" />"
  end

  def meta_keywords(keywords)
    "<meta name=\"keywords\" content=\"#{keywords}\" />"
  end

  def habtm_check_box(object, method, target_method, options = {})
    id = object.class.name.downcase
    items = method.to_s.camelize.constantize
    items.all.map do |item|
      label_tag("#{id}_#{method}_#{item.id}",
        check_box_tag("#{id}[#{method}_ids][]",
          item.id,
          object.send(method.to_s.pluralize).include?(item),
          :id => "#{id}_#{method}_#{item.id}")+' '+h(item.send(target_method)),
      :class => 'checkbox')+"\n"
    end.join
  end
end

module ActionView::Helpers::DateHelper
  #
  # ==== Examples
  #   select_date Date.current, :unit => ['年', '月', '日']
  #   # => 2001 年 08 月 11 月
  #
  def select_date(date = Date.current, options = {}, html_options = {})
      options[:order] ||= []
      [:year, :month, :day].each { |o| options[:order].push(o) unless options[:order].include?(o) }

      select_date = ''
      options[:unit] ||= ['', '', '']
      options[:order].each do |o|
        select_date << self.send("select_#{o}", date, options, html_options) + options[:unit].shift
      end
      select_date
  end
end

module ActionView::Helpers::UrlHelper
  #
  # ==== Examples
  #   link_to 'User Logged in', 'login'
  #   # => <a href="login" title="User Logged in">User Logged in</a>
  #
  def link_to_with_title(name, options = {}, html_options = nil)
    html_options = {:title => name} if html_options.nil?
    html_options[:title] = name if html_options[:title].nil?
    link_to_without_title(name, options, html_options)
  end
  alias_method_chain :link_to, :title
end

class String
  def num_char_ref_to_utf8
    self.gsub(/&#(?:(\d*?)|(?:[xX]([0-9a-fA-F]{4})));/) { [$1.nil? ? $2.to_i(16) : $1.to_i].pack('U') }
  end
end
