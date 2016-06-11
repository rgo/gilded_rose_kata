SULFURAS = 'Sulfuras, Hand of Ragnaros'.freeze
BACKSTAGE = 'Backstage passes to a TAFKAL80ETC concert'.freeze
BRIE = 'Aged Brie'.freeze
MIN_QUALITY = 0
MAX_QUALITY = 50
SELL_IN_DAY = 0
BACKSTAGE_SELL_IN_DOUBLE = 11
BACKSTAGE_SELL_IN_TRIPLE = 6

def decrement_quality(item)
  item.quality -= 1 if item.name != SULFURAS
end

def increment_backstage_quality(item)
  if item.name == BACKSTAGE && item.quality < MAX_QUALITY
    if item.sell_in < BACKSTAGE_SELL_IN_DOUBLE
      increment_quality item
    end
    if item.sell_in < BACKSTAGE_SELL_IN_TRIPLE
      increment_quality item
    end
  end
end

def increment_quality(item)
  item.quality += 1 if item.quality < MAX_QUALITY
end

def update_quality(items)
  items.each do |item|
    if item.name != BRIE && item.name != BACKSTAGE
      if item.quality > MIN_QUALITY
        decrement_quality item
      end
    else
      increment_quality item
      increment_backstage_quality item
    end
    if item.name != SULFURAS
      item.sell_in -= 1
    end
    if item.sell_in < SELL_IN_DAY
      if item.name != BRIE
        if item.name != BACKSTAGE
          if item.quality > MIN_QUALITY
            decrement_quality item
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        increment_quality item
      end
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
