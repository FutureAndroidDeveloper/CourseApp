import UIKit
import SHSearchBar
import SnapKit

enum CourseSearchSelection {
    case all
    case my
}

protocol CourseSearchDelegate: AnyObject {
    func searchText(_ text: String)
}


class CourseSearchView: UIView, SHSearchBarDelegate {
    private struct Constants {
        struct Timer {
            typealias Info = [String: String]
            static let textKey = "text"
            static let throttleDuration: TimeInterval = 0.6
        }
    }
    weak var delegate: CourseSearchDelegate?

    private let filterModel: CoursesFilterModel
    
    private var selectedSection = CourseSearchSelection.all
    private var highlightAllCoursesConstraint: Constraint?
    private var highlightMyCoursesConstraint: Constraint?

    private let searchBar = DefaultSearchBar(placeholder: "Поиск по курсам")
    private let filterContainerView = UIView()
    private let categoryFilterView = CategoryFilterView()
    private let membershipFilterView = MembershipFilterView()
    
    private var throttleTimer: Timer?
    
    private let allCoursesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Все курсы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        return button
    }()

    private let myCoursesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Мои курсы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        return button
    }()

    private let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.textColorSecondary()
        view.snp.makeConstraints {
            $0.height.equalTo(3)
        }
        return view
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lineViewBackgroundColor()
        view.alpha = 0.2
        view.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return view
    }()
    
    init(filterModel: CoursesFilterModel) {
        self.filterModel = filterModel
        super.init(frame: .zero)
        setup()
        configureInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        throttleTimer?.invalidate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let highlightCornerRadius: CGFloat = 10
        highlightView.roundCorners(corners: [.topLeft, .topRight], radius: highlightCornerRadius)
    }

    private func setup() {
        let leadingGuide = UILayoutGuide()
        let middleGuide = UILayoutGuide()
        let trailingGuide = UILayoutGuide()
        addLayoutGuide(leadingGuide)
        addLayoutGuide(middleGuide)
        addLayoutGuide(trailingGuide)
        addSubview(allCoursesButton)
        addSubview(myCoursesButton)
        addSubview(highlightView)
        addSubview(lineView)
        addSubview(searchBar)
        addSubview(filterContainerView)
        
        leadingGuide.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(middleGuide.snp.width)
        }
        
        allCoursesButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(leadingGuide.snp.trailing)
            $0.width.equalTo(myCoursesButton.snp.width)
        }
        
        middleGuide.snp.makeConstraints {
            $0.leading.equalTo(allCoursesButton.snp.trailing)
            $0.trailing.equalTo(myCoursesButton.snp.leading)
            $0.width.equalTo(trailingGuide.snp.width)
        }
        
        myCoursesButton.snp.makeConstraints {
            $0.top.equalTo(allCoursesButton.snp.top)
            $0.trailing.equalTo(trailingGuide.snp.leading)
        }
        
        trailingGuide.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        highlightView.snp.makeConstraints {
            $0.width.equalTo(71)
            self.highlightAllCoursesConstraint = $0.centerX.equalTo(allCoursesButton.snp.centerX).constraint
            self.highlightMyCoursesConstraint = $0.centerX.equalTo(myCoursesButton.snp.centerX).constraint
            $0.bottom.equalTo(lineView.snp.top)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(allCoursesButton).offset(8)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(16)
            $0.height.equalTo(44)
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
        
        filterContainerView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.height.equalTo(44)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        allCoursesButton.addTarget(self, action: #selector(selectAllCourses), for: .touchUpInside)
        myCoursesButton.addTarget(self, action: #selector(selectMyCourses), for: .touchUpInside)
    }

    private func configureInitialState() {
        searchBar.setSearchBarDelegate(self)
        highlightAllCoursesConstraint?.isActive = false
        selectedSection = .my
        selectAllCourses()
    }
    
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        throttleTimer?.invalidate()
        throttleTimer = Timer.scheduledTimer(
            timeInterval: Constants.Timer.throttleDuration,
            target: self,
            selector: #selector(performSearch(_:)),
            userInfo: [Constants.Timer.textKey: text],
            repeats: false
        )
    }
    
    @objc
    func performSearch(_ sender: Timer) {
        guard
            let userInfo = sender.userInfo as? Constants.Timer.Info,
            let text = userInfo[Constants.Timer.textKey]
        else {
            return
        }
        delegate?.searchText(text)
    }
    
    @objc
    private func selectAllCourses() {
        guard selectedSection != .all else {
            return
        }
        filterModel.activateCategoryFilters()
        categoryFilterView.confugire(with: filterModel.activeFilters)
        animateSelection(.all)
    }

    @objc
    private func selectMyCourses() {
        guard selectedSection != .my else {
            return
        }
        filterModel.activateMemebershipFilters()
        membershipFilterView.confugire(with: filterModel.activeFilters)
        animateSelection(.my)
    }
    
    private func animateSelection(_ selection: CourseSearchSelection) {
        var filterToRemove: UIView
        var filterToAdd: UIView
        var allCoursesFont: UIFont
        var myCoursesFont: UIFont
        
        switch selection {
        case .all:
            filterToRemove = membershipFilterView
            filterToAdd = categoryFilterView
            allCoursesFont = UIFont.systemFont(ofSize: allCoursesButton.titleLabel?.font.pointSize ?? .zero, weight: .semibold)
            myCoursesFont = UIFont.systemFont(ofSize: myCoursesButton.titleLabel?.font.pointSize ?? .zero, weight: .regular)
        case .my:
            filterToRemove = categoryFilterView
            filterToAdd = membershipFilterView
            myCoursesFont = UIFont.systemFont(ofSize: myCoursesButton.titleLabel?.font.pointSize ?? .zero, weight: .semibold)
            allCoursesFont = UIFont.systemFont(ofSize: allCoursesButton.titleLabel?.font.pointSize ?? .zero, weight: .regular)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.highlightMyCoursesConstraint?.isActive.toggle()
            self.highlightAllCoursesConstraint?.isActive.toggle()
            self.allCoursesButton.titleLabel?.font = allCoursesFont
            self.myCoursesButton.titleLabel?.font = myCoursesFont
            
            filterToRemove.removeFromSuperview()
            self.filterContainerView.addSubview(filterToAdd)
            filterToAdd.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
        selectedSection = selection
    }
}
