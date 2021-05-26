//
//  ATUDatabaseService.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.05.2021.
//

import Foundation
import CoreStore

public enum ATYDatabaseServiceError: Error {
    case uncategorized
}

public final class ATYDatabaseService {

    //MARK:- Properties
    private static let storeName = "AppToYou"
    private static let configuration = "Default"
    private static let defaultDatabaseDirectory = FileManager.Directory.database.url
    private static var generateStoreFileName: String {
        #if DEBUG
        let generatedStoreFileName = "AppToYou-debug"
        #else
        let generatedStoreFileName = "AppToYou"
        #endif
        return "\(generatedStoreFileName).\(self.storeExtension)"
    }

    static let storeExtension = "sqlite"

    private static let store = SQLiteStore(fileURL: ATYDatabaseService.defaultDatabaseDirectory.appendingPathComponent(ATYDatabaseService.generateStoreFileName),
                                           configuration: ATYDatabaseService.configuration,
                                           migrationMappingProviders: [],
                                           localStorageOptions: .allowSynchronousLightweightMigration)

    let storage: SQLiteStore
    private let dataStack = DataStack(xcodeModelName: ATYDatabaseService.storeName, bundle: Bundle.main, migrationChain: nil)

    // MARK: Init

    public init() throws {
        self.storage = try self.dataStack.addStorageAndWait(Self.store)
        print("Local storage -> \(self.storage.fileURL)")
    }

    public static func detachStore() throws {

        let fileManager = FileManager.default
        let localDatabaseURL = ATYDatabaseService.defaultDatabaseDirectory.appendingPathComponent(ATYDatabaseService.generateStoreFileName)
        let localDatabaseTempSHMURL = ATYDatabaseService.defaultDatabaseDirectory.appendingPathComponent(ATYDatabaseService.generateStoreFileName + "-shm")
        let localDatabaseTempWALURL = ATYDatabaseService.defaultDatabaseDirectory.appendingPathComponent(ATYDatabaseService.generateStoreFileName + "-wal")

        if fileManager.fileExists(atPath: localDatabaseURL.path) {
            try fileManager.removeItem(at: localDatabaseURL)
        }

        if fileManager.fileExists(atPath: localDatabaseTempSHMURL.path) {
            try fileManager.removeItem(at: localDatabaseTempSHMURL)
        }

        if fileManager.fileExists(atPath: localDatabaseTempWALURL.path) {
            try fileManager.removeItem(at: localDatabaseTempWALURL)
        }
    }

    // MARK: Core Store Actions

    /// This public function only need to secure dataStack and make it private. Duplicate DataStack.perform(synchronous:) functionality:
    /// Synchronous perform a clousure with transaction
    public func perform<T>(synchronous task: ((SynchronousDataTransaction) throws -> T)) throws -> T {
        return try self.dataStack.perform(synchronous: task)
    }

    /// This public function only need to secure dataStack and make it private. Duplicate DataStack.perform(asynchronous:) functionality:
    /// Asynchronous perform a clousure with transaction
    public func perform(asynchronous task: @escaping (AsynchronousDataTransaction) throws -> Void,
                        completion: ((Swift.Result<Any?, Error>) -> Void)?) {
        self.dataStack.perform(
            asynchronous: { (transaction) -> Void in
                try task(transaction)
        },
            completion: { (result) -> Void in
                switch result {
                case .success(let userInfo):
                    completion?(.success(userInfo))
                case .failure(let error):
                    completion?(.failure(error))
                }
        })
    }

    public func fetchExisting<D: NSManagedObject>(_ object: D) -> D? {
        return self.dataStack.fetchExisting(object)
    }

    public func fetchOne<D: NSManagedObject>(from: D.Type, where predicate: NSPredicate? = nil) -> D? {
        var result: D? = nil
        do {
            if let newPredicate = predicate {
                result = try self.dataStack.fetchOne(From<D>(), Where<D>(newPredicate), Tweak { (fetchRequest) -> Void in
                    fetchRequest.returnsObjectsAsFaults = false
                })
            } else {
                result = try self.dataStack.fetchOne(From<D>())
            }
        } catch {
            print("\(D.description()) can't by fatched by reason of error: \(error.localizedDescription)")
        }
        return result
    }

    public func fetchAll<D: NSManagedObject>(from: D.Type, where wherePredicate: NSPredicate? = nil, orderBy orderByPredicate: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: false) ) -> [D]? {
        var result: [D]? = nil
        do {
            if let newWherePredicate = wherePredicate {
                result = try self.dataStack.fetchAll(From<D>(), Where<D>(newWherePredicate), OrderBy<D>(orderByPredicate))
            } else {
                result = try self.dataStack.fetchAll(From<D>(), OrderBy<D>(orderByPredicate))
            }
        } catch {
            print("Array of \(D.description()) can't by fatched by reason of error: \(error.localizedDescription)")
        }
        return result
    }

    private let sIdKey = "S.UserDefaults.sIdKey"
    public func sId() -> Int64 {
        objc_sync_enter(UserDefaults.standard)
        defer { objc_sync_exit(UserDefaults.standard) }
        let sId = UserDefaults.standard.object(forKey: sIdKey) as? Int64 ?? Int64(-1)
        UserDefaults.standard.set(sId-1, forKey: sIdKey)
        return sId
    }

    /// If even one of list element is not nil than function returns true
    public func transactionShouldBePerformed(with parameters: [Any?]) -> Bool {
        for parameter in parameters {
            if parameter != nil {
                return true
            }
        }
        return false
    }
}
