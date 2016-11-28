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
      @title.text = '%s' % item['title']
      @star_ico ||= :'star-o'.awesome_icon(size: 14)
      @user_ico ||= :user.awesome_icon(size: 14)
      @clock_ico ||= :'clock-o'.awesome_icon(size: 14)
      @info.attributedText = @star_ico + ' %d  ' % item['score'] +
        @user_ico + ' %s  ' % item['by'] +
        @clock_ico + ' %s' % Time.at(item['time']).ago_in_words
    end
  end
end
