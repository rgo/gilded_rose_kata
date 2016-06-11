require 'lib/any_item_quality_updater.rb'
require 'lib/sulfuras_quality_updater.rb'
require 'lib/brie_quality_updater.rb'
require 'lib/backstage_quality_updater.rb'

class QualityUpdater
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

  def initialize(item)
    @quality_updater = choose_updater_strategy(item)
  end

  def do(item)
    @quality_updater.do item
  end

  def choose_updater_strategy(item)
    return STRATEGIES[ANY_ITEM].new unless STRATEGIES.key? item.name

    STRATEGIES[item.name].new
  end
end
