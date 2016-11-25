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
        items = result.object.shuffle.map do |item|
          if item['title']
            if item['url'].nil?
              item['url'] = 'https://news.ycombinator.com/item?id=%d' % item['id']
            end

            item
          else
            nil
          end
        end.compact

        block.call items if block
      end
    end
  end

  def self.fetch_items_each(list=:newstories, limit=10, &block)
    self.fetch_items(list, limit) do |items|
      items.each do |item|
        block.call item if block
      end
    end
  end

private
  def self.session
    @session ||= AFMotion::SessionClient.build("#{HOST}/news/v0/") do
      session_configuration :default

      header "Accept", "application/json"
      header "X-App-Version", "%s/%s" % [app.short_version, app.version]

      response_serializer :json
    end
  end
end
