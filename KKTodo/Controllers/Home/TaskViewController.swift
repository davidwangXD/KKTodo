//
//  TaskViewController.swift
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

class TaskViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet private var maskButton: CustomButton!
    @IBOutlet private var baseView: CustomView!
    @IBOutlet private var titleTextView: CustomTextView!
    
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
        titleTextView.text = task?.title ?? ""
        titleTextView.delegate = self
        let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
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
    
    private func dismiss() {
        view.endEditing(false)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction private func closeButtonPress(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction private func deleteButtonPress(_ sender: UIButton) {
        guard let card = card, let task = task else { return }
        TodoManager.shared.removeTask(task: task, from: card)
        dismiss()
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightText
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.clear
        if textView.text.count > 0, let task = task {
            TodoManager.shared.renameTask(task: task, with: textView.text)
        } else {
            textView.text = task?.title
        }
    }
}
