import Foundation

/**
 Запрос, который может содержать тело и url параметры.
 */
class RequestWithParameters<Body: Encodable>: HTTPTask {

    private let encoding: ParameterEncoding
    private let body: Body?
    private let urlParameters: [Parameter]?
    
    /**
     Создание запроса только с телом.

     - parameters:
       - body: тело запроса.
     */
    convenience init(body: Body) {
        self.init(encoding: .jsonEncoding, body: body, urlParameters: nil)
    }

    /**
     Создание запроса c телом и url параметрами.

     - parameters:
        - body: тело запроса.
        - urlParameters: url параметры запроса.
     */
    convenience init(body: Body, urlParameters: [Parameter]) {
        self.init(encoding: .urlAndJsonEncoding, body: body, urlParameters: urlParameters)
    }

    /**
     Создание запроса.

     - parameters:
        - encoding: часть данных, которая кодируется для запроса.
        - body: тело запроса.
        - urlParameters: url параметры запроса.
     */
    init(encoding: ParameterEncoding, body: Body?, urlParameters: [Parameter]?) {
        self.body = body
        self.encoding = encoding
        self.urlParameters = urlParameters
    }

    func prepare(for request: inout URLRequest) {
        try? encoding.encode(urlRequest: &request, body: body, urlParameters: urlParameters)
    }

}
