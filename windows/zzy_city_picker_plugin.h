#ifndef FLUTTER_PLUGIN_ZZY_CITY_PICKER_PLUGIN_H_
#define FLUTTER_PLUGIN_ZZY_CITY_PICKER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace zzy_city_picker {

class ZzyCityPickerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ZzyCityPickerPlugin();

  virtual ~ZzyCityPickerPlugin();

  // Disallow copy and assign.
  ZzyCityPickerPlugin(const ZzyCityPickerPlugin&) = delete;
  ZzyCityPickerPlugin& operator=(const ZzyCityPickerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace zzy_city_picker

#endif  // FLUTTER_PLUGIN_ZZY_CITY_PICKER_PLUGIN_H_
