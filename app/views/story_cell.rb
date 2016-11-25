class StoryCell < UICollectionViewCell
  def on_load
    find(self).apply_style :story_cell

    q = find(self.contentView)
    # Add your subviews, init stuff here
    # @foo = q.append!(UILabel, :foo)
    @title = q.append!(UILabel, :title)
    @info = q.append!(UILabel, :info)
  end

  def set(item)
    unless item.nil?
      @title.text = item['title']
      @info.attributedText = :'star-o'.awesome_icon(size: 9) + '%d' % item['score'] +
        ' ' + :user.awesome_icon(size: 9) + '%s' % item['by'] +
        ' ' + :'clock-o'.awesome_icon(size: 9) + '%s' % Time.at(item['time']).strftime('%v %T %Z')
    end
  end
end
