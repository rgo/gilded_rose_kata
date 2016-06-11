class AnyItemQualityUpdater
  MIN_QUALITY = 0
  MAX_QUALITY = 50
  SELL_IN_DAY = 0

  def do(item)
    decrement_quality item

    decrement_sell_in item
    return item if expired?(item)

    decrement_quality item

    item
  end

  protected

  def decrement_quality(item)
    return unless item.quality > MIN_QUALITY

    item.quality -= 1
  end

  def decrement_sell_in(item)
    item.sell_in -= 1
  end

  def expired?(item)
    item.sell_in >= SELL_IN_DAY
  end
end
