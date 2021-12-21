import Foundation
import KeychainAccess


protocol DeviceIdentifiable {
    func getDeviceUUID() -> String
}


class DeviceIdentifierService: DeviceIdentifiable {
    
    private struct Constants {
        static let service = "com.qittiq.apptoyou.device-uuid"
        static let key = "deviceUUID"
    }
    
    private let keychain = Keychain(service: Constants.service)
    
    func getDeviceUUID() -> String {
        if let uuid = getUUID() {
            return uuid
        } else {
            let uuid = UUID().uuidString
            setUUID(uuid)
            return uuid
        }
    }
    
    private func setUUID(_ uuid: String) {
        do {
            try keychain.set(uuid, key: Constants.key)
        } catch let error {
            print(error)
        }
    }
    
    private func getUUID() -> String? {
        return try? keychain.get(Constants.key)
    }
    
}
