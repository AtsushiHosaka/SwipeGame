//
//  GameSystem.swift
//  SwipeGame
//
//  Created by 保坂篤志 on 2022/12/07.
//

import Foundation

class GameSystem {
    
    static let shared = GameSystem()
    
    var currentAction: ActionType = .swipeRight
    var score: Int = 0
    
    let timeRimit: Float = 20
    var currentTime: Float = 0
    
    func resetGame() {
        
        score = 0
        currentTime = timeRimit
        
        setupGame()
    }
    
    func isCorrectAction(userAction: ActionType) -> Bool {
        
        if userAction == currentAction {
            
            score += 1
            setupGame()
            return true
        }else {
            
            setupGame()
            return false
        }
    }
    
    func setupGame() {
        
        currentAction = currentAction.getRandomAction()
    }
}

