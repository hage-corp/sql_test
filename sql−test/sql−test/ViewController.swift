//
//  ViewController.swift
//  sql−test
//
//  Created by NishiwakiHajime on 2015/04/19.
//  Copyright (c) 2015年 NishiwakiHajime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ////////////////////////////////////
        // 操作ボタンを追加します
        ////////////////////////////////////
        
        // 画面サイズの取得
        var my_width = UIScreen.mainScreen().bounds.size.width      // 横
        var my_height = UIScreen.mainScreen().bounds.size.height     // 縦
        // レイアウトの為のオフセット
        var offset_top:CGFloat = 30.0
        var offset_size:CGFloat = 3.0
        var btn_width :CGFloat = (my_width / 3) - offset_size * 2         // ボタン横サイズ
        var btn_height:CGFloat = 30.0                 // ボタン縦サイズ
        
        ////////////////////////////////////
        // ボタンを３つ用意します
        ////////////////////////////////////
        
        // 一つ目、畠山家ボタン
        var hata_btn = UIButton()
        hata_btn.frame = CGRectMake(0,0,btn_width,btn_height)
        hata_btn.backgroundColor = UIColor.redColor()
        hata_btn.layer.masksToBounds = true
        hata_btn.setTitle("畠山家", forState: UIControlState.Normal)
        hata_btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        hata_btn.layer.cornerRadius = 20.0
        hata_btn.layer.position = CGPoint(x: btn_width / 2, y: offset_top + offset_size + btn_height / 2 )
        hata_btn.tag = 1
        hata_btn.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(hata_btn)

        // 二つ目、坂口家ボタン
        var saka_btn = UIButton()
        saka_btn.frame = CGRectMake(0,0,btn_width,btn_height)
        saka_btn.backgroundColor = UIColor.redColor()
        saka_btn.layer.masksToBounds = true
        saka_btn.setTitle("坂口家", forState: UIControlState.Normal)
        saka_btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        saka_btn.layer.cornerRadius = 20.0
        saka_btn.layer.position = CGPoint(x: btn_width + btn_width / 2, y: offset_top + offset_size + btn_height / 2 )
        saka_btn.tag = 2
        saka_btn.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(saka_btn)
        
        // 三つ目、タイムマシンボタン
        var time_btn = UIButton()
        time_btn.frame = CGRectMake(0,0,btn_width,btn_height)
        time_btn.backgroundColor = UIColor.greenColor()
        time_btn.layer.masksToBounds = true
        time_btn.setTitle("1年後", forState: UIControlState.Normal)
        time_btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        time_btn.layer.cornerRadius = 20.0
        time_btn.layer.position = CGPoint(x: btn_width * 2 + btn_width / 2, y: offset_top + offset_size + btn_height / 2 )
        time_btn.tag = 3
        time_btn.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(time_btn)
        
        ////////////////////////////////////
        // DBの内容を画面に表示します
        ////////////////////////////////////
        
        // DB立ち上げ
        var objects = NSMutableArray()
        let sqlModel = SqlDataRap()
        
        // ベースをスクロールViewとする
        var scroll_top = offset_top + btn_height + offset_size * 2
        var baseScrollView = UIScrollView(frame: CGRectMake(0, scroll_top, my_width, my_height - scroll_top))
        
        ////////////////////////////////////////
        // - 以下スクロールViewの設定
        // スクロールあり
        baseScrollView.scrollEnabled = true
        // 水平方向のスクロールバーなし
        baseScrollView.showsHorizontalScrollIndicator = false
        // 垂直方向のスクロールバーあり
        baseScrollView.showsVerticalScrollIndicator = true
        
        var item_cnt = 0
        
        // データ抜きだし
        var data_all = sqlModel.SelectAll()
        
        for data in data_all {
            var __name = data["name"]
            var __age = data["age"]
            
            // データをスクロールViewに追加していく
            var one_data = UILabel(frame: CGRectMake(0, 0, my_width, 60))
            // 背景をオレンジ色にする.
            one_data.backgroundColor = UIColor.orangeColor()
            // 枠を丸くする.
            one_data.layer.masksToBounds = true
            // コーナーの半径.
            one_data.layer.cornerRadius = 20.0
            // Labelに文字を代入.
            one_data.text = "\(item_cnt)  \(__name)  \(__age) "
            // 文字の色を白にする.
            one_data.textColor = UIColor.whiteColor()
            // 文字の影の色をグレーにする.
            one_data.shadowColor = UIColor.grayColor()
            // Textを中央寄せにする.
            one_data.textAlignment = NSTextAlignment.Center
            // 配置する座標を設定する.
            one_data.layer.position = CGPoint(x: my_width/2,y: CGFloat(item_cnt) * 60 + 30)
            baseScrollView.addSubview(one_data)
            
            item_cnt++
        }
        
        baseScrollView.contentSize = CGSizeMake(my_width, CGFloat(item_cnt) * 60)

        self.view.addSubview(baseScrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ボタンが押された時の動作
    func onClickMyButton(sender: UIButton){
        println("onClickMyButton:")
        println("sender.currentTitile: \(sender.currentTitle)")
        println("sender.tag:\(sender.tag)")
        
        let sqlModel = SqlDataRap()

        if sender.tag == 1 {
            // 畠山家
            sqlModel.Add("畠山家一族")
            makeScrollView()
        }else if sender.tag == 2 {
            // 坂口家
            sqlModel.Add("坂口家一族")
            makeScrollView()
        }else{
            // ⭐️課題２：以下に各年齢を一歳増やしてください。
            
            // ⭐️課題３：６１歳以上になったら死亡として、データを削除してください
        }
    }
    
    func makeScrollView(){
        // ⭐️課題１：以下にスクロールViewをリファクタリングしてみてください
    }

}

