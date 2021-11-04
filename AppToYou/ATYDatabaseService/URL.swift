
import Foundation
import MobileCoreServices

public extension URL {

    private var utiCFString: CFString? {
        return UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension as CFString, nil)?.takeRetainedValue()
    }

    var uti: String? {
        return self.utiCFString as String?
    }

    var mime: String? {
        guard let utiCFString = self.utiCFString else {
            return nil
        }
        return UTTypeCopyPreferredTagWithClass(utiCFString, kUTTagClassMIMEType)?.takeRetainedValue() as String?
    }

    func relativePath(to url: URL) -> String {
        var toPathComponents: [String] = url.pathComponents.reversed()
        var selfPathComponents: [String] = self.pathComponents.reversed()
        while !toPathComponents.isEmpty {
            if selfPathComponents.last == toPathComponents.removeLast() {
                selfPathComponents.removeLast()
            } else {
                fatalError("URL(\(self)) does not relative to: \(url)")
            }
        }
        return selfPathComponents.reversed().joined(separator: "/")
    }
}
