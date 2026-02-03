import UIKit
import OrigoSDK
import CoreLocation
import AudioToolbox

class OrigoKeyController: NSObject {

    static var shared = OrigoKeyController()
    var origoKeysManager: OrigoKeysManager?
    var origoKeys: [AnyHashable] = []

    override init() {
          super.init()
          // Set up a logging handler (managing the Example app log outout)
          logger = Logger.sharedLogger
          // Create the OrigoKeysManager
          origoKeysManager = createInitializedMobileKeysManager()
    }

    func start() {
          // The startup will either give a callback to "OrigoKeysDidStartup" or "OrigoKeysDidFailToStartup"
          origoKeysManager?.startup()
        
          let session : OrigoSSOSession = (origoKeysManager?.getSSOSession())!
    }

    func currentOpeningTypes() -> [AnyHashable]? {
          var supportedOpeningTypes = [NSNumber(value: OrigoKeysOpeningType.proximity.rawValue)]
          supportedOpeningTypes.append(NSNumber(value: OrigoKeysOpeningType.applicationSpecific.rawValue))
          print(origoKeysManager!.healthCheck())
          // if (!(origoKeysManager?.healthCheck().ç(where: NSNumber(value: OrigoKeysInfoType.bleSharingTurnedOff.rawValue)))!) {
          supportedOpeningTypes.append(NSNumber(value: OrigoKeysOpeningType.enhancedTap.rawValue))
          //}
          supportedOpeningTypes.append(NSNumber(value: OrigoKeysOpeningType.motion.rawValue))
          supportedOpeningTypes.append(NSNumber(value: OrigoKeysOpeningType.seamless.rawValue))
          return supportedOpeningTypes
    }


    /*
     This is a factory method that creates an instance of the OrigoKeysManager.App Name and version will also be sent in this method
     */
    func createInitializedMobileKeysManager() -> OrigoKeysManager? {

          let version = "\(APPLICATION_ID)-\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ??  0) (\(Bundle.main.infoDictionary?["CFBundleVersion"] ?? 0))"
          let isApplePayDisable = true
          let config: [String : Any] = [
              OrigoKeysOptionApplicationId: APPLICATION_ID,
              OrigoKeysOptionVersion: version,
              OrigoKeysOptionSuppressApplePay :isApplePayDisable,
              OrigoKeysOptionBackgroundTaskID: BACKGROUNDTASK_ID
              ]
          return OrigoKeysManager(delegate: self, options: config)

    }
  
    func healthCheck(){
    
            let walletHealthCheck = origoKeysManager?.walletHealthCheck()
            for mkit: NSNumber in walletHealthCheck as? [NSNumber] ?? []{
                let type = (OrigoKeysWalletInfoType)(rawValue: mkit.intValue)
                switch type {
                case OrigoKeysWalletInfoType.typeSecureElementPassNotAvailable?:
                    logger?.addLogEntry("Entitlement Not Available")
                case OrigoKeysWalletInfoType.typeMainWindowNotAvailable?:
                    logger?.addLogEntry("Main Window Not Available")
                default:
                    break
                }
            }
        }
}
