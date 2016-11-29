class Readom
  ReadomAPIBase = NSBundle.mainBundle.infoDictionary.valueForKey('ReadomAPIBase') || 'https://readom-api.herokuapp.com/news/v0/'
  ITEM_URL_FORMAT = 'https://news.ycombinator.com/item?id=%d'

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
              item['url'] = ITEM_URL_FORMAT % item['id']
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

  def self.current_topic(&block)
    @current_topic_idx ||= 0
    topic = topics[@current_topic_idx]

    block.call(topic) if block

    topic
  end

  def self.current_topic_title(&block)
    _title(current_topic)
  end

  def self.current_topic=(topic, &block)
    @current_topic_idx = topics.find_index(topic)
    topic = topics[@current_topic_idx]

    block.call(topic) if block

    topic
  end

  def self.topic_titles
    topics.map {|t| _title(t) }
  end

  def self.topics
    [:newstories, :topstories, :beststories, :showstories, :askstories, :jobstories]
  end

private
  def self.session(cf = :default)
    @sessions = {}
    @sessions[cf] ||= AFMotion::SessionClient.build(ReadomAPIBase) do
      session_configuration cf

      header "Accept", "application/json"
      header "R-UVID", UVID.uvid

      response_serializer :json
    end
  end

  def self._title(str)
    str[/(.+)stories/, 1].capitalize
  end
end
