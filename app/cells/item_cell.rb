class ItemCell < UITableViewCell
  extend IB

  attr_accessor :item

  def item=(item)
    @item = item

    self.textLabel.text = @item.title
    self.detailTextLabel.text = @item.id

    self.textLabel.numberOfLines = 0
    self.detailTextLabel.numberOfLines = 0
  end
end
