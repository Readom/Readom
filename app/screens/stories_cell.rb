class StoriesCell < UICollectionViewCell
  REUSE_ID = "StoriesCell"

  def initWithFrame(frame)
    super

    @item = @targetViewController = nil

    @layout = StoriesCellLayout.new(root: self.contentView).build

    # labels
    @domain = @layout.get(:domain)
    @title = @layout.get(:title)
    @time_ago = @layout.get(:time_ago)

    @score_number = @layout.get(:score_number)
    #@score_title = @layout.get(:score_title)

    # buttons
    @yc_button = @layout.get(:yc_button)
    @url_button = @layout.get(:url_button)

    [
      [@title, "title_clicked:", 1],
      [@url_button, "url_button_clicked:", 1],
      [@yc_button, "yc_button_clicked:", 1]
    ].each do |obj_action_num|
      obj, action, num = obj_action_num

      tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: action)
      tapGesture.numberOfTapsRequired = num
      obj.addGestureRecognizer tapGesture
    end

    self
  end

  def setItem(item, targetViewController: view_controller)
    @item = item
    @targetViewController = view_controller

    @source_ico ||= :home.awesome_icon(size: 14, color: '#999999'.uicolor)
    @user_ico ||= :user.awesome_icon(size: 14, color: '#999999'.uicolor)
    @clock_ico ||= :'clock-o'.awesome_icon(size: 14, color: '#999999'.uicolor)

    if ! @item.nil?
      @domain.attributedText = @source_ico + ' %s' % @item['url'].nsurl.host.gsub(/^www\./, '')
      @title.text = '%s' % @item['title']
      @score_number.text = '%s' % @item['score']
      @time_ago.attributedText = @user_ico + ' %s ' % @item['by'] +
        @clock_ico + ' %s' % Time.at(@item['time']).ago_in_words
    end
  end

  def title_clicked(sender)
    if @item
      url = @item['url'].nsurl

      @targetViewController.presentViewController(
          WebScreen.create(url: url, item: @item, reader: NSUserDefaults['readerViewEnabled']),
          animated: true,
          completion: nil
        )
    end
  end

  def url_button_clicked(sender)
    if @item
      url = @item['url'].nsurl

      @targetViewController.presentViewController(
          WebScreen.create(url: url, item: @item, reader: false),
          animated: true,
          completion: nil
        )
    end
  end

  def yc_button_clicked(sender)
    if @item
      url = @item['item_url'].nsurl

      @targetViewController.open WebScreen.create url: url, item: @item, reader: false
    end
  end
end
