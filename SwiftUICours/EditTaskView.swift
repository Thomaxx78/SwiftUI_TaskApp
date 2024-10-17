import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskManager: TaskManager
    @Binding var task: Task
    
    @State private var editedTitle: String
    @State private var editedDifficulty: TaskDifficulty
    @State private var editedCategory: TaskCategory
    @State private var editedStatus: TaskStatus
    
    init(task: Binding<Task>) {
        self._task = task
        self._editedTitle = State(initialValue: task.wrappedValue.title)
        self._editedDifficulty = State(initialValue: task.wrappedValue.difficulty)
        self._editedCategory = State(initialValue: task.wrappedValue.category)
        self._editedStatus = State(initialValue: task.wrappedValue.status)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Titre de la tâche", text: $editedTitle)
                
                Picker("Statut", selection: $editedStatus) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                
                Picker("Difficulté", selection: $editedDifficulty) {
                    ForEach(TaskDifficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Catégorie", selection: $editedCategory) {
                    ForEach(taskManager.categories) { category in
                        Text(category.name).tag(category)
                    }
                }
            }
            .navigationTitle("Modifier la tâche")
            .navigationBarItems(
                leading: Button("Annuler") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Enregistrer") {
                    task.title = editedTitle
                    task.difficulty = editedDifficulty
                    task.category = editedCategory
                    task.status = editedStatus
                    taskManager.updateTask(task)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
