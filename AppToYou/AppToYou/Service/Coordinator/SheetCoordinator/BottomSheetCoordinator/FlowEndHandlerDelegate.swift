import Foundation


/**
 Протокол оповещения корневого координатора о необходимости закончить flow.
 
 Используется для работы BottomSheet
 */
protocol FlowEndHandlerDelegate: AnyObject {
    func flowDidEnd()
}
