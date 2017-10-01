class ItemScreen < UIViewController
  extend IB
  outlet :titleLabel, UILabel

  attr_accessor :item, :delegate

  def viewDidLoad
    super

    titleLabel.text = @item.title
  end

  def viewWillAppear(animated)
    super
  end

  def favorite_item(sender)
    @delegate.favorite_item(self)
  end

  def next_item(sender)
    @delegate.next_item(self)
  end
end
