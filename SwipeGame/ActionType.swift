//
//  ActionType.swift
//  SwipeGame
//
//  Created by 保坂篤志 on 2022/12/07.
//

import Foundation

enum ActionType {
    
    case swipeRight
    case swipeLeft
    case swipeUp
    case swipeDown
    case tap
    case longPress
    
    func getRandomAction() -> ActionType {
        
        let type = Int.random(in: 0...5)
        
        switch type {
            
        case 0:
            return .swipeRight
        case 1:
            return .swipeLeft
        case 2:
            return .swipeUp
        case 3:
            return .swipeDown
        case 4:
            return .tap
        case 5:
            return .longPress
        default:
            return .swipeRight
        }
    }
}
