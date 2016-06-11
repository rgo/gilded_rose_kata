require 'lib/quality_updater.rb'
require 'lib/any_item_quality_updater.rb'
require 'lib/sulfuras_quality_updater.rb'
require 'lib/brie_quality_updater.rb'
require 'lib/backstage_quality_updater.rb'

SULFURAS = 'Sulfuras, Hand of Ragnaros'.freeze
BACKSTAGE = 'Backstage passes to a TAFKAL80ETC concert'.freeze
BRIE = 'Aged Brie'.freeze

def update_quality(items)
  items.each do |item|
    quality_updater = case item.name
                      when SULFURAS
                        QualityUpdater.new(SulfurasQualityUpdater.new)
                      when BRIE
                        QualityUpdater.new(BrieQualityUpdater.new)
                      when BACKSTAGE
                        QualityUpdater.new(BackstageQualityUpdater.new)
                      else
                        QualityUpdater.new(AnyItemQualityUpdater.new)
                      end
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
