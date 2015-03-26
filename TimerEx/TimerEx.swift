//
//  TimerEx.swift
//  TimerEx
//
//  Created by Ryo Nakano on 2015/03/26.
//  Copyright (c) 2015年 Peppermint Club. All rights reserved.
//

import UIKit

// タイマーの処理
class TimerEx: UIView {
    var _timer: NSTimer?
    var _image: UIImage?
    var _px = 0
    var _py = 0
    var _vx = 4
    var _vy = 4
    
    // 初期化
    required init(coder: NSCoder) {
        super.init(coder: coder)

        // 画像の読み込み
        _image = UIImage(named: "sample.png")
        
        // XY座標の初期化
        _px = Int(UIScreen.mainScreen().bounds.size.width/2)
        _py = Int(UIScreen.mainScreen().bounds.size.height/2)
        
    }

    // 描画時に呼ばれる
    override func drawRect(rect: CGRect) {
        // イメージの描画
        _image?.drawAtPoint(CGPointMake(CGFloat(_px)-40, CGFloat(_py)-40))
    }
    
    // タッチ終了時に呼ばれる
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if _timer == nil {
            _timer = NSTimer.scheduledTimerWithTimeInterval(1.0/30.0,
                target: self,
                selector: "onTick:",
                userInfo: nil,
                repeats: true)
        } else {
            // タイマーの停止
            _timer?.invalidate()
            _timer = nil
        }
    }
    
    // 定期処理
    func onTick(timer: NSTimer) {
        // 移動
        _px += _vx
        _py += _vy
        if _px < 0 {_vx = 4}
        if Int(self.bounds.size.width) < _px {_vx = -4}
        if _py < 0 {_vy = 4}
        if Int(self.bounds.size.height) < _py {_vy = -4}
    
        // 再描画
        self.setNeedsDisplay()
    }
}