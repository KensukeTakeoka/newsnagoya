//
//  foodViewController.swift
//  newsnagoya
//
//  Created by 武岡健介 on 2016/02/26.
//  Copyright © 2016年 Takeoka Kensuke. All rights reserved.
//

import UIKit
import MapKit

class foodViewController: UIViewController {
    
    @IBOutlet weak var foodList: UITableView!
    @IBOutlet weak var pushBtn: UIButton!
    @IBOutlet weak var foodMapView: MKMapView!
    var openFlag = true
    var tea_list = ["ダージリン","アールグレイ","アッサム","オレンジペコ"]
    var ngyfood:[NSString] = []
    var dic:NSDictionary?
    var selectedIndex = -1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ファイルのパスを取得
        var filePath = NSBundle.mainBundle().pathForResource("gourmet", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に代入
        self.dic = NSDictionary(contentsOfFile: filePath!)
        var ngy:[NSDictionary] = []
        
        //TableViewで扱いやすい形（エリア名の入ってる配列）を作成
        for(key,data) in dic!{
            ngy = data as! NSArray as! [NSDictionary]
        }
        for(data) in ngy{
            //            値を一個ずつ入れる　append
            ngyfood.append(data["storename"] as! String)
            print(ngyfood)
        }

        let coordinate = CLLocationCoordinate2DMake(35.170915,136.881537 )
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(coordinate, span)
        foodMapView.setRegion(region, animated:true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "title"
        annotation.subtitle = "subtitle"
        self.foodMapView.addAnnotation(annotation)
        
    
    }
    override func viewWillAppear(animated: Bool) {
        self.foodList.hidden = true
        print(self.dic)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MKMapView delegate
    
    // Called when the region displayed by the map view is about to change
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print(__FUNCTION__)
    }
    
    // Called when the annotation was added
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.canShowCallout = true
            pinView?.draggable = true
            pinView?.pinColor = .Purple
            
            let rightButton: AnyObject! = UIButton(type: UIButtonType.DetailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(__FUNCTION__)
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("toTheMoon", sender: self)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.Ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func didReturnToMapViewController(segue: UIStoryboardSegue) {
        print(__FUNCTION__)
    }
    
    @IBAction func tapBtnMap(sender: UIButton) {
    }
    
    @IBAction func tapPush(sender: UIButton){
        if (self.openFlag){
            self.foodMapView.hidden = true
            self.foodList.hidden = false
            
            openFlag = false
        }else{
            // 表示されている
            self.foodMapView.hidden = false
            self.foodList.hidden = true
            openFlag = true
            print("疲れました")
            
        }
    }
    func tableView(tableView :UITableView, numberOfRowsInSection section: Int) ->Int{
        return ngyfood.count
        
    }
    //    表示するセルの中身
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            var nagoyafood = ngyfood[indexPath.row]
            var cell = UITableViewCell(style: .Default, reuseIdentifier: "myCellfood")
            // cell.textLabel?.text = "\(indexPath.row)行目"
            
            
            //cell.textLabel!.text = "\(tea_list[indexPath.row])"
            cell.textLabel!.text = "\(nagoyafood)"
            
            
            cell.textLabel?.textColor = UIColor.greenColor()
            
            cell.textLabel!.font = UIFont.systemFontOfSize(20)
            cell.accessoryType =  .DisclosureIndicator
            
            
            return cell
            
    }
    // 選択された時に行う処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)行目を選択")
        selectedIndex = indexPath.row
        //performSegueWithIdentifier("showSecondView",sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue")
    }
    
//    // Segueで画面遷移する時
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var secondVC = segue.destinationViewController as!showRestaurantViewController
//        
//        secondVC.scSelectedIndex = selectedIndex
//    }
    
    
}
    