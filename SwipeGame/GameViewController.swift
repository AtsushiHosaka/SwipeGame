//
//  GameViewController.swift
//  SwipeGame
//
//  Created by 保坂篤志 on 2022/12/07.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var timerProgressView: UIProgressView!
    @IBOutlet weak var actionLabel: UILabel!
    
    let gameSystem = GameSystem.shared
    var timer: Timer!
    
    var isTouched = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gameSystem.resetGame()
        
        setupTimer()
        
         nextQuestion()
    }
    
    func setupTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                      selector: #selector(self.updateUI),
                      userInfo: nil,
                      repeats: true)
        timer.fire()
    }
    
    
    @IBAction func swipeRight(_ sender: Any) {
        
        actionWasDetected(action: .swipeRight)
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        
        actionWasDetected(action: .swipeLeft)
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        
        actionWasDetected(action: .swipeUp)
    }
    
    @IBAction func swipeDown(_ sender: Any) {
        
        actionWasDetected(action: .swipeDown)
    }
    
    @IBAction func longPress(_ sender: Any) {
        
        if !isTouched {
            
            isTouched = true
            actionWasDetected(action: .longPress)
        }else {
            
            isTouched = false
        }
    }
    
    @IBAction func tap(_ sender: Any) {
        
        actionWasDetected(action: .tap)
    }
    
    @objc func updateUI() {
        
        gameSystem.currentTime -= 0.1
        timerProgressView.progress = gameSystem.currentTime / gameSystem.timeRimit
        
        if gameSystem.currentTime <= 0 {
            
            timer.invalidate()
            
            actionLabel.text = "終了！"
            
            endGame()
        }
    }
    
    func nextQuestion() {
        
        switch gameSystem.currentAction {
            
        case .swipeRight:
            
            actionLabel.text = "右にスワイプ！"
        case .swipeLeft:
            
            actionLabel.text = "左にスワイプ！"
            
        case .swipeUp:
            
            actionLabel.text = "上にスワイプ！"
        case .swipeDown:
            
            actionLabel.text = "下にスワイプ！"
        case .longPress:

            actionLabel.text = "長押し！"
            break
        case .tap:
            
            actionLabel.text = "タップ！"
        }
    }
    
    func endGame() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            self.performSegue(withIdentifier: "toResultView", sender: self.gameSystem.score)
        })
    }
    
    func actionWasDetected(action: ActionType) {
        
        if gameSystem.isCorrectAction(userAction: action) {
            
            nextQuestion()
        }else {
            
            wrongAction()
        }
    }
    
    func wrongAction() {
        
        self.view.backgroundColor = .red
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            self.view.isUserInteractionEnabled = true
            self.view.backgroundColor = .white
            self.nextQuestion()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let resultView = segue.destination as! ResultViewController
        
        resultView.score = sender as! Int
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isTouched = false
    }
}
