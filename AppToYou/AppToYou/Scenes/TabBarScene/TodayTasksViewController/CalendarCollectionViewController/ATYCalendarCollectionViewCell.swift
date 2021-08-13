//
//  ATYCalendarCollectionViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
import UIKit

class ATYCalendarCollectionViewCell: UICollectionViewCell {

    var dayOfWeekLabel = UILabel()
    var dayOfMonthLabel = UILabel()
    var selectedView = UIView()
    var circleView = UIView()


    override func prepareForReuse() {
        super.prepareForReuse()
        dayOfWeekLabel.text = nil
        dayOfMonthLabel.text = nil
        selectedView.backgroundColor = .clear
        circleView.backgroundColor = .clear
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(selectedView)
        addSubview(dayOfWeekLabel)
        addSubview(dayOfMonthLabel)
        addSubview(circleView)

        selectedView.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOfMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false

        selectedView.backgroundColor = .clear
        selectedView.layer.cornerRadius = 18

        dayOfWeekLabel.font = UIFont.systemFont(ofSize: 13)
        dayOfWeekLabel.sizeToFit()
        dayOfWeekLabel.textColor = #colorLiteral(red: 0.6196078431, green: 0.6156862745, blue: 0.6431372549, alpha: 1)
        dayOfWeekLabel.textAlignment = .center
        dayOfMonthLabel.font = UIFont.systemFont(ofSize: 16)
        dayOfMonthLabel.textAlignment = .center
        dayOfMonthLabel.sizeToFit()

        dayOfMonthLabel.textColor = .black

        circleView.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.6156862745, blue: 0.6431372549, alpha: 1)
        circleView.layer.cornerRadius = 5

        NSLayoutConstraint.activate([
            selectedView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            selectedView.topAnchor.constraint(equalTo: self.topAnchor),
            selectedView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            selectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])


        NSLayoutConstraint.activate([
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            dayOfWeekLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            dayOfWeekLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])

        NSLayoutConstraint.activate([
            dayOfMonthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dayOfMonthLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor),
            dayOfMonthLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            dayOfMonthLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: dayOfMonthLabel.centerXAnchor),
            circleView.topAnchor.constraint(equalTo: self.dayOfMonthLabel.bottomAnchor, constant: 3),
            circleView.heightAnchor.constraint(equalToConstant: 7),
            circleView.widthAnchor.constraint(equalToConstant: 7)
        ])
    }

    func setUp() {

        dayOfWeekLabel.textColor = .white
        dayOfMonthLabel.textColor = .white
        if circleView.backgroundColor == R.color.failureColor() {
            selectedView.backgroundColor = R.color.failureColor()
        } else if circleView.backgroundColor == R.color.succesColor() {
            selectedView.backgroundColor = R.color.succesColor()
        } else {
            selectedView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.6666666667, blue: 0.05490196078, alpha: 1)
        }
        circleView.backgroundColor = .white
    }

    func setUpAnother(indexPath: IndexPath) {
        selectedView.backgroundColor = .clear
        dayOfWeekLabel.textColor = #colorLiteral(red: 0.6196078431, green: 0.6156862745, blue: 0.6431372549, alpha: 1)
        dayOfMonthLabel.textColor = .black
        circleView.backgroundColor = indexPath.row % 2 == 0 ? R.color.succesColor() : R.color.failureColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var date: Date?
}
