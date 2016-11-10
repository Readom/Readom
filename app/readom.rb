class Readom
  HOST = 'https://readom-api.herokuapp.com'
  #HOST = 'http://readom-api.herokuapp.com.mkmd.cn'

  def self.fetch_item(item_id, &block)
    itemEntry = '%s/news/v0/item/%s.json' % [Readom::HOST, item_id]

    AFMotion::JSON.get(itemEntry) do |result|
      if result.success?
        item = result.object

        item_title = item['title']
        item_url = item['url']

        block.call(item)
      end
    end
  end

  def self.fetch_items(list=:newstories, limit=10, &block)
    listEntry = '%s/news/v0/%s.json?limit=%d' % [Readom::HOST, list, limit]

    AFMotion::JSON.get(listEntry) do |result|
      if result.success?
        if block
          result.object.shuffle.each do |item|
            if item['title'] and item['url'].nil?
              url = 'https://news.ycombinator.com/item?id=%d' % item['id']
              block.call(item['id'], item['title'], url)
            else
              block.call(item['id'], item['title'], item['url']) unless item['title'].nil?
            end
          end
        end
      end
    end
  end
end
