//
//  CharacterModel.swift
//  SwiftGameTest
//
//  Created by student on 2025/05/01.
//

import Foundation

struct CharacterModel {
    
    ///成長段階
    enum GrowthState {
        ///幼少期
        case child
        ///成長期
        case growth
        ///成熟期
        case maturity
    }
    
    ///現在の成長段階
    var currentGrowthState: GrowthState
    ///現在の体力
    var currentHP: Int
    ///最大の体力
    var maxHP: Int
    ///現在の生活環境
    var currentEnvironment: Int
    ///現在の好感度
    var currentAffection: Int
    ///最後に餌をあげた日時
    var lastFeedDate: Date?
    /// 餌をあげた回数
    var feedCount: Int
    ///成長係数
    var growthFactor: Int {
        currentAffection / 10
    }
    ///死亡推定日
    var dateOfDeath: Date
    
    ///すでに死んでいるか
    var isDead: Bool {
        let timeInterval = Date().timeIntervalSince(dateOfDeath)
        return (0 <= timeInterval)
    }
    
    ///餌をあげる
    mutating func feed() {
        var isPassed: Bool = true
        //最後の餌やりから12時間以上経過しているか判別する
        if let lastFeedDate {
            let timeInterval = Date().timeIntervalSince(lastFeedDate)
            let time = Int(timeInterval)
            let hour = time / 3600 % 24
            isPassed = (12 < hour)
        }
        //回復値を生成する
        let recoveryValue: Int
        if isPassed {
            self.feedCount += 1
            recoveryValue = 1
        }else {
            self.feedCount = 0
            recoveryValue = Int.random(in: 1..<10)
        }
        //餌をあげた日時を更新する
        lastFeedDate = Date()
        //体力を回復させる
        currentHP = min(maxHP, (currentHP + recoveryValue))
    }
    
    ///トイレ掃除
    mutating func toiletCleaning() {
        currentEnvironment = 10
    }
    
    ///好感度上昇
    mutating func affectionUp(value: Int) {
        currentAffection = min(10, currentAffection + value)
    }
}
