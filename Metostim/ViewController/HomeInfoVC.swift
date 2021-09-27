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

class HomeInfoVC: UIViewController {
    
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

    @IBOutlet weak var carouselVw: iCarousel!
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
            
            for item in self.arrBirdType! {
                if "\(item.birds_Name!)" == str {
                    if "\(item.climate_name!)" == self.txtCliate.text {
                        self.imgBirds.image = self.convertBase64ToImage(imageString: item.birds_Image ?? "")
                    }
                }
            }
        }
        txtCliate.didSelect { (str, value1, value2) in
            self.txtCliate.text = str
            for item in self.arrBirdType! {
                if "\(item.birds_Name!)" == "\(self.txtBirdType.text!)" {
                    if "\(item.climate_name!)" == str {
                        self.imgBirds.image = self.convertBase64ToImage(imageString: item.birds_Image ?? "")
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
        let from = Int(txtFrom.text ?? "0")
        let toVal = Int(txtTo.text ?? "0")

        if from ?? 0 > toVal ?? 0  {
            Toast.init(text: "from value cannot be greater than To value").show()
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

extension HomeInfoVC : iCarouselDelegate,iCarouselDataSource {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0 ... 5 {
            items.append(i)
        }
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
       // var label: UILabel
        var itemView: UIImageView

        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
          //  label = itemView.viewWithTag(1) as! UILabel
        } else {
           // let kingfisherSource = [KingfisherSource(urlString: "https://m.media-amazon.com/images/S/aplus-media/sc/284da9a6-d1d6-44bc-95b5-9962fe4cfe19.__CR0,0,1293,800_PT0_SX970_V1___.jpg")!, KingfisherSource(urlString: "https://i5.walmartimages.com/asr/f0f58f1b-a6ce-49bb-b59e-f8a7a7620687_1.a63a6883728a61146aa7fe264e5a41af.jpeg")!, KingfisherSource(urlString: "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_690,h_700/a_ignore,w_690,h_700,c_pad,q_auto,f_auto/v1601247726/cropped/zk861kvn2dmrjfi4ipsy.png")!]

            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            //itemView.image = UIImage(named: "page.png")
//            itemView.sd_setImage(with: kingfisherSource[0].url , placeholderImage: nil, options: .highPriority, context: nil)
         //   itemView.image = UIImage(data: <#T##Data#>)

            itemView.backgroundColor = UIColor.lightGray
            itemView.contentMode = .scaleAspectFit

//            label = UILabel(frame: itemView.bounds)
//            label.backgroundColor = .clear
//            label.textAlignment = .center
//            label.font = label.font.withSize(50)
//            label.tag = 1
//            itemView.addSubview(label)
            

        }

        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        //label.text = "\(items[index])"

        return itemView
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    
}


extension HomeInfoVC {
    func getAllBanners()  {
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
                
                //   let kingfisherSource = [KingfisherSource(urlString: "https://m.media-amazon.com/images/S/aplus-media/sc/284da9a6-d1d6-44bc-95b5-9962fe4cfe19.__CR0,0,1293,800_PT0_SX970_V1___.jpg")!, KingfisherSource(urlString: "https://i5.walmartimages.com/asr/f0f58f1b-a6ce-49bb-b59e-f8a7a7620687_1.a63a6883728a61146aa7fe264e5a41af.jpeg")!, KingfisherSource(urlString: "https://res.cloudinary.com/du8msdgbj/image/upload/l_watermark_346,w_690,h_700/a_ignore,w_690,h_700,c_pad,q_auto,f_auto/v1601247726/cropped/zk861kvn2dmrjfi4ipsy.png")!]
                   
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
    
    func getAllBirdType()  {
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
                
                let txtFromValue = Int(self?.txtFrom.text ?? "0")
                let txtToValue = Int(self?.txtTo.text ?? "0")
                let txtNoBirds = Int(self?.txtNumberOfBirds.text ?? "0")

                var value = 0.0
                
                
//                for item in txtFromValue! - 1..<txtToValue!   {
//                    if arrFormula![item].climate_Name == self?.txtCliate.text && (txtFromValue ?? 0 - 1) == arrFormula![item].days {
//
//                    }
//                    let formulaValue = arrFormula![item].formulaValue
//                    value += formulaValue ?? 0.0
//
//                }
                var count = 0
                var txtFromValueRunner = 0
                
                
                for item in txtFromValue! - 1..<arrFormula!.count    {
                    if arrFormula![item].climate_Name == self?.txtCliate.text {
                        if txtFromValue == arrFormula![item].days {
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
                let inGrms = (finalValue/3) * Double(txtNoBirds ?? 0)
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
