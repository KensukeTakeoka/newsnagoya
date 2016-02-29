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
    var tea_list = ["ダージリン","アールグレイ","アッサム","オレンジペコ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return tea_list.count
        
    }
    //    表示するセルの中身
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            var cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
            cell.textLabel?.text = "\(indexPath.row)行目"
            
            
            cell.textLabel!.text = "\(tea_list[indexPath.row])"
            
            cell.textLabel?.textColor = UIColor.greenColor()
            
            cell.textLabel!.font = UIFont.systemFontOfSize(20)
            cell.accessoryType =  .DisclosureIndicator
            
            
            return cell
            
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        print("\(indexPath.row)行目を選択")
//        selectedIndex = indexPath.row
       
    }
    
}



        
        
        
        
        
       


