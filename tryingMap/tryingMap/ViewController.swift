//
//  ViewController.swift
//  mapkit
//
//  Created by CdxN on 2017/7/28.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var mapView = MKMapView()

    // 1.創建 locationManager
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.black

        let fullScreenSize = UIScreen.main.bounds.size

        // 使用 UISegmentedControl(items:) 建立 UISegmentedControl
        // 參數 items 是一個陣列 會依據這個陣列顯示選項
        // 除了文字 也可以擺放圖片 像是 [UIImage(named:"play")!,"晚餐"]
        let mySegmentedControl = UISegmentedControl(items: [UIImage(named:"icon_photo") ?? "早餐", "午餐", "晚餐", "宵夜"])

        // 設置外觀顏色 預設為藍色
        mySegmentedControl.tintColor = UIColor.green

        // 設置底色 沒有預設的顏色
        mySegmentedControl.backgroundColor = UIColor.black

        // 設置預設選擇的選項
        // 從 0 開始算起 所以這邊設置為第一個選項
        mySegmentedControl.selectedSegmentIndex = 0

        // 設置切換選項時執行的動作
        mySegmentedControl.addTarget(
            self,
            action:
            #selector(ViewController.onChange),
            for: .valueChanged)

        // 設置尺寸及位置並放入畫面中
        mySegmentedControl.frame.size = CGSize(
            width: fullScreenSize.width * 0.8, height: 30)
        mySegmentedControl.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.25)
        self.view.addSubview(mySegmentedControl)

        // mapView
        self.mapView = MKMapView(frame:self.view.frame)
        self.view.addSubview(self.mapView)

        // 2. 配置 locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 3. 配置 mapView
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // 4. 加入測試數據
        setupData()
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1. 還沒有詢問過用戶以獲得權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. 用戶不同意
        else if CLLocationManager.authorizationStatus() == .denied {
            ShowAlert(title: "Title", message: "message...")
        }
            // 3. 用戶已經同意
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func ShowAlert(title: String, message: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // 切換選項時執行動作的方法
    func onChange(sender: UISegmentedControl) {
        // 印出選到哪個選項 從 0 開始算起
        print(sender.selectedSegmentIndex)

        // 印出這個選項的文字
        print(
            sender.titleForSegment(
                at: sender.selectedSegmentIndex) ?? "QQ")
    }
    
    func setupData() {
        // 1. 檢查系統是否能夠監視 region
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            // 2.準備 region 會用到的相關屬性
            let title = "Lorrenzillo's"
            let coordinate = CLLocationCoordinate2DMake(37.703026, -121.759735)
            let regionRadius = 300.0
            
            // 3. 設置 region 的相關屬性
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                         longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            // 4. 創建大頭釘(annotation)
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            mapView.addAnnotation(restaurantAnnotation)
            
            // 5. 繪製一個圓圈圖形（用於表示 region 的範圍）
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            mapView.add(circle)
        }
        else {
            print("System can't track regions")
        }
    }
    
    // 6. 繪製圓圈
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }

}
