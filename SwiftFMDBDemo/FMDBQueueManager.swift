//
//  FMDBQueueManager.swift
//  SwiftFMDBDemo
//
//  Created by 嵇明新 on 2017/7/17.
//  Copyright © 2017年 嵇明新. All rights reserved.
//

import UIKit
import FMDB

class FMDBQueueManager: NSObject {

    static let shareFMDBQueueManager = FMDBQueueManager()
    
    var dbQueue : FMDatabaseQueue?
    
    func openDB(_ dbName : String)  {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        print(path)
        
        dbQueue = FMDatabaseQueue(path: "\(path)/\(dbName)")
        
        createTable()
        
    }
    
    func createTable() -> Void {
        let sql = "CREATE TABLE IF NOT EXISTS contact_people ('id' integer NOT NULL,'name' text NOT NULL,'phoneNum' text NOT NULL,PRIMARY KEY('id'))"
        dbQueue?.inDatabase({ (db) -> Void in
            
            try? db.executeUpdate(sql, values: [])
        })
    }
}
