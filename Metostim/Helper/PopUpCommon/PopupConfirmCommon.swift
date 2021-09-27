//
//  PopupConfirmCommon.swift
//  AirVting
//
//  Created by Giêng Thành on 10/5/18.
//  Copyright © 2018 Admin. All rights reserved.
//


import UIKit

class PopupConfirmCommon: UIView, UIGestureRecognizerDelegate {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tapAbleView: UIView!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnCancel: UIButton!

    var acceptTouchedBlock: (() -> Void)?
    var rejectTouchedBlock: (() -> Void)?
    var tap:UITapGestureRecognizer?
//    class var instance : PopupConfirmCommon {
//        struct Static {
//            static let inst : PopupConfirmCommon = PopupConfirmCommon ()
//        }
//        return Static.inst
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromNib()
    }
    
    @IBAction func didTouchOk(_ sender: Any) {
        if self.acceptTouchedBlock != nil {
            self.acceptTouchedBlock!()
        }
        self.dismiss()
    }
    
    @IBAction func didTouchReject(_ sender: Any) {
        if self.rejectTouchedBlock != nil {
            self.rejectTouchedBlock!()
        }
        self.dismiss()
    }
    
    func dismiss() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion:{[weak self](finished: Bool) in
            if (finished){
                DispatchQueue.main.async {
                    self?.removeFromSuperview()
                }
            }
        }
        );
        self.rejectTouchedBlock = nil
        self.acceptTouchedBlock = nil

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    func loadViewFromNib() {
        let nib = UINib(nibName: "PopupConfirmCommon", bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.touchHappen(_:)))
        self.tap?.delegate = self
        self.tapAbleView.addGestureRecognizer(self.tap!)
        self.tapAbleView.isUserInteractionEnabled = true
        self.vContent.layer.cornerRadius = 10
        self.vContent.layer.masksToBounds = true
        self.addSubview(view)
    }
    
    @objc func touchHappen(_ sender: UITapGestureRecognizer) {
        self.dismiss()
    }
    
    func showPopup(isRemoveAllSubview:Bool) {
        let screenSize: CGRect = UIScreen.main.bounds
        self.frame = screenSize
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let window = UIApplication.shared.keyWindow
        if isRemoveAllSubview {
            if let tap = self.tap {
                self.tapAbleView.removeGestureRecognizer(tap)
            }
            for subview in window?.subviews ?? [] {
                if subview is PopupConfirmCommon {
                    DispatchQueue.main.async {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
        window!.addSubview(self)
//        window?.bringSubview(toFront: self)
        self.alpha = 0.0
        UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.vContent {
            return false
        }
        return true
    }
    
    class func showRequestPopup(strMgs:String, strTitle:String, strActionTitle:String? = nil, isShowCloseButton:Bool = false, isRemoveAllSubview:Bool = false , acceptBlock: (() -> Void)? = nil, rejectBlock: (() -> Void)? = nil){
        DispatchQueue.main.async {
            let view = PopupConfirmCommon(frame: UIScreen.main.bounds)
            if let actionTitle = strActionTitle {
                view.btnOk.setTitle(actionTitle, for: .normal)
            }
            else {
                view.btnOk.setTitle("OK", for: .normal)
            }

            if !isShowCloseButton {
                view.btnCancel.isHidden = true
            }
            view.lblDes.text = strMgs
            view.lblTitle.text = strTitle
            view.acceptTouchedBlock = acceptBlock
            view.rejectTouchedBlock = rejectBlock
            view.showPopup(isRemoveAllSubview: isRemoveAllSubview)
        }
    }
}




