class Readom
  def self.fetch_item_sample(list=:newstories, &block)
    listEntry = 'https://Readom.github.io/HackerNewsJSON/%s.json' % list

    AFMotion::JSON.get(listEntry) do |result|
      if result.success?
        loop_count = 0
        item = result.object.sample

        while item['url'].nil? and result.object.size >= loop_count+=1
          item = result.object.sample
        end

        block.call(item['id'], item['title'], item['url'])
      end
    end
  end
end
