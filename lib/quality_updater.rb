class QualityUpdater
  def initialize(quality_updater)
    @quality_updater = quality_updater
  end

  def do(item)
    @quality_updater.do item
  end
end
