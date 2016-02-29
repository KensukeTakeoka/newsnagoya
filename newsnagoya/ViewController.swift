//
//  ViewController.swift
//  newsnagoya
//
//  Created by 武岡健介 on 2016/02/23.
//  Copyright © 2016年 Takeoka Kensuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    行数
    func tableView(tableView :UITableView, numberOfRowsInSection section: Int) ->Int{
        return 10
        
    }
    //    表示するセルの中身
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            var cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
            cell.textLabel?.text = "\(indexPath.row)行目"
            
            cell.textLabel?.textColor = UIColor.redColor()
            
            cell.textLabel!.font = UIFont.systemFontOfSize(20)
            cell.accessoryType =  .Checkmark
            
            
            return cell
            
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        print("\(indexPath.row)行目を選択")
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    //        override func didReceiveMemoryWarning(){
    //            super.didReceiveMemoryWarning()
    //        }
    
    
    
}
