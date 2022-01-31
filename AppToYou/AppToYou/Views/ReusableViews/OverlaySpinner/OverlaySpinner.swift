import UIKit


class OverlaySpinner: UIView {

    private var isSpinning: Bool = false

    private lazy var spinner : UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        self.isSpinning = false
        self.isHidden = true
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.removeFromSuperview()
    }
    
    func show() -> Void {
        DispatchQueue.main.async {
            if !self.spinner.isAnimating {
                self.spinner.startAnimating()
            }
            self.isHidden = false
        }
        isSpinning = true
    }

    func hide() -> Void {
        DispatchQueue.main.async {
            if self.spinner.isAnimating {
                self.spinner.stopAnimating()
            }
            self.isHidden = true
        }
        isSpinning = false
    }

    private func configure() -> Void {
        addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
