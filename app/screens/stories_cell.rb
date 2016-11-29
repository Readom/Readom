class StoriesCell < UICollectionViewCell
  REUSE_ID = "StoriesCell"

  def initWithFrame(frame)
    super

    @layout = StoriesCellLayout.new(root: self.contentView).build
    @title = @layout.get(:title)
    @info = @layout.get(:info)

    self
  end

  def item=(item)
    @star_ico ||= :'star-o'.awesome_icon(size: 14)
    @user_ico ||= :user.awesome_icon(size: 14)
    @clock_ico ||= :'clock-o'.awesome_icon(size: 14)

    unless item.nil?
      @title.text = '%s' % item['title']

      @info.attributedText = @star_ico + ' %d  ' % item['score'] +
        @user_ico + ' %s  ' % item['by'] +
        @clock_ico + ' %s' % Time.at(item['time']).ago_in_words
    end
  end
end
