//
//  ATYTodayTasksViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

protocol ATYTodayTasksViewModelDelegate : class {
    func updateData()
}

class ATYTodayTasksViewModel {

    var userTasks : [ATYUserTask]?
    var currentTasksArray = [ATYUserTask]()
    var completedTasksArray = [ATYUserTask]()

    weak var delegate : ATYTodayTasksViewModelDelegate?

    func getData() {
        guard let dbService = try? ATYDatabaseService() else {
            return
        }

        let parser = ATYParser()

        guard  let userTasks = dbService.getAllUserTasks() else { return }

        let parsedUserTasks = parser.prepareToDisplay(userTasks: userTasks)

        self.userTasks = parsedUserTasks

        self.currentTasksArray = parsedUserTasks
//        self.completedTasksArray = self.userTasks?.filter({ $0.taskCompleteTime?.toDate(dateFormat: .simpleDateFormat) ?? Date() >= Date() }) ?? []

        self.delegate?.updateData()
    }
}
