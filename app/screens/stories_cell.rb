class StoriesCell < UICollectionViewCell
  REUSE_ID = "StoriesCell"

  def initWithFrame(frame)
    super

    @item = @targetViewController = nil

    @layout = StoriesCellLayout.new(root: self.contentView).build

    # labels
    @title = @layout.get(:title)
    @info = @layout.get(:info)
    @domain = @layout.get(:domain)

    # buttons
    @comments = @layout.get(:comments)
    @openurl = @layout.get(:openurl)

    [
      [@title, "title_clicked:", 1],
      [@openurl, "openurl_clicked:", 1],
      [@comments, "comments_clicked:", 1]
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

    @star_ico ||= :'star-o'.awesome_icon(size: 14)
    @user_ico ||= :user.awesome_icon(size: 14)
    @clock_ico ||= :'clock-o'.awesome_icon(size: 14)
    @terminal_ico ||= :'terminal'.awesome_icon(size: 14)

    if ! @item.nil?
      @title.text = '%s' % @item['title']

      @info.attributedText = @star_ico + ' %d ' % @item['score'] +
        @user_ico + ' %s ' % @item['by'] +
        @clock_ico + ' %s' % Time.at(@item['time']).ago_in_words

      @domain.attributedText = @terminal_ico + ' %s' % @item['url'].nsurl.host.gsub(/^www\./, '')
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

  def openurl_clicked(sender)
    if @item
      url = @item['url'].nsurl

      @targetViewController.presentViewController(
          WebScreen.create(url: url, item: @item, reader: false),
          animated: true,
          completion: nil
        )
    end
  end

  def comments_clicked(sender)
    if @item
      url = @item['item_url'].nsurl

      @targetViewController.open WebScreen.create url: url, item: @item, reader: false
    end
  end
end
