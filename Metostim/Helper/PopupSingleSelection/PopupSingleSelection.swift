//
//  PopupSingleSelection.swift
//  VSSHR
//
//  Created by admin on 23/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class PopupSingleSelection:UIView, UIGestureRecognizerDelegate {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tapAbleView: UIView!
    //    @IBOutlet weak var lblDes: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tblSelection: UITableView!
    var arrSelectionData = [CountryData]()
    var selUnselModel = [true,false,false]
        
    var acceptTouchedBlock: ((String?,String?) -> Void)?
    var rejectTouchedBlock: (() -> Void)?
    var tap:UITapGestureRecognizer?
    var selectedCountry : (String?,String?)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromNib()
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBAction func didTouchOk(_ sender: Any) {
        if self.acceptTouchedBlock != nil {
            for item in arrSelectionData {
                if item.isSelected {
                    self.acceptTouchedBlock!(item.countryName,item.countrycode)
                }
            }
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
        self.rejectTouchedBlock = nil
        self.acceptTouchedBlock = nil
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    func loadViewFromNib() {
        let nib = UINib(nibName: "PopupSingleSelection", bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        
//        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.touchHappen(_:)))
//        self.tap?.delegate = self
//        self.tapAbleView.addGestureRecognizer(self.tap!)
//        self.tapAbleView.isUserInteractionEnabled = true
        self.vContent.layer.cornerRadius = 10
        self.vContent.layer.masksToBounds = true
        self.addSubview(view)
        tblSelection.register(UINib(nibName: "PopupSingleSelectionCell", bundle: nil), forCellReuseIdentifier: "PopupSingleSelectionCell")
//        var sele = SelectUnselectModel()
//        sele.isSelected = true
        self.tblSelection.delegate = self
        self.tblSelection.dataSource = self

//        var sele1 = SelectUnselectModel()
//        sele1.isSelected = false
//
//        var sele2 = SelectUnselectModel()
//        sele2.isSelected = false
//
//        selUnselModel = [sele,sele1,sele2]
    }
    
    @objc func touchHappen(_ sender: UITapGestureRecognizer) {
       // self.dismiss()
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
                if subview is PopupSingleSelection {
                    DispatchQueue.main.async {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
        if !isRemoveAllSubview {
            window!.addSubview(self)
        }
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
    
    class func showRequestPopup(dataArr : Any,strMgs:String,placeholder : String, strTitle:String, strActionTitle:String? = nil, isShowCloseButton:Bool = true, isRemoveAllSubview:Bool = false , acceptBlock: ((String?,String?) -> Void)? = nil, rejectBlock: (() -> Void)? = nil){
        DispatchQueue.main.async {
        
            let view = PopupSingleSelection(frame: UIScreen.main.bounds)
            view.tag = 1000
            if let actionTitle = strActionTitle {
                view.btnOk.setTitle(actionTitle, for: .normal)
            }
            else {
                view.btnOk.setTitle("OK", for: .normal)
            }
            view.btnOk.setTitle("OK", for: .normal)
            if !isShowCloseButton {
                view.btnClose.isHidden = true
            }
            if dataArr is [CountryData] {
                view.arrSelectionData = dataArr as! [CountryData]
            }
            // view.lblDes.text = strMgs
            view.lblTitle.text = strTitle
            //  view.lblDes.placeholder = placeholder
            view.acceptTouchedBlock = acceptBlock
            view.rejectTouchedBlock = rejectBlock
            view.showPopup(isRemoveAllSubview: isRemoveAllSubview)
            
        }
    }
}

extension PopupSingleSelection : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSelection.dequeueReusableCell(withIdentifier: "PopupSingleSelectionCell", for: indexPath)  as! PopupSingleSelectionCell
        cell.leaveType.text = arrSelectionData[indexPath.row].countryName
        
        if arrSelectionData[indexPath.row].isSelected == true {
            cell.imgSelectUnselect.image = UIImage(named: "circleselectfill")
        }else {
            cell.imgSelectUnselect.image = UIImage(named: "circleunselect")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // changeSelection(indexPath: indexPath.row)
    
        if arrSelectionData[indexPath.row].isSelected == true {
            arrSelectionData[indexPath.row].isSelected = false
        }else {
            arrSelectionData[indexPath.row].isSelected = true
        }
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        changeSelection(indexPath: indexPath.row)
//
//    }
    
    func changeSelection(indexPath : Int)  {
//        selUnselModel.removeAll()
//        for i in 0..<3 {
//            if i == indexPath {
//                selUnselModel.append(true)
//            }else {
//                selUnselModel.append(false)
//            }
//        }
        tblSelection.reloadData()
    }
}


class SelectUnselectModel {
    var isSelected = false
}
