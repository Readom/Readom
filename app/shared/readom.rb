class Readom
  HOST = 'https://readom-api.herokuapp.com'

  def self.fetch_item(item_id, &block)
    itemEntry = 'item/%s.json' % item_id

    self.session.get(itemEntry) do |result|
      if result.success?
        item = result.object

        if item['title']
          block.call(item) if block
        end
      end
    end
  end

  def self.fetch_items(list=:newstories, limit=10, &block)
    listEntry = '%s.json?limit=%d' % [list, limit]

    self.session.get(listEntry) do |result|
      if result.success?
        result.object.shuffle.each do |item|
          if item['title']
            if item['url'].nil?
              item['url'] = 'https://news.ycombinator.com/item?id=%d' % item['id']
            end

            block.call(item) if block
          end
        end
      end
    end
  end

private
  def self.session
    @session ||= AFMotion::SessionClient.build("#{HOST}/news/v0/") do
      session_configuration :default

      header "Accept", "application/json"

      response_serializer :json
    end
  end
end
