import Foundation
import KeychainAccess


protocol PhoneTaskIdGenerating {
    func genarateId() -> Int
}


class TaskPhoneIdGenerator: PhoneTaskIdGenerating {
    private struct Constants {
        static let firstId = 0
        static let service = "com.qittiq.apptoyou.phone-id"
        static let key = "lastPhoneTaskId"
    }
    
    private let keychain = Keychain(service: Constants.service)
    
    func genarateId() -> Int {
        var id: Int
        
        if let lastId = getId() {
            id = lastId + 1
        } else {
            id = Constants.firstId + 1
        }
        set(id: id)
        return id
    }
    
    private func set(id: Int) {
        do {
            try keychain.set("\(id)", key: Constants.key)
        } catch let error {
            print(error)
        }
    }
    
    private func getId() -> Int? {
        if let stringId = try? keychain.get(Constants.key) {
            return Int(stringId)
        } else {
            return nil
        }
    }
    
}
