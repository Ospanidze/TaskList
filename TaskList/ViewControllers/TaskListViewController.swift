//
//  ViewController.swift
//  TaskList
//
//  Created by Айдар Оспанов on 04.04.2023.
//

import UIKit

final class TaskListViewController: UITableViewController {
    
    //MARK: Private Properties
    
    private let storageManager = StorageManager.shared
    private let cellID = "cellID"
    private var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        fetchData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: Private Methods
    
    private func fetchData() {
        storageManager.fetchData { [weak self] result in
            switch result {
            case .success(let task):
                self?.taskList = task
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addNewTask() {
        showAlert(withTitle: "New Task", andMessage: "What do you want to do?") { [unowned self] taskName in
            saveTask(taskName)
        }
    }
    
    private func saveTask(_ taskName: String) {
        let indexPath = IndexPath(row: taskList.count - 1, section: 0)
        storageManager.save(taskName) { [weak self] task in
            self?.taskList.append(task)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: UITableViewDataSource

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        
        if editingStyle == .delete {
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            storageManager.delete(task: task)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = taskList[indexPath.row]
        
        showAlert(withTitle: "Update Task", andMessage: "What do you want to do", nameTask: task.title ?? "") { [weak self] newTask in
            self?.storageManager.edit(task: task, newTask: newTask)
            self?.tableView.reloadData()
        }
    }
}

// MARK: Setup NavigationBar

extension TaskListViewController {
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(named: "MilkBlue") ?? .blue
        
        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.st
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction { [unowned self] _ in
            addNewTask()
        })
        
        navigationController?.navigationBar.tintColor = .white
    }
}
