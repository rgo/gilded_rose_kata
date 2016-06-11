require 'lib/quality_updater.rb'
require 'lib/any_item_quality_updater.rb'
require 'lib/sulfuras_quality_updater.rb'
require 'lib/brie_quality_updater.rb'
require 'lib/backstage_quality_updater.rb'

SULFURAS = 'Sulfuras, Hand of Ragnaros'.freeze
BACKSTAGE = 'Backstage passes to a TAFKAL80ETC concert'.freeze
BRIE = 'Aged Brie'.freeze
MIN_QUALITY = 0
MAX_QUALITY = 50
SELL_IN_DAY = 0
BACKSTAGE_SELL_IN_DOUBLE = 11
BACKSTAGE_SELL_IN_TRIPLE = 6

def update_quality(items)
  items.each do |item|
    if item.name == SULFURAS
      quality_updater = QualityUpdater.new(SulfurasQualityUpdater.new)
      quality_updater.do item
      next
    end

    if item.name == BRIE
      quality_updater = QualityUpdater.new(BrieQualityUpdater.new)
      quality_updater.do item
      next
    end

    if item.name == BACKSTAGE
      quality_updater = QualityUpdater.new(BackstageQualityUpdater.new)
      quality_updater.do item
      next
    end

    quality_updater = QualityUpdater.new(AnyItemQualityUpdater.new)
    quality_updater.do item
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
