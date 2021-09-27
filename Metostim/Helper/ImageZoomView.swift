//
//  ImageZoomView.swift
//  Fingerprint
//
//  Created by admin on 10/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ImageZoomView: UIScrollView,UIScrollViewDelegate {
    var imageView: UIImageView!

    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)

        // Creates the image view and adds it as a subview to the scroll view
        imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)

        setupScrollView()
       // setupGestureRecognizer()
    }
    
    func setupScrollView() {
           delegate = self
       }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
//    func setupGestureRecognizer() {
//        gestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
//        gestureRecognizer.numberOfTapsRequired = 2
//        addGestureRecognizer(gestureRecognizer)
//    }
}
