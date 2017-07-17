//
//  FMDBModel.swift
//  SwiftFMDBDemo
//
//  Created by 嵇明新 on 2017/7/17.
//  Copyright © 2017年 嵇明新. All rights reserved.
//

import UIKit

class FMDBModel: NSObject {
    
    /// 属性
    var name : String?
    var phoneNum : String?
    
    init(dict: [String:String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    //调用的系统set方法
    //override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
    //MARK: 注意sql语句书写方式
    //增加数据
    func insert() -> Void {
        let sql = "INSERT INTO contact_people (name, phoneNum) values ('\(self.name!)', '\(self.phoneNum!)')"
        
        //下面的写法存在线程不安全的问题
        //FMDBManager.ShareManager.db?.executeUpdate(sql, withArgumentsIn: [])
        
        FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) ->Void in
            
            try? db.executeUpdate(sql, values: [])
        })
    }
    
    //删除数据
    func delete() -> Void {
        let sql = "delete from contact_people"
     FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) in
            
            try? db.executeUpdate(sql, values: [])
        })
        
    }
    
    //更新数据
    func update() -> Void {
        let sql = "update contact_people set name = '\(self.name!)' where phoneNum = '12345678'"
        
        FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) in
            try? db.executeUpdate(sql, values: [])
        })
    }
    
    //查询数据
    class func query()->[[String: AnyObject]] {
    
        let sql = "SELECT * FROM contact_people"
        
        var resultArray:[[String: AnyObject]] = []
        
        FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) in
            if let result = try? db.executeQuery(sql, values: []){
                
                //获取数据
                while (result.next()) {
                    let nameStr = result.string(forColumn: "name")
                    let phoneNumStr = result.string(forColumn: "phoneNum")
                    let dic = ["name": nameStr,"phoneNum":phoneNumStr]
                    resultArray.append(dic as [String : AnyObject])
                }
            }
            
        })
        
        return resultArray
        
    }
}
