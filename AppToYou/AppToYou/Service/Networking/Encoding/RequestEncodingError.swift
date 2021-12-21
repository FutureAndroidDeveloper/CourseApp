import Foundation


/**
 Ошибки кодирования запроса.
 */
public enum RequestEncodingError : String, Error {
    case parametersNil = "Parameters were nil."
    case bodyEncodingFailed = "Body encoding failed."
    case missingURL = "URL is nil."
}
