//
//  recommendViewController.swift
//  newsnagoya
//
//  Created by 武岡健介 on 2016/02/26.
//  Copyright © 2016年 Takeoka Kensuke. All rights reserved.
//
import MapKit
import UIKit

class recommendViewController: UIViewController {

    
    @IBOutlet weak var nagoyaList: UITableView!
    @IBOutlet weak var pushBtnRe: UIButton!
    @IBOutlet weak var recommendMapView: MKMapView!
    var openFlag = true
//    var tea_list = ["ダージリン","アールグレイ","アッサム","オレンジペコ"]
    
    var recommend:[NSString] = []
    var dic:NSDictionary?
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ファイルのパスを取得
        var filePath = NSBundle.mainBundle().pathForResource("recommend", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に代入
        self.dic = NSDictionary(contentsOfFile: filePath!)
        var array:[NSDictionary] = []
        
        //TableViewで扱いやすい形（エリア名の入ってる配列）を作成
        for(key,data) in dic!{
            array = data as! NSArray as! [NSDictionary]
        }
        for(data) in array{
//            値を一個ずつ入れる　append
            recommend.append(data["name"] as! String)
            print(recommend)
        }
        

        let coordinate = CLLocationCoordinate2DMake(35.25271,35.25271 )
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(coordinate, span)
        recommendMapView.setRegion(region, animated:true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "title"
        annotation.subtitle = "subtitle"
        self.recommendMapView.addAnnotation(annotation)
        }
    
    override func viewWillAppear(animated: Bool) {
        self.nagoyaList.hidden = true
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
    @IBAction func tapPushre(sender: UIButton) {
            if (self.openFlag){
                self.recommendMapView.hidden = true
                self.nagoyaList.hidden = false
                openFlag = false
            }else{
                self.recommendMapView.hidden = false
                self.nagoyaList.hidden = true
                openFlag = true
                print("nemui")
        }
        
    }
    func tableView(tableView :UITableView, numberOfRowsInSection section: Int) ->Int{
        return recommend.count
        
    }
    //    表示するセルの中身
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            var recommendname = recommend[indexPath.row]
            var cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
           // cell.textLabel?.text = "\(indexPath.row)行目"
            
            
            //cell.textLabel!.text = "\(tea_list[indexPath.row])"
            cell.textLabel!.text = "\(recommendname)"
            
            
            cell.textLabel?.textColor = UIColor.greenColor()
            
            cell.textLabel!.font = UIFont.systemFontOfSize(20)
            cell.accessoryType =  .DisclosureIndicator
            
            
            return cell
            
    }
    // 選択された時に行う処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)行目を選択")
        selectedIndex = indexPath.row
        performSegueWithIdentifier("showSecondView",sender: nil)
    }
    
    // Segueで画面遷移する時
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var secondVC = segue.destinationViewController as! showEventViewController
        
        secondVC.scSelectedIndex = selectedIndex
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!){
            print("\(indexPath.row)行目を選択")
            //        selectedIndex = indexPath.row
            
        }
        
    }
}