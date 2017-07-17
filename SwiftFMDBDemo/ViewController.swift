//
//  ViewController.swift
//  SwiftFMDBDemo
//
//  Created by 嵇明新 on 2017/7/17.
//  Copyright © 2017年 嵇明新. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myTableView = UITableView()
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
    FMDBQueueManager.shareFMDBQueueManager.openDB("contact_people.sqlite")
        
        myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-50), style: .plain);
        myTableView.rowHeight = 60;
        myTableView.delegate = self;
        myTableView.dataSource = self;
        self.view.addSubview(myTableView);
        
        let arr:NSArray = ["增加","删除","修改","查询"];
        let widthF:CGFloat = self.view.frame.size.width/4;
        
        for i in 0...arr.count-1 {
            let buttonN = UIButton.init(frame: CGRect(x: widthF*CGFloat(i), y: self.view.frame.size.height-50, width: widthF, height: 50));
            buttonN.setTitle(arr[i] as? String, for: UIControlState());
            buttonN.setTitleColor(UIColor.blue, for: UIControlState());
            buttonN.backgroundColor = UIColor.lightGray;
            buttonN.titleLabel?.adjustsFontSizeToFitWidth = true;
            buttonN.tag = i+100;
            buttonN.addTarget(self, action: #selector(btnClick), for: .touchUpInside);
            self.view.addSubview(buttonN);
        }

    }
    
    func btnClick(_ btn:UIButton) {
        switch btn.tag {
        case 100:
            //增加
            self.insertAction();
            break;
        case 101:
            //删除
            self.deleteAction();
            break;
        case 102:
            //修改
            self.updateAction();
            break;
        case 103:
            //查询
            self.queryAction();
            break;
        default:
            break;
        }
        self.queryAction();
        myTableView.reloadData();
    }

    //增加
    func insertAction(){
        let FMDBMod = FMDBModel.init(dict: ["name":"小名" as String,"phoneNum":"12345678" as String]);
        FMDBMod.insert();
    }
    //删除
    func deleteAction(){
        let FMDBMod = FMDBModel.init(dict: ["name":"小名" as String,"phoneNum":"12345678" as String]);
        FMDBMod.delete();
    }
    //修改
    func updateAction(){
        let FMDBMod = FMDBModel.init(dict: ["name":"嘿嘿" as String,"phoneNum":"12345678" as String]);
        FMDBMod.update();
    }
    //查询
    func queryAction(){
        dataArray = NSMutableArray(array: FMDBModel.query());
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{

    //MARK:-------UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myCell = tableView.dequeueReusableCell(withIdentifier: "cell1");
        if myCell == nil {
            myCell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell1");
        }
        myCell?.selectionStyle = UITableViewCellSelectionStyle.none;
        let dic = NSDictionary.init(dictionary: (dataArray[indexPath.row] as? NSDictionary)!);
        myCell?.textLabel?.text = dic["name"] as? String;
        myCell?.detailTextLabel?.text = dic["phoneNum"] as? String;
        return myCell!;
    }
}

