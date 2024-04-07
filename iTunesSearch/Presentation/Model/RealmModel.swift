//
//  RealmTable.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/5/24.
//

import Foundation
import RealmSwift

class UserApp : Object {
    
    @Persisted(primaryKey: true) var trackID : Int // trackID
    @Persisted var name : String
//    @Persisted var release 
}
