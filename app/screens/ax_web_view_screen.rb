if NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0

  class AXWebViewController < SFSafariViewController
  end

elsif NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0

  class AXWebViewController < PM::Screen
    attr_accessor :delegate
    attr_accessor :preferredBarTintColor, :preferredControlTintColor
    attr_accessor :url

    def load_view
      @layout = AXWebViewLayout.new
      self.view = @layout.view
    end

    def on_load
      @url ||= 'https://www.bing.com'
      @webkit_view = @layout.get(:webkit_view)
      @webkit_view.navigationDelegate = @delegate
      @webkit_view.UIDelegate = @delegate
      @webkit_view.loadRequest(@url.nsurlrequest)
    end

    def initWithURL(url, entersReaderIfAvailable: reader)
      @url = url

      self
    end
  end

end
