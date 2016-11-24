class StoryCell < UICollectionViewCell
  def on_load
    find(self).apply_style :story_cell

    q = find(self.contentView)
    # Add your subviews, init stuff here
    # @foo = q.append!(UILabel, :foo)
    @title = q.append!(UILabel, :title)
  end

  def set(item)
    @title.text = item['title']
  end
end
