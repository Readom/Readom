class String
  def _()
    NSBundle.mainBundle.localizedStringForKey(self, value:self, table:nil)
  end
end
