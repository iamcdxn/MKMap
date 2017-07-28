//
//  ViewController.swift
//  mapkit
//
//  Created by CdxN on 2017/7/28.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.white

        let fullScreenSize = UIScreen.main.bounds.size

        // 使用 UISegmentedControl(items:) 建立 UISegmentedControl
        // 參數 items 是一個陣列 會依據這個陣列顯示選項
        // 除了文字 也可以擺放圖片 像是 [UIImage(named:"play")!,"晚餐"]
        let mySegmentedControl = UISegmentedControl(items: ["早餐", "午餐", "晚餐", "宵夜"])

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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
