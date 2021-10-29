//
//  HomeInfoVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD
import Kingfisher
import ImageSlideshow
import iOSDropDown
import CoreData

class HomeInfoVC: UIViewController {
    
    var context = Metostim.SharedObject.kAppDelegate.persistentContainer.viewContext

    @IBOutlet var slideshow: ImageSlideshow!
    
    @IBOutlet var txtBirdType: DropDown!
    @IBOutlet var txtCliate: DropDown!
    @IBOutlet var txtNumberOfBirds: UITextField!
    @IBOutlet var txtFrom: UITextField!
    @IBOutlet var txtTo: UITextField!
    @IBOutlet var txtInLitr: UITextField!
    @IBOutlet var txtInGrm: UITextField!
    @IBOutlet var txtInMl: UITextField!
    
    @IBOutlet var imgBirds: UIImageView!

    var items: [Int] = []
    var strBannerImages = [ImageImageSource]()
    var arrBanners : [BannersDataModel]?
    var arrBirdType : [BirdTypeDataModel]?
    var arrClimate : [BirdTypeDataModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllBanners()
        
        setUpUI()
        txtBirdType.isSearchEnable = false
        txtCliate.isSearchEnable = false
        txtBirdType.didSelect { (str, value1, value2) in
            let coreArrBirdsType = self.getAllItemsGetBirdsTypeEntity()

            if coreArrBirdsType != nil && coreArrBirdsType?.count ?? 0  > 0  {
                for item in coreArrBirdsType! {
                    if "\(item.birds_Name!)" == str {
                        if "\(item.climate_name!)" == self.txtCliate.text {
                            self.imgBirds.image = self.convertBase64ToImage(imageString: item.birds_Image ?? "")
                        }
                    }
                }
            }else {
                for item in self.arrBirdType! {
                    if "\(item.birds_Name!)" == str {
                        if "\(item.climate_name!)" == self.txtCliate.text {
                            self.imgBirds.image = self.convertBase64ToImage(imageString: item.birds_Image ?? "")
                        }
                    }
                }
            }

        }
        txtCliate.didSelect { (str, value1, value2) in
            self.txtCliate.text = str
            let coreArrBirdsType = self.getAllItemsGetBirdsTypeEntity()

            if coreArrBirdsType != nil && coreArrBirdsType?.count ?? 0  > 0  {
                for item in coreArrBirdsType! {
                    if "\(item.birds_Name!)" == "\(self.txtBirdType.text!)" {
                        if "\(item.climate_name!)" == str {
                            self.imgBirds.image = self.convertBase64ToImage(imageString: item.birds_Image ?? "")
                        }
                    }
                }
            }else {
                for item in self.arrBirdType! {
                    if "\(item.birds_Name!)" == "\(self.txtBirdType.text!)" {
                        if "\(item.climate_name!)" == str {
                            self.imgBirds.image = self.convertBase64ToImage(imageString: item.birds_Image ?? "")
                        }
                    }
                }
            }


        }
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
           let imageData = Data(base64Encoded: imageString,
                                options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
           return UIImage(data: imageData)!
       }
    
    func setUpUI()  {
       // txtBirdType = txtBirdType.frame.height/2
      //  txtCliate.cornerRadius = txtCliate.frame.height/2
        txtNumberOfBirds.cornerRadius = txtNumberOfBirds.frame.height/2
        txtFrom.cornerRadius = txtFrom.frame.height/2
        txtTo.cornerRadius = txtTo.frame.height/2
        txtInLitr.cornerRadius = txtInLitr.frame.height/2
        txtInGrm.cornerRadius = txtInGrm.frame.height/2
        txtInMl.cornerRadius = txtInMl.frame.height/2

    }
    
    @IBAction func btnActionCalculate(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.txtNumberOfBirds.text == "" {
            Toast.init(text: "number of birds required").show()
            return
        }
        let from = Int(txtFrom.text ?? "0")
        let toVal = Int(txtTo.text ?? "0")

        if from ?? 0 > toVal ?? 0  {
            Toast.init(text: "from value cannot be greater than To value").show()
            return
        }
        getAllFormulaData()
    }
    
    @IBAction func btnActionLogout(_ sender: UIButton) {
       logOut()
    }
    
    func toggleLeftSlide(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    func logOut(){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navi = UINavigationController(rootViewController: self.getStartVC())
            appDelegate.window?.rootViewController = navi
        AccountInfo.shared.clearAccountInfo()
        UserDefaults.standard.synchronize()
    }
    
    func getStartVC() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        return mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    }
}



extension HomeInfoVC {
    func getAllBanners()  {
        
        let coreArrBanners = self.getAllItemsGetBannersEntity()

        if coreArrBanners != nil && coreArrBanners?.count ?? 0  > 0  {
            
            for item in coreArrBanners! {
                let img = self.convertBase64ToImage(imageString: item.fileStream ?? "")
                self.strBannerImages.append(ImageImageSource(imageString: img))
            }
               
            self.navigationController?.isNavigationBarHidden = true
            self.slideshow.layer.cornerRadius = 0
            self.slideshow.clipsToBounds = true
               
            self.slideshow.slideshowInterval = 2.0
               // slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
            self.slideshow.contentScaleMode = UIView.ContentMode.redraw
               // let pageControl = UIPageControl()
               // pageControl.currentPageIndicatorTintColor = UIColor.colorWithHexString(hexStr: "#43ffa7")//UIColor.green//UIColor(hexString: "#EC7700")
               // pageControl.pageIndicatorTintColor = UIColor.gray//UIColor(hexString: "#A9A9A9")
               // slideshow.pageIndicator = pageControl
               //dcrTblCell.slideshow.activityIndicator =
            self.slideshow.currentPageChanged = { [unowned self] page in
                   //            print("current page:", page)
               }//            if #available(iOS 14.0, *) {
            self.slideshow.setImageInputs(self.strBannerImages)
            self.getAllBirdType()
        }else {
            let loginDicParametrs = NSMutableDictionary()

            WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.GetBanners, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
                guard let owner = self else {return}
                if status == true{
                    if message != nil && message != "" {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                        })
                        return
                    }
                    
                    let countryData = try? JSONDecoder().decode(BannersModel.self, from: (json.rawData()))
                    self?.arrBanners = countryData?.data
                    
                
                    for formulaData in self!.arrBanners! {
                        let items = NSEntityDescription.insertNewObject(forEntityName: "BannersEntity", into: self!.context) as! BannersEntity
                        items.filename = formulaData.filename
                        items.fileStream = formulaData.fileStream
                        do {
                            try self?.context.save()
                        } catch  {
                            print("data is not saved")
                        }
                    }
                                    
                    for item in self!.arrBanners! {
                        let img = self?.convertBase64ToImage(imageString: item.fileStream ?? "")
                        self?.strBannerImages.append(ImageImageSource(imageString: img!))
                    }

                       
                    self?.navigationController?.isNavigationBarHidden = true
                    self?.slideshow.layer.cornerRadius = 0
                    self?.slideshow.clipsToBounds = true
                       
                    self?.slideshow.slideshowInterval = 2.0
                       // slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
                    self?.slideshow.contentScaleMode = UIView.ContentMode.redraw
                       // let pageControl = UIPageControl()
                       // pageControl.currentPageIndicatorTintColor = UIColor.colorWithHexString(hexStr: "#43ffa7")//UIColor.green//UIColor(hexString: "#EC7700")
                       // pageControl.pageIndicatorTintColor = UIColor.gray//UIColor(hexString: "#A9A9A9")
                       // slideshow.pageIndicator = pageControl
                       //dcrTblCell.slideshow.activityIndicator =
                    self?.slideshow.currentPageChanged = { [unowned self] page in
                           //            print("current page:", page)
                       }//            if #available(iOS 14.0, *) {
                    self?.slideshow.setImageInputs(self!.strBannerImages)
                    self?.getAllBirdType()
                } else {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                }
        }

        }
    }
    
    func getAllBirdType()  {
        let loginDicParametrs = NSMutableDictionary()
        
        let coreArrBirdsType = self.getAllItemsGetBirdsTypeEntity()

        if coreArrBirdsType != nil && coreArrBirdsType?.count ?? 0  > 0  {
            var arrBird = [String]()

            for item in coreArrBirdsType! {
                if arrBird.count == 0 {
                    arrBird.append(item.birds_Name ?? "")
                }
                for dupli in arrBird {
                    if !arrBird.contains(item.birds_Name ?? "") {
                        arrBird.append(item.birds_Name ?? "")
                    }
                }
            }
            self.txtBirdType.text = arrBird[0]
            self.txtCliate.text = "Summer"

            self.txtBirdType.optionArray = arrBird
            self.txtCliate.optionArray = ["Summer","Thermoneutral zone"]
            self.imgBirds.image = self.convertBase64ToImage(imageString: coreArrBirdsType![0].birds_Image ?? "")
        }else {
            WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.GetBirdType, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
                guard let owner = self else {return}
                if status == true{
                    if message != nil && message != "" {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                        })
                        return
                    }
                    
                    let countryData = try? JSONDecoder().decode(BirdTypeModel.self, from: (json.rawData()))
                    self?.arrBirdType = countryData?.data
                    
                    for formulaData in self!.arrBirdType! {
                        let items = NSEntityDescription.insertNewObject(forEntityName: "GetBirdsTypeEntity", into: self!.context) as! GetBirdsTypeEntity
                        items.birds_Code = Int32(formulaData.birds_Code ?? 0)
                        items.birds_Name = formulaData.birds_Name ?? ""
                        items.iD = Int32(formulaData.iD ?? 0)
                        items.climate_code = Int32(formulaData.climate_code ?? 0)
                        items.climate_name = formulaData.climate_name ?? ""
                        items.birds_Image = formulaData.birds_Image

                        do {
                            try self?.context.save()
                        } catch  {
                            print("data is not saved")
                        }
                    }
                    
                    var arrBird = [String]()
                    
                    for item in self!.arrBirdType! {
                        if arrBird.count == 0 {
                            arrBird.append(item.birds_Name ?? "")
                        }
                        for dupli in arrBird {
                            if !arrBird.contains(item.birds_Name ?? "") {
                                arrBird.append(item.birds_Name ?? "")
                            }
                        }
                    }
                    self?.txtBirdType.text = arrBird[0]
                    self?.txtCliate.text = "Summer"

                    self?.txtBirdType.optionArray = arrBird
                    self?.txtCliate.optionArray = ["Summer","Thermoneutral zone"]
                    self?.imgBirds.image = self?.convertBase64ToImage(imageString: self!.arrBirdType![0].birds_Image ?? "")
                } else {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                }
            }
        }
    }
    
    func getAllClimateType()  {
        let loginDicParametrs = NSMutableDictionary()

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.GetBirdType, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true{
                if message != nil && message != "" {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                    return
                }
                
                let countryData = try? JSONDecoder().decode(BirdTypeModel.self, from: (json.rawData()))
                self?.arrBirdType = countryData?.data
                

                
                
                var arrBird = [String]()
                
                for item in self!.arrBirdType! {
                    for dupli in self!.arrBirdType! {
                        if item.birds_Code != dupli.birds_Code {
                            arrBird.append(item.birds_Name ?? "")
                        }
                    }
                }
                self?.txtBirdType.text = arrBird[0]
                self?.txtCliate.text = "Summer"

                self?.txtBirdType.optionArray = arrBird
                self?.txtCliate.optionArray = ["Summer","Thermoneutral zone"]
                self?.imgBirds.image = self?.convertBase64ToImage(imageString: self!.arrBirdType![0].birds_Image ?? "")
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
    func getAllFormulaData()  {
        
        let coreArrFormula = self.getAllItemsGetFormulaData()

        if coreArrFormula != nil && coreArrFormula?.count ?? 0  > 0  {
            let txtFromValue = Int(self.txtFrom.text ?? "0")
            let txtToValue = Int(self.txtTo.text ?? "0")
            let txtNoBirds = Int(self.txtNumberOfBirds.text ?? "0")

            var value = 0.0

            var count = 0
            var txtFromValueRunner = 0
            
            
            for item in txtFromValue! - 1..<coreArrFormula!.count    {
                if coreArrFormula![item].climate_Name == self.txtCliate.text {
                    if txtFromValue ?? 0 == coreArrFormula![item].days {
                        txtFromValueRunner = txtFromValue!
                    }
                }
                
                if coreArrFormula![item].climate_Name == self.txtCliate.text && txtFromValueRunner == coreArrFormula![item].days {
                    count += 1
                    let formulaValue = coreArrFormula![item].formulaValue
                    value += formulaValue ?? 0.0
                    if count == txtToValue {
                        break
                    }
                }
                if txtFromValueRunner != 0 {
                    txtFromValueRunner += 1
                }
                    
            }
            
            let finalValue = value * Double(txtNoBirds ?? Int(0.0))
            print(finalValue)
            self.txtInLitr.text = "\(Double(round(1000*finalValue)/1000)) litre"
            let inGrms = (finalValue/3) //* Double(txtNoBirds ?? 0)
            let inMls = inGrms * 0.8

            self.txtInGrm.text = "\(Double(round(1000*inGrms)/1000)) gram"
            self.txtInMl.text = "\(Double(round(1000*inMls)/1000)) ml"
        }else {
            let loginDicParametrs = NSMutableDictionary()
            WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.GetFormula, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
                guard let owner = self else {return}
                if status == true{
                    if message != nil && message != "" {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                        })
                        return
                    }
     
                    let formulaData = try? JSONDecoder().decode(FormulaModel.self, from: (json.rawData()))
                    let arrFormula = formulaData?.data
                    for formulaData in arrFormula! {
                        let items = NSEntityDescription.insertNewObject(forEntityName: "GetFormulaData", into: self!.context) as! GetFormulaData
                        items.birds_Code = Int32(formulaData.birds_Code ?? 0)
                        items.birds_Name = formulaData.birds_Name ?? ""
                        items.days = Int32(formulaData.days ?? 0)
                        items.formulaValue = formulaData.formulaValue ?? 0.0
                        items.birdValue = Int32(formulaData.birdValue ?? 0)
                        items.climate_Name = formulaData.climate_Name
                        items.climate_code = Int32(formulaData.climate_code ?? 0)

                        do {
                            try self?.context.save()
                        } catch  {
                            print("data is not saved")
                        }
                    }
                    
                    let txtFromValue = Int(self?.txtFrom.text ?? "0")
                    let txtToValue = Int(self?.txtTo.text ?? "0")
                    let txtNoBirds = Int(self?.txtNumberOfBirds.text ?? "0")

                    var value = 0.0

                    var count = 0
                    var txtFromValueRunner = 0
                    
                    
                    for item in txtFromValue! - 1..<arrFormula!.count    {
                        if arrFormula![item].climate_Name == self?.txtCliate.text {
                            if txtFromValue ?? 0 == arrFormula![item].days {
                                txtFromValueRunner = txtFromValue!
                            }
                        }
                        
                        if arrFormula![item].climate_Name == self?.txtCliate.text && txtFromValueRunner == arrFormula![item].days {
                            count += 1
                            let formulaValue = arrFormula![item].formulaValue
                            value += formulaValue ?? 0.0
                            if count == txtToValue {
                                break
                            }
                        }
                        if txtFromValueRunner != 0 {
                            txtFromValueRunner += 1
                        }
                            
                    }
                    
                    let finalValue = value * Double(txtNoBirds ?? Int(0.0))
                    print(finalValue)
                    self?.txtInLitr.text = "\(Double(round(1000*finalValue)/1000)) litre"
                    let inGrms = (finalValue/3) //* Double(txtNoBirds ?? 0)
                    let inMls = inGrms * 0.8

                    self?.txtInGrm.text = "\(Double(round(1000*inGrms)/1000)) gram"
                    self?.txtInMl.text = "\(Double(round(1000*inMls)/1000)) ml"

                } else {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                }
        }
    }
}
    
    
    func calculateFormulaData()  {
        
    }
    func getAllItemsGetBirdsTypeEntity() -> [GetBirdsTypeEntity]?  {
        var product = [GetBirdsTypeEntity]()
        
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "GetBirdsTypeEntity")
            product = try self.context.fetch(fetchRequest) as! [GetBirdsTypeEntity]
            let sortedStudents = product.sorted { (lhs: GetBirdsTypeEntity, rhs: GetBirdsTypeEntity) -> Bool in
                return lhs.birds_Name ?? "" < rhs.birds_Name ?? ""
            }
            return sortedStudents
        } catch  {
            print("can not get data")
        }
        let sortedStudents = product.sorted { (lhs: GetBirdsTypeEntity, rhs: GetBirdsTypeEntity) -> Bool in
            return lhs.birds_Name ?? "" < rhs.birds_Name ?? ""
        }
//        let arr1 =  filteredArr.filter({ (obj1) -> Bool in
//            if searchText == "" {
//            }else{
//                if obj1.itemname!.uppercased().contains(searchText.uppercased()) {
//                    return true
//                }
//            }
//            return false
//        })
        return sortedStudents
    }
    
    
    func getAllItemsGetBannersEntity() -> [BannersEntity]?  {
        var product = [BannersEntity]()
        
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "BannersEntity")
            product = try self.context.fetch(fetchRequest) as! [BannersEntity]
            let sortedStudents = product.sorted { (lhs: BannersEntity, rhs: BannersEntity) -> Bool in
                return lhs.filename ?? "" < rhs.filename ?? ""
            }
            return sortedStudents
        } catch  {
            print("can not get data")
        }
        let sortedStudents = product.sorted { (lhs: BannersEntity, rhs: BannersEntity) -> Bool in
            return lhs.filename ?? "" < rhs.filename ?? ""
        }
//        let arr1 =  filteredArr.filter({ (obj1) -> Bool in
//            if searchText == "" {
//            }else{
//                if obj1.itemname!.uppercased().contains(searchText.uppercased()) {
//                    return true
//                }
//            }
//            return false
//        })
        return sortedStudents
    }
    
    
    func getAllItemsGetFormulaData() -> [GetFormulaData]?  {
        var product = [GetFormulaData]()
        
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "GetFormulaData")
            product = try self.context.fetch(fetchRequest) as! [GetFormulaData]
            let sortedStudents = product.sorted { (lhs: GetFormulaData, rhs: GetFormulaData) -> Bool in
                return lhs.birds_Name ?? "" < rhs.birds_Name ?? ""
            }
            return sortedStudents
        } catch  {
            print("can not get data")
        }
        let sortedStudents = product.sorted { (lhs: GetFormulaData, rhs: GetFormulaData) -> Bool in
            return lhs.birds_Name ?? "" < rhs.birds_Name ?? ""
        }
//        let arr1 =  filteredArr.filter({ (obj1) -> Bool in
//            if searchText == "" {
//            }else{
//                if obj1.itemname!.uppercased().contains(searchText.uppercased()) {
//                    return true
//                }
//            }
//            return false
//        })
        return sortedStudents
    }
}
