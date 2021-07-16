//
//  ATYStackProgressView.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYStackProgressView: UIView {
    var stackView: UIStackView!
    var countOfViews: (count: Int , typeState: [CurrentStateTask])? {
        willSet {
            stackView.removeFromSuperview()
            views.removeAll()
            for i in 0..<(newValue?.count ?? 0) {
                let view = UIView()
                var backColor: UIColor?
                let state = newValue?.typeState[i]
                switch state {
                case .didNotStart:
                    backColor = R.color.backgroundButtonCard()
                case .done:
                    backColor = R.color.succesColor()
                case .performed:
                    backColor = R.color.textColorSecondary()
                case .failed:
                    backColor = R.color.failureColor()
                default: break
                }
                view.backgroundColor = backColor
                views.append(view)
            }
            layoutSubviews()
        }
    }
    var views = [UIView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureStackView()
    }

    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5

        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
