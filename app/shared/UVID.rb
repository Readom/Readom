class UVID
  PREFIX="UV-"

  class << self
    def uvid
      unless NSUserDefaults['UVID'] and NSUserDefaults['UVID'].length >= 36
        NSUserDefaults['UVID'] = "%s%s" % [PREFIX, CFUUIDCreateString(nil, CFUUIDCreate(nil))]
      end

      return NSUserDefaults['UVID']
    end
  end
end
