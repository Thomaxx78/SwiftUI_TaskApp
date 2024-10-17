import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskManager: TaskManager
    @State private var taskTitle = ""
    @State private var taskDifficulty = TaskDifficulty.medium
    @State private var selectedCategory: TaskCategory?
    @State private var taskStatus = TaskStatus.todo
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Titre de la tâche", text: $taskTitle)
                
                Picker("Statut", selection: $taskStatus) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                
                Picker("Difficulté", selection: $taskDifficulty) {
                    ForEach(TaskDifficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Catégorie", selection: $selectedCategory) {
                    ForEach(taskManager.categories) { category in
                        Text(category.name).tag(category as TaskCategory?)
                    }
                }
            }
            .navigationTitle("Ajouter une tâche")
            .navigationBarItems(
                leading: Button("Annuler") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Ajouter") {
                    if let category = selectedCategory {
                        let newTask = Task(title: taskTitle, status: taskStatus, difficulty: taskDifficulty, category: category)
                        taskManager.addTask(newTask)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(taskTitle.isEmpty || selectedCategory == nil)
            )
        }
        .onAppear {
            selectedCategory = taskManager.categories.first
        }
    }
}
