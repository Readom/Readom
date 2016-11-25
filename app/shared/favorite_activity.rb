class ReadomActivity < UIActivity
  @title = nil
  @url = nil

  def initialize
    super
  end

  def initWithURL(url, title: title)
    @url = url
    @title = title

    self
  end

  def activityType
    '%s.%s' % [app.identifier, self.classForCoder.to_s]
  end

  def activityTitle
    self.classForCoder.to_s
  end

  def activityImage
    UIImage.imageNamed 'Icon-60.png'
  end

  def canPerformWithActivityItems(activityItems)
    mp :canPerform => @canPerform

    @canPerform
  end

  def prepareWithActivityItems(activityItems)
    super
  end

  def performActivity
    super

    @canPerform = false
    activityDidFinish true
  end

  #def self.activityViewController
  #end

  def self.activityCategory
    UIActivityCategoryShare
  end
end

class FavoriteActivity < ReadomActivity
  @item = nil

  def initWithItem(item)
    @item = item
    @canPerform = true

    self
  end

  def performActivity
    mp :performActivity => @item
    super
  end
end
