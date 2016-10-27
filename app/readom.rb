class Readom
  def self.fetch_item_sample(list=:newstories, &block)
    listEntry = 'https://Readom.github.io/HackerNewsJSON/%s.json' % list

    AFMotion::JSON.get(listEntry) do |result|
      if result.success?
        item = result.object.sample

        unless item['url'].nil?
          title = item['title']
          url = item['url']

          block.call(title, url)
        end
      end
    end
  end
end
