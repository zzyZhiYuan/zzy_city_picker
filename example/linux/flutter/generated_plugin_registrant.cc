//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <zzy_city_picker/zzy_city_picker_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) zzy_city_picker_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ZzyCityPickerPlugin");
  zzy_city_picker_plugin_register_with_registrar(zzy_city_picker_registrar);
}
