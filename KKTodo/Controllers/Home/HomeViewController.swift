//
//  HomeViewController.swift
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var cardUIManager: CardUIManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        TodoManager.shared.dataDidChange = { [weak self] in
            self?.cardUIManager.updateUI()
        }
        
        cardUIManager.gotoTaskVC = { [weak self] (card, task) in
            _ = TaskViewController.create(sourceVC: self, card: card, task: task)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cardUIManager.updateUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
