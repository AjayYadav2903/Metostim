//
//  IntroViewVC.swift
//  PropertyTurnover
//
//  Created by Impero IT on 28/09/17.
//  Copyright © 2017 Impero IT. All rights reserved.
//

import UIKit

class IntroViewVC: UIViewController{
    //MARK: - Outlet
    @IBOutlet weak var colletionView: UICollectionView!
    @IBOutlet weak var pagination: UIPageControl!
    @IBOutlet weak var btnNextObj: UIButton!
    //MARK: - GlobalUse
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //MARK: - Private
    let arrtitletext : [String] = ["Metostim is uniquely designed to build and strenghthen digestive system and potentiated with highly assimlable amino acids,vitamins and other essential nutrients for faster growth and performance.","Together with our team of experts, we focus on the preservation, processing, and nutritional elements that go into making better feed and ultimately, better food."]
    let imgIntro : [String] = ["bentoliapplogo","animalform"]

    var widthView = 0
    var pageNumber = 0
    //MARK: - DefaultMethod
    override func viewDidLoad() {
        super.viewDidLoad()
        widthView = Int(self.view.frame.size.width) * Int(2)
        pagination.numberOfPages = 2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - CustomMethod
    func moveToFrame(contentOffset : CGFloat) {
        pageNumber = pageNumber + 1
        pagination.currentPage = pageNumber
        if widthView == Int(contentOffset){
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let loginVC = loginStoryBoard
            let navi = UINavigationController(rootViewController: loginVC)
            appDelegate.window?.rootViewController = navi
        }
        else{
            let frame: CGRect = CGRect(x : contentOffset ,y : self.colletionView.contentOffset.y ,width : self.colletionView.frame.width,height : self.colletionView.frame.height)
            self.colletionView.scrollRectToVisible(frame, animated: true)
        }
        if pageNumber == 4{
            self.btnNextObj.setTitle(" Got it", for: .normal)
        }
    }
    //MARK: - ActionButton
    @IBAction func btnNext(_ sender: Any) {
        let collectionBounds = self.colletionView.bounds
        let contentOffset = CGFloat(floor(self.colletionView.contentOffset.x + collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
    }
    
    @IBAction func btnSignin(_ sender: Any) {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
    }
    
}
//MARK: - ColletionViewMethod
extension IntroViewVC : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroViewCell
        cell.lblTitle.text = self.arrtitletext[indexPath.row]
        cell.imgIntro.image = UIImage(named: imgIntro[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.colletionView.frame.size.height)
    }
}
//MARK: - ScrollViewMethod
extension IntroViewVC : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pagination.currentPage = Int(pageNumber)
        let title = pageNumber > 3 ? "Got it" : "Next"
       // self.btnNextObj.setTitle(title, for: .normal)
        
    }
}
