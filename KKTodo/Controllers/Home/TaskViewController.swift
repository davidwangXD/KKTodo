//
//  TaskViewController.swift
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

class TaskViewController: BaseViewController {

    @IBOutlet private var maskButton: CustomButton!
    @IBOutlet private var baseView: CustomView!
    @IBOutlet private var titleLabel: CustomLabel!
    
    private var card: CardModel?
    private var task: TaskModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    // MARK: - Setup
    class func create(sourceVC: UIViewController?, card: CardModel, task: TaskModel) -> TaskViewController {
        let taskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        taskVC.card = card
        taskVC.task = task
        
        sourceVC?.present(taskVC, animated: true, completion: nil)
        
        return taskVC
    }
    
    private func setupUI() {
        maskButton.alpha = 0.5
        baseView.alpha = 0.5
        titleLabel.text = task?.title ?? ""
    }
    
    private func setupAnimation() {
        baseView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.baseView.transform = CGAffineTransform.identity
            self.baseView.alpha = 1.0
            self.maskButton.alpha = 1.0
        }) { (finished) in
        }
    }
    
    // MARK: - Actions
    @IBAction private func closeButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func deleteButtonPress(_ sender: UIButton) {
        guard let card = card, let task = task else { return }
        TodoManager.shared.removeTask(task: task, from: card)
        dismiss(animated: true, completion: nil)
    }

}
