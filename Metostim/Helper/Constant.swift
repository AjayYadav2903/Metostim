//
//  Constant.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct Constant {
    
    struct StringMsg {
        static let welcome = ""
        
        static let homeStr = ""
        
        static let fingerStr = """
        Center your Finger in the window and take a Picture

        Use White Paper background for good result

         We will take 4 Pictures for each hand
"""
        
        static let contact = """
 Contact Us Phone:

Call on: +91 844-8444-616

For any payment related issues

Call on +91 6351336265

   
   Address:

Ignite Eduventure
PTE Ltd
1003 Bukit Merah Central
#03-07 Singapore 159836
"""

        
    }
    

    
    struct StoryBoard {
      static  let loginVC = UIStoryboard(name: "Login", bundle: nil)
        
    }
    
    struct cellIdentifier {
        static let cellLiveReuseIdentifier = "LiveNowCell"
        static let cellLiveScheduleReuseIdentifier = "LiveScheduleCell"
        static let cellScheduleReuseIdentifier = "ScheduleCell"
        static let bookmarkReuseIdentifier = "bookmarkCell"
        static let cellLeftSlideReuseIdentifier = "LeftSlideCell"
        static let cellInboxReuseIdentifier = "InboxCell"
        static let giftCellReuseIdentifier = "GiftStoreItemCollectionViewCell"
        static let cellStoreReuseIdentifier = "StoreCell"
        static let cellCategoryReuseIdentifier = "CategoryCell"
    }
    
    struct nibName {
        static let liveTableViewCell = "LiveTableViewCell"
        static let liveScheduleTableViewCell = "LiveScheduleTableViewCell"
        static let scheduleTableViewCell = "ScheduleTableViewCell"
        static let bookmarkTableViewCell = "BookmarkVideoTableViewCell"
        static let leftSlideTableViewCell = "LeftSlideTableViewCell"
        static let inboxTableViewCell = "InboxTableViewCell"
        static let giftCell = "GiftStoreItemCollectionViewCell"
        static let categoryTableViewCell = "CategoryTableViewCell"
        static let storeTableViewCell = "StoreTableViewCell"
    }
    
    struct accountType {
          static let Customer = "Customer"
          static let Agency = "Agency"
      }
    
    struct  KEYS {
        static let INTROVIEW = "intro"
    }
}
