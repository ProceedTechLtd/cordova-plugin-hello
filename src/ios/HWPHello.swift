import Cordova

@objc(HWPHello)
class HWPHello: CDVPlugin {

    @objc(greet:)
    func greet(_ command: CDVInvokedUrlCommand) {

        let name = command.arguments.first as? String ?? ""
        let msg = "Hello, \(name)"

        let result = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: msg
        )

        self.commandDelegate.send(
            result,
            callbackId: command.callbackId
        )
    }
}
