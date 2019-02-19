//
//  CardUIManager.swift
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

class CardUIManager: NSObject {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.allowsSelection = false
        }
    }
    @IBOutlet private weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        collectionView.reloadData()
        pageControl.numberOfPages = TodoManager.shared.todoList.count + 1
    }
    
    var gotoTaskVC: ((_ card: CardModel, _ task: TaskModel)->())?
}

extension CardUIManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TodoManager.shared.todoList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == TodoManager.shared.todoList.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCardCell", for: indexPath) as! AddCardCell
            cell.setup(with: self)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.setup(withCard: TodoManager.shared.todoList[indexPath.item], index: indexPath.item, delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width - 50
        let height = collectionView.bounds.size.height - collectionView.safeAreaInsets.top - collectionView.safeAreaInsets.bottom - pageControl.bounds.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == collectionView else { return }
        let pageWidth = Float(scrollView.bounds.size.width - 50)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    private func scrollToPage(_ page: Int) {
        let pageWidth = CGFloat(collectionView.bounds.size.width - 50)
        let point = CGPoint (x: CGFloat(page) * pageWidth, y: 0)
        collectionView.setContentOffset(point, animated: true)
        pageControl.currentPage = page
    }
}

extension CardUIManager: AddCardCellDelegate, CardCellDelegate {
    func addCardCellDidPressAddCard() {
        let alertController = UIAlertController(title: "Add new card", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Card title"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let text = textField.text else { return }
            TodoManager.shared.addCard(title: text)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: { [weak self] in
                let index = TodoManager.shared.todoList.count - 1
                self?.scrollToPage(index > 0 ? index : 0)
            })
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func cardCellDidPressAddTask(withCard card: CardModel) {
        let alertController = UIAlertController(title: "Add new task", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Task title"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let text = textField.text else { return }
            TodoManager.shared.addTask(title: text, to: card)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func cardCellDidPressOption(withCard card: CardModel) {
        let alertController = UIAlertController(title: "Card options", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { alert -> Void in
            TodoManager.shared.removeCard(card: card)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func cardCellDidRenameCard(_ card: CardModel, withTitle newTitle: String) {
        TodoManager.shared.renameCard(card: card, with: newTitle)
    }
}

extension CardUIManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard TodoManager.shared.todoList.indices.contains(tableView.tag) else { return 0 }
        return TodoManager.shared.todoList[tableView.tag].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        guard TodoManager.shared.todoList.indices.contains(tableView.tag), let task = TodoManager.shared.todoList[tableView.tag].tasks[indexPath.row] as? TaskModel else { return cell }
        cell.setup(withTask: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard TodoManager.shared.todoList.indices.contains(tableView.tag), let task = TodoManager.shared.todoList[tableView.tag].tasks[indexPath.row] as? TaskModel else { return }
        gotoTaskVC?(TodoManager.shared.todoList[tableView.tag], task)
    }
}
