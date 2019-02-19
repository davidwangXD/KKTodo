//
//  TodoManager.swift
//  KKTodo
//
//  Created by David Wang on 2019/2/19.
//  Copyright © 2019 David Wang. All rights reserved.
//

import Foundation

class TodoManager {
    static let shared = TodoManager()
    
    private(set) var todoList: [CardModel] {
        get {
            return getTodoList()
        }
        set {
            saveTodoList(newValue)
        }
    }
    
    var dataDidChange: (()->())?
    
    private var cards: [CardModel]?
    
    // MARK: - Public methods
    func addCard(title: String) {
        todoList.append(CardModel(title: title))
    }
    
    func removeCard(card: CardModel) {
        todoList.removeAll(where: { $0 == card })
    }
    
    func renameCard(card: CardModel, with newTitle: String) {
        card.title = newTitle
        saveTodoList(todoList)
    }
    
    func addTask(title: String, to card: CardModel) {
        card.tasks.add(TaskModel(title: title))
        saveTodoList(todoList)
    }
    
    func removeTask(task: TaskModel, from card: CardModel) {
        guard card.tasks.contains(task) else { return }
        card.tasks.remove(task)
        saveTodoList(todoList)
    }
    
    func renameTask(task: TaskModel, with newTitle: String) {
        task.title = newTitle
        saveTodoList(todoList)
    }
    
    // MARK: - Private methods
    private func getTodoList() -> [CardModel] {
        if let cards = cards {
            return cards
        } else {
            cards = loadFiles() ?? [CardModel]()
            return cards!
        }
    }
    
    private func saveTodoList(_ todoList: [CardModel]) {
        cards = todoList
        dataDidChange?()
        saveFile(cards!)
    }
    
    // MARK: NSKeyedArchiver
    private var filePath: URL {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        return url.appendingPathComponent("todoListData")!
    }
    
    private func saveFile(_ todoList: [CardModel]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cards!, requiringSecureCoding: false)
            try data.write(to: filePath)
        } catch {
            print("Couldn't save file.")
        }
    }
    
    private func loadFiles() -> [CardModel]? {
        if let nsData = NSData(contentsOf: filePath) {
            do {
                let data = Data(referencing:nsData)
                if let storedCards = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<CardModel> {
                    return storedCards
                }
            } catch {
                print("Couldn't read file.")
                return nil
            }
        }
        return nil
    }
}
