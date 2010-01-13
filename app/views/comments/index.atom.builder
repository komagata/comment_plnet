atom_feed(
  :language => 'ja-JP',
  'xmlns:app' => 'http://www.w3.org/2007/app',
  'xmlns:openSearch' => 'http://a9.com/-/spec/opensearch/1.1/'
) do |feed|
  feed.title(@title)
  feed.updated(@comments.first.updated_at)

  @comments.each do |c|
    feed.entry(c) do |entry|
      entry.title("#{c.name}のコメント")
      entry.content(c.body, :type => "html")
      entry.author do |a|
        a.name(c.name)
      end
    end
  end
end
