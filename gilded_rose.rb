require 'lib/quality_updater.rb'
require 'lib/any_item_quality_updater.rb'
require 'lib/sulfuras_quality_updater.rb'
require 'lib/brie_quality_updater.rb'
require 'lib/backstage_quality_updater.rb'

SULFURAS = 'Sulfuras, Hand of Ragnaros'.freeze
BACKSTAGE = 'Backstage passes to a TAFKAL80ETC concert'.freeze
BRIE = 'Aged Brie'.freeze
ANY_ITEM = 'Any item'.freeze

STRATEGIES = {
  SULFURAS => SulfurasQualityUpdater,
  BACKSTAGE => BackstageQualityUpdater,
  BRIE => BrieQualityUpdater,
  ANY_ITEM => AnyItemQualityUpdater
}.freeze

def choose_updater_strategy(item)
  return STRATEGIES[ANY_ITEM].new unless STRATEGIES.key? item.name

  STRATEGIES[item.name].new
end

def update_quality(items)
  items.each do |item|
    quality_updater = QualityUpdater.new(choose_updater_strategy(item))

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
