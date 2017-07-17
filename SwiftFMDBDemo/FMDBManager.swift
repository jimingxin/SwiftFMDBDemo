//
//  FMDBManager.swift
//  SwiftFMDBDemo
//
//  Created by 嵇明新 on 2017/7/17.
//  Copyright © 2017年 嵇明新. All rights reserved.
//

import UIKit
import FMDB

class FMDBManager: NSObject {

    // 单列
    static let ShareManager = FMDBManager()
    
    // 创建一个dataBase的一个全局对象
    var db: FMDatabase?
    
    func openDB(_ dbName: String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        print(path)
        
        //创建一个dbBase的数据库对象
        db = FMDatabase(path: "\(path)/\(dbName)")
        
        //判断是否创建成功，需要强制解包
        if db!.open() {
            print("数据库创建成功")
            createTalbe()
        }else {
        
            print("数据库创建失败")
        }
    }
    
    //创建表的方法
    func createTalbe() {
        
        // 创建表
        let sql = "CREATE TABLE IF NOT EXISTS contact_people ('id' integer NOT NULL,'name' text NOT NULL,'phoneNum' text NOT NULL,PRIMARY KEY('id'))"
        
        //进行错误处理
        do {
            try db?.executeUpdate(sql, values: [])
        } catch  {
            print(error)
        }
    }
    
}
