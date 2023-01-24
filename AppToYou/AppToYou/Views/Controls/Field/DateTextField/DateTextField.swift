//
//  DateTextField.swift
//  AppToYou
//
//  Created by mac on 17.12.21.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation


class DateTextField: BaseField<Date?> {
    
    override func setContentModel(_ model: BaseFieldModel<Date?>) {
        super.setContentModel(model)
        text = model.value?.toString(dateFormat: .simpleDateFormatFullYear)
    }
    
}
