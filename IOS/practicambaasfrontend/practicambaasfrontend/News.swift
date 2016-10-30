//
//  News.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 30/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import Foundation

class News{
 /*
 title, content, authorId, name, surname, photoPath, publishStatus,numberValuations,avgValuations,locateLongitude,locateLatitude,locateAddress
 */

    let title : String
    var content : String?
    let authorId : String
    var name : String?
    var surname : String?
    var photoPath : String?
    var publishStatus : PublishedStatus
    var numberValuations : Int
    var avgValuation : Double
    var longitude : Double?,
    latitude : Double?
    var address : String?
    
    init(title: String, authorId: String){
        (self.title, self.authorId) = (title, authorId)
        publishStatus = .Draft
        numberValuations = 0
        avgValuation = 0.0
    }
    
    
}

