@objc(DemoPlugin) class DemoPlugin : CDVPlugin{

    // MARK: Properties
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

    override func pluginInitialize() {
    }

    @objc(add:) func add(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
        let param1 = (command.arguments[0] as? NSObject)?.value(forKey: "param1") as? Int
        let param2 = (command.arguments[0] as? NSObject)?.value(forKey: "param2") as? Int

        if let p1 = param1 , let p2 = param2 {
            if p1 >= 0 && p1 >= 0{
                let total = String(p1 + p2)

                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK,
                                               messageAs: total)
            }else {
                pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                               messageAs: "Something wrong")
            }
        }
        self.commandDelegate!.send(pluginResult,
                                   callbackId: command.callbackId)
    }

    @objc(coolMethod:) func coolMethod(_ command: CDVInvokedUrlCommand?) {
    var pluginResult: CDVPluginResult? = nil
    let echo = command?.arguments[0] as? String

    if echo != nil && (echo?.count ?? 0) > 0 {
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: echo)
    } else {
        pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    }

    commandDelegate.send(pluginResult, callbackId: command?.callbackId)
}
}
