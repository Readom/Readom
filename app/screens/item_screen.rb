class ItemScreen < UIViewController
  extend IB
  outlet :titleLabel, UILabel

  attr_accessor :item, :delegate

  def viewDidLoad
    super

    titleLabel.text = @item[:title]

    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: 'show_web_screen')
    tapGesture.numberOfTapsRequired = 1
    titleLabel.addGestureRecognizer tapGesture
  end

  def viewWillAppear(animated)
    super
  end

  def show_web_screen
    web_screen = WebScreen.create(@item)

    self.presentModalViewController(web_screen, animated: false)
  end

  def favorite_item(sender)
    @delegate.favorite_item(self)
  end

  def next_item(sender)
    @delegate.next_item(self)
  end
end
