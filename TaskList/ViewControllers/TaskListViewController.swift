//
//  ViewController.swift
//  TaskList
//
//  Created by Айдар Оспанов on 04.04.2023.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController {
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    private var taskList: [Task] = []
    private let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //tableView.rowHeight = 60
        setupNavigationBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

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
}

// MARK: Private Methods

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
    
    private func addNewTask() {
//        let taskVC = TaskViewController()
//        //taskVC.modalPresentationStyle = .fullScreen
//        present(taskVC, animated: true)
        
        
        showAlert(withTitle: "New Task", andMessage: "What do you want to do?") { [unowned self] taskName in
            saveTask(taskName)
        }
    }
    
    private func saveTask(_ taskName: String) {
        let task = Task(context: viewContext)
        task.title = taskName
        taskList.append(task)
        
        let indexPath = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch (let error) {
                print(error)
            }
        }
    }
    
//    private func fetchData() {
//        let fetchRequest = Task.fetchRequest()
//
//        do {
//            taskList = try viewContext.fetch(fetchRequest)
//        } catch {
//            print(error)
//        }
//    }
}
