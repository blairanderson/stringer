class Story < ActiveRecord::Base
  belongs_to :feed

  has_many :user_stories
  has_many :users, through: :user_stories

  validates_presence_of :feed_id
  validates_uniqueness_of :entry_id, scope: :feed_id

  UNTITLED = "[untitled]"

  def headline
    self.title.nil? ? UNTITLED : strip_html(self.title)[0, 50]
  end

  def lead
    strip_html(self.body)[0,100]
  end

  def source
    self.feed.name
  end

  def pretty_date
    I18n.l(published)
  end

  def strip_html(contents)
    Loofah.fragment(contents).text
  end

  def self.add(entry, feed)
    create({
       feed: feed,
       title: entry.title,
       permalink: entry.url,
       body: extract_content(entry),
       is_read: false,
       is_starred: false,
       published: entry.published || Time.now,
       entry_id: entry.id
    })
  end

  def self.extract_content(entry)
    sanitized_content = ""

    if entry.content
      sanitized_content = sanitize(entry.content)
    elsif entry.summary
      sanitized_content = sanitize(entry.summary)
    end

    expand_absolute_urls(sanitized_content, entry.url)
  end

  def self.sanitize(content)
    Loofah.fragment(content.gsub(/<wbr\s*>/i, ""))
    .scrub!(:prune)
    .scrub!(:unprintable)
    .to_s
  end

  def self.expand_absolute_urls(content, base_url)
    doc = Nokogiri::HTML.fragment(content)
    abs_re = URI::DEFAULT_PARSER.regexp[:ABS_URI]

    [["a", "href"], ["img", "src"], ["video", "src"]].each do |tag, attr|
      doc.css("#{tag}[#{attr}]").each do |node|
        url = node.get_attribute(attr)
        unless url =~ abs_re
          node.set_attribute(attr, URI.join(base_url, url).to_s)
        end
      end
    end

    doc.to_html
  end
end
