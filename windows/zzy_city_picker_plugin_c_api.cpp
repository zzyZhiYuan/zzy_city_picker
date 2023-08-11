#include "include/zzy_city_picker/zzy_city_picker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "zzy_city_picker_plugin.h"

void ZzyCityPickerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  zzy_city_picker::ZzyCityPickerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
