import Foundation


public typealias HTTPHeaders = [String: String]

protocol HTTPTask {
    func prepare(for request: inout URLRequest)
}
