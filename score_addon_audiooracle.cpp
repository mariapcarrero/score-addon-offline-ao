#include "score_addon_audiooracle.hpp"

#include <score/plugins/FactorySetup.hpp>

#include <AudioOracle/AudioOracleFactory.hpp>

score_addon_audiooracle::score_addon_audiooracle() { }

score_addon_audiooracle::~score_addon_audiooracle() { }

std::vector<std::unique_ptr<score::InterfaceBase>>
score_addon_audiooracle::factories(
    const score::ApplicationContext& ctx,
    const score::InterfaceKey& key) const
{
  return instantiate_factories<
      score::ApplicationContext,
      FW<Process::OfflineAction,
          AudioOracle::GainDoubler>>(ctx, key);
}

#include <score/plugins/PluginInstances.hpp>
SCORE_EXPORT_PLUGIN(score_addon_audiooracle)
