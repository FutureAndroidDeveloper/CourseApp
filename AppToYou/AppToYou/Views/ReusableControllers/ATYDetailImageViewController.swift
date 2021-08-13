//
//  ATYDetailImageViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 09.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYDetailImageViewController: UIViewController {

    private var imageScrollView: ImageScrollView!

    private let image: UIImage

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()

        self.imageScrollView = ImageScrollView(frame: view.frame)

        view.addSubview(self.imageScrollView)
        self.imageScrollView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        self.imageScrollView.set(image: image)
    }
}

//MARK:- Custom UIScrollView

/// Custom Scroll view for zooming, scrolling and centered current image
class ImageScrollView: UIScrollView {

    //MARK:- Properties

    private var imageZoomView = UIImageView()

    lazy private var zoomingTapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        tapGestureRecognizer.numberOfTapsRequired = 2
        return tapGestureRecognizer
    }()

    //MARK:- Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        decelerationRate = .fast
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Life cucle methods

    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }

    //MARK:- Handlers

    @objc private func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        zoom(point: location, animated: true)
    }

    //MARK:- Public methods

    func set(image: UIImage) {
        self.imageZoomView.removeFromSuperview()
        //self.imageZoomView = nil

        self.imageZoomView = UIImageView(image: image)
        self.addSubview(self.imageZoomView)

        self.configureFor(imageSize: image.size)
    }

    //MARK:- Private methods

    private func configureFor(imageSize: CGSize) {
        contentSize = imageSize
        self.setCurrentZoomScale()
        zoomScale = minimumZoomScale
        self.imageZoomView.addGestureRecognizer(self.zoomingTapGestureRecognizer)
        self.imageZoomView.isUserInteractionEnabled = true
    }

    private func setCurrentZoomScale() {
        let boundSize = bounds.size
        let imageSize = self.imageZoomView.bounds.size

        let xScale = boundSize.width/imageSize.width
        let yScale = boundSize.height/imageSize.height

        let minScale = min(xScale, yScale)

        minimumZoomScale = minScale

        var maxScale: CGFloat = 1.0

        if minScale < 0.1 {
            maxScale = 0.3
        }
        else if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        else if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }

        maximumZoomScale = maxScale
    }

    private func centerImage() {
        let boundsSize = self.bounds.size
        var frameToCenter = self.imageZoomView.frame

        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width)/2
        } else {
            frameToCenter.origin.x = 0
        }

        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height)/2
        } else {
            frameToCenter.origin.y = 0
        }

        self.imageZoomView.frame = frameToCenter
    }

    private func zoom(point: CGPoint, animated: Bool) {
        let correctScale = zoomScale
        let minScale = minimumZoomScale
        let maxScale = maximumZoomScale

        if minScale == maxScale && minScale > 1 {
            return
        }

        let toScale = maxScale
        let finalScale = (correctScale == minScale) ? toScale : minScale

        let zoomRect = self.zoomRect(scale: finalScale, center: point)

        zoom(to: zoomRect, animated: animated)
    }

    private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero

        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale

        zoomRect.origin.x = center.x - (zoomRect.size.width/2)
        zoomRect.origin.y = center.y - (zoomRect.size.height/2)
        return zoomRect
    }
}

//MARK:- Extensions

extension ImageScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
}
