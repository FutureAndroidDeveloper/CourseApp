
import Foundation
import var CommonCrypto.CC_SHA256_DIGEST_LENGTH
import func CommonCrypto.CC_SHA256
import typealias CommonCrypto.CC_LONG

public extension FileManager {

    struct Directory {
        static let home = Directory(url: URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true))
        public static let documents = Directory(parent: .home, name: "Documents")
        public static let library = Directory(parent: .home, name: "Library")
        public static let preferences = Directory(parent: .library, name: "Preferences")
        public static let database = Directory(parent: .preferences, name: "Database")
        public static let backups = Directory(parent: .preferences, name: "Backups")
        public static let temp = Directory(parent: .home, name: "tmp")

        public let url: URL

        init(url: URL) {
            self.url = url
            self.createDirectoryIfNeeded()
        }

        init(parent: Directory, name: String) {
            self.url = parent.url.appendingPathComponent(name, isDirectory: true)
            self.createDirectoryIfNeeded()
        }

        func generateLocalURL(forFile file: String) -> URL? {
            guard let url = URL(string: file) else {
                return nil
            }
            return self.generateLocalURL(for: url)
        }

        func relativePath(to directory: FileManager.Directory) -> String {
            return self.url.relativePath(to: directory.url)
        }

        func generateLocalURL(for url: URL) -> URL? {
            guard let data = url.lastPathComponent.data(using: .utf8) else {
                return nil
            }

            var hash = [UInt8](repeating: 0,
                               count: Int(CC_SHA256_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
            }
            let newFileName = Data(hash).map { String(format: "%02hhx", $0) }.joined()

            return self.url.appendingPathComponent(newFileName).appendingPathExtension(url.pathExtension)
        }

        func createDirectoryIfNeeded() {
            if !FileManager.default.fileExists(atPath: self.url.path) {
                do {
                    try FileManager.default.createDirectory(at: self.url, withIntermediateDirectories: true)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    @discardableResult
    func write(data: Data, options: Data.WritingOptions = .atomic, to directory: Directory, filename: String = NSUUID().uuidString, extension: String) throws -> URL {
        if !self.fileExists(atPath: directory.url.path) {
            try self.createDirectory(at: directory.url, withIntermediateDirectories: true, attributes: nil)
        }
        let filePath = directory.url.appendingPathComponent(filename).appendingPathExtension(`extension`)
        try data.write(to: filePath, options: options)

        return filePath
    }
}
