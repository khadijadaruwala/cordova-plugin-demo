@objc(DemoPlugin) class DemoPlugin : CDVPlugin{

    // MARK: Properties
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

    //This method is called when the plugin is initialized; plugin setup methods got here
    override func pluginInitialize() {
    }

    /* This methods accepts 2 int params from ionic app
     Adds the 2 numbers and sends back the sum or error to ionic */
    @objc(add:) func add(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
        let param1 = (command.arguments[0] as? NSObject)?.value(forKey: "param1") as? Int
        let param2 = (command.arguments[0] as? NSObject)?.value(forKey: "param2") as? Int

        if let p1 = param1 , let p2 = param2 {
            if p1 >= 0 && p1 >= 0{
                let total = String(p1 + p2)

                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK,
                                               messageAs: total)
            } else {
                pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                               messageAs: "Something wrong")
            }
        }
        self.commandDelegate!.send(pluginResult,
                                   callbackId: command.callbackId)
    }

    /* This methods accepts string messgae from ionic app
     and returns a message */
    @objc(coolMethod:) func coolMethod(_ command: CDVInvokedUrlCommand?) {
        var pluginResult: CDVPluginResult? = nil
        let echo = command?.arguments[0] as? String
        if let echoString = echo{
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "\(echoString)!! from India")
        } else {
            pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
        }

        commandDelegate.send(pluginResult, callbackId: command?.callbackId)
    }

    @objc(getUserData:) func getUserData(_ command: CDVInvokedUrlCommand) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userDataController = storyboard.instantiateViewController(withIdentifier: "controllerId") as! ViewController
        userDataController.userDataDelegate = self
        userDataController.cdvCommand = command
        viewController.addChildController(userDataController)
    }
}

// User Report date delegate methods which sends result back to ionic app from UIViewController
extension DemoPlugin: UserDataDelegate {
    func sendData(userData: [String : Any], command: CDVInvokedUrlCommand) {
        print("Data: \(userData)")
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: userData)
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }
}