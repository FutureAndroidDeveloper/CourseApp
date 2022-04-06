import UIKit


class ATYCalendarCollectionViewCell: UICollectionViewCell {

    var dayOfWeekLabel = UILabel()
    var dayOfMonthLabel = UILabel()
    
    var selectedView = UIView()
    var circleView = UIView()

    private var model: CalendarCellModel?

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
//        circleView.layer.cornerRadius = 5

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
            circleView.heightAnchor.constraint(equalToConstant: 6),
            circleView.widthAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = circleView.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CalendarCellModel) {
        self.model = model
        dayOfWeekLabel.text = model.weekdayTitle
        dayOfMonthLabel.text = model.dateLabel
        circleView.backgroundColor = model.progress.color
        
        model.selectHandler = { [weak self] isSelected in
            guard let model = self?.model else {
                return
            }
            let backColor = isSelected ? model.progress.backgroundColor : .clear
            self?.selectedView.backgroundColor = backColor
            let _ = isSelected ? self?.setSelectedColors() : self?.setDeselectedColors()
        }
        
        model.selectHandler?(model.isSelected)
    }
    
    private func setSelectedColors() {
        dayOfWeekLabel.textColor = R.color.backgroundTextFieldsColor()
        dayOfMonthLabel.textColor = R.color.backgroundTextFieldsColor()
        circleView.backgroundColor = R.color.backgroundTextFieldsColor()
    }
    
    private func setDeselectedColors() {
        dayOfWeekLabel.textColor = R.color.textSecondaryColor()
        dayOfMonthLabel.textColor = R.color.titleTextColor()
        circleView.backgroundColor = model?.progress.color
    }

}
