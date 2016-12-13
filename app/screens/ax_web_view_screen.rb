if NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0

  class AXWebViewController < SFSafariViewController

    attr_accessor :item, :url

  end

elsif NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0

  class AXWebViewController < PM::Screen

    attr_accessor :item, :url, :delegate
    attr_accessor :preferredBarTintColor, :preferredControlTintColor

    def load_view
      @layout = AXWebViewLayout.new
      self.view = @layout.view

      @webkit_view = @layout.get(:webkit_view)
      @address = @layout.get(:address)
      @title = @layout.get(:title)

      @back = @layout.get(:back)
      @yc = @layout.get(:yc)
      @source = @layout.get(:source)
    end

    def on_load
      @address.text = @item['url'].nsurl.host.gsub(/^www\./, '')
      @address.textColor = @preferredControlTintColor
      @title.text = @item['title']
      @title.sizeToFit
      @title.textColor = @preferredControlTintColor

      @webkit_view.navigationDelegate = self
      @webkit_view.UIDelegate = self
      @webkit_view.loadRequest(@url.nsurlrequest)

      @webkit_view.addObserver(self, forKeyPath: 'title', options: NSKeyValueObservingOptionNew, context: nil)

      if modal?
        @webkit_view.scrollView.delegate = self
      else
        @layout.hide_title_bar
      end

      @back.on(:touch) { self.close }
      @source.on(:touch) { @webkit_view.loadRequest(@item['url'].nsurl.nsurlrequest) }
      @yc.on(:touch) { @webkit_view.loadRequest(@item['item_url'].nsurl.nsurlrequest) }
    end

    def will_disappear
      @webkit_view.scrollView.delegate = nil

      @webkit_view.removeObserver(self, forKeyPath:"title")
    end

    def initWithURL(url, entersReaderIfAvailable: reader)
      @url = url

      self
    end

    def scrollViewDidScroll(scrollView)
      @lastContentOffset ||= 0
      @lastDirection ||= 0

      if scrollView.contentOffset.y < 0
        # top
        @layout.normal_title_bar

      elsif @lastContentOffset > scrollView.contentOffset.y
        # move up
        if @lastDirection == 1
          @lastDirection = 0
          @layout.normal_title_bar
        end
      elsif @lastContentOffset < scrollView.contentOffset.y
        if @lastDirection == 0
          @layout.minimal_title_bar
          @lastDirection = 1
        end
      end

      @lastContentOffset = scrollView.contentOffset.y;
    end

    def observeValueForKeyPath(keyPath, ofObject:object, change:change, context:context)
      if keyPath == 'title'
        @title.text = object.title
        @address.text = object.URL.host.gsub(/^www\./, '')
      end
    end

    def webView(webView, didFinishNavigation: navigation)
      @title.text = webView.title
      @address.text = webView.URL.host.gsub(/^www\./, '')
    end

  end

end
