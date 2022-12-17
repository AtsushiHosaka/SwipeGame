//
//  ResultViewController.swift
//  SwipeGame
//
//  Created by 保坂篤志 on 2022/12/07.
//

import UIKit

class ResultViewController: UIViewController {
    
    var score: Int = 0

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        scoreLabel.text = "score : \(score)"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
}
