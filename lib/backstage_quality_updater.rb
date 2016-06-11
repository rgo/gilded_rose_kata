class BackstageQualityUpdater
  MIN_QUALITY = 0
  MAX_QUALITY = 50
  SELL_IN_DAY = 0
  BACKSTAGE_SELL_IN_DOUBLE = 11
  BACKSTAGE_SELL_IN_TRIPLE = 6

  def do(item)
    increment_quality item

    decrement_sell_in item
    return item if valid?(item)

    expire(item)
  end

  protected

  def increment_quality(item)
    return unless item.quality < MAX_QUALITY

    item.quality += 1
    item.quality += 1 if item.sell_in < BACKSTAGE_SELL_IN_DOUBLE
    item.quality += 1 if item.sell_in < BACKSTAGE_SELL_IN_TRIPLE
  end

  def extra_increment_quality(item)
    return unless item.quality < MAX_QUALITY
  end

  def decrement_sell_in(item)
    item.sell_in -= 1
  end

  def valid?(item)
    item.sell_in >= SELL_IN_DAY
  end

  def expire(item)
    item.quality = 0
    item
  end
end
