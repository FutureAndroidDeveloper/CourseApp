import Foundation


/**
 Пустое тело запроса.
 
 Используется для коректной работы создания запроса без тела.
 */
struct EmptyBody: Encodable {
}


/**
 Создание запроса с пустым телом.
 */
extension RequestWithParameters where Body == EmptyBody {
    
    /**
     Создание запроса только с url параметрами.

     - parameters:
       - urlParameters: url параметры запроса.
     */
    convenience init(urlParameters: [Parameter]) {
        self.init(encoding: .urlEncoding, body: nil, urlParameters: urlParameters)
    }
    
}
