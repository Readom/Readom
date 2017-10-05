class ItemScreen < UIViewController
  extend IB
  outlet :titleLabel, UILabel
  outlet :commentLabel, UILabel

  attr_accessor :item, :delegate

  def viewDidLoad
    super

    load_title
    load_comments
  end

  def viewWillAppear(animated)
    super
  end

  def viewWillDisappear(animated)
    super

    load_comments_queue.cancelAllOperations
  end

  def load_title
    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: 'show_web_screen')
    tapGesture.numberOfTapsRequired = 1
    titleLabel.addGestureRecognizer tapGesture

    titleLabel.text = @item.title
  end

  def load_comments
    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: 'show_comments_web_screen')
    tapGesture.numberOfTapsRequired = 1
    commentLabel.addGestureRecognizer tapGesture

    load_comments_queue.addOperationWithBlock(-> {
      if comments.size > 0
        Dispatch::Queue.main.sync do
          commentLabel.text = comments.sample.content
        end
      else
        Dispatch::Queue.main.sync do
          commentLabel.text = 'No comments.'._
        end
      end
    })
  end

  def comments
    @comments ||= @item.comments || [Comment.new]
  end

  def load_comments_queue
    @load_comments_queue ||= begin
      queue = NSOperationQueue.new
      queue.name = 'load_comments_queue'
      queue.maxConcurrentOperationCount = 1

      queue
    end
  end

  def show_web_screen
    web_screen = WebScreen.create(@item.url)

    self.presentModalViewController(web_screen, animated: false)
  end

  def show_comments_web_screen
    web_screen = WebScreen.create('https://news.ycombinator.com/item?id=%s' % @item.id)

    self.presentModalViewController(web_screen, animated: false)
  end

  def favorite_item(sender)
    @delegate.favorite_item(self)
  end

  def next_item(sender)
    @delegate.next_item(self)
  end
end
