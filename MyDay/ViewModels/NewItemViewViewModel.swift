//
//  NewItemViewViewModel.swift
//  MyDay
//
//  Created by Sp1der on 2023/8/5.
//

import Foundation

class NewItemViewViewModel: ObservableObject {
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var items: [ToDoListItem] = []
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        let newId = UUID().uuidString
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createDate: Date().timeIntervalSince1970,
            isDone: false)
        var currentTodos = loadStructs()
        if currentTodos != nil {
            currentTodos?.append(newItem)
            if let encoded = try? encoder.encode(currentTodos) {
                defaults.set(encoded, forKey: "todos")
                self.items = currentTodos ?? []
                print("yes2")
            }
        } else {
            if let encoded = try? encoder.encode([newItem]) {
                defaults.set(encoded, forKey: "todos")
                self.items = [newItem]
                print("yes1")
            }
        }
        
    }
    
    func loadStructs() -> [ToDoListItem]? {
        if let todos = defaults.object(forKey: "todos") as? Data {
            if let loadedTodos = try? decoder.decode(Array<ToDoListItem>.self, from: todos) {
                print(loadedTodos)
                self.items = loadedTodos
                return loadedTodos
            }
        }
        return nil
    }
    
    // 辅助方法，找到给定 ID 的待办事项的索引
    func findIndex(by id: String) -> Int? {
        return items.firstIndex { $0.id == id }
    }

    // 删除函数，根据给定的 ID 删除对应的待办事项
    func delete(by id: String) {
        guard let index = findIndex(by: id) else {
            // 没找到对应的待办事项
            return
        }

        items.remove(at: index)
        
        // 将更新后的待办事项列表保存到 UserDefaults
        if let encoded = try? encoder.encode(items) {
            defaults.set(encoded, forKey: "todos")
        }
    }
    
    func deleteDone() {
        for item in items {
            if item.isDone {
                guard let index = findIndex(by: item.id) else {
                    // 没找到对应的待办事项
                    return
                }
                items.remove(at: index)
            }
        }
        // 将更新后的待办事项列表保存到 UserDefaults
        if let encoded = try? encoder.encode(items) {
            defaults.set(encoded, forKey: "todos")
        }
    }
    
    func toggleIsDone(by id: String) {
        guard let index = findIndex(by: id) else {
            // 没找到对应的待办事项
            return
        }

        items[index].setDone(!items[index].isDone)
        
        // 将更新后的待办事项列表保存到 UserDefaults
        if let encoded = try? encoder.encode(items) {
            defaults.set(encoded, forKey: "todos")
        }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
    
}
