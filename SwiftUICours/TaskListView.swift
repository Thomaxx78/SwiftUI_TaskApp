import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var taskManager: TaskManager
    @State private var showingAddTask = false
    @State private var editingTask: Task?
    @State private var selectedCategory: TaskCategory?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Catégorie", selection: $selectedCategory) {
                        Text("Toutes").tag(nil as TaskCategory?)
                        ForEach(taskManager.categories) { category in
                            Text(category.name).tag(category as TaskCategory?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()

                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        TaskSection(status: status, selectedCategory: selectedCategory)
                    }
                }
                .padding()
            }
            .navigationTitle("Mes Tâches")
            .navigationBarItems(
                leading: Button("Déconnexion") {
                    authManager.logout()
                },
                trailing: Button(action: {
                    showingAddTask = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddTask) {
                AddTaskView()
            }
            .sheet(item: $editingTask) { task in
                EditTaskView(task: binding(for: task))
            }
        }
    }

    private func binding(for task: Task) -> Binding<Task> {
        guard let index = taskManager.tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Can't find task in array")
        }
        return $taskManager.tasks[index]
    }
}

struct TaskSection: View {
    @EnvironmentObject var taskManager: TaskManager
    let status: TaskStatus
    let selectedCategory: TaskCategory?

    var filteredTasks: [Task] {
        let tasks = taskManager.getTasks(for: status)
        if let category = selectedCategory {
            return tasks.filter { $0.category == category }
        }
        return tasks // retourne toutes les tâches si aucune catégorie n'est sélectionnée
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(status.rawValue)
                .font(.title2)
                .fontWeight(.bold)

            if filteredTasks.isEmpty {
                EmptyStateView(status: status)
            } else {
                ForEach(filteredTasks) { task in
                    TaskRow(task: task)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct EmptyStateView: View {
    let status: TaskStatus

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "tray")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("Aucune tâche \(status.rawValue.lowercased())")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct TaskRow: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var showingEditTask = false
    let task: Task

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(task.title)
                    .font(.headline)
                HStack {
                    Text(task.difficulty.rawValue)
                        .font(.caption)
                        .padding(5)
                        .background(task.difficulty.color.opacity(0.2))
                        .cornerRadius(5)
                    Text(task.category.name)
                        .font(.caption)
                        .padding(5)
                        .background(task.category.color.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            Spacer()
            Button(action: {
                showingEditTask = true
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .sheet(isPresented: $showingEditTask) {
            EditTaskView(task: binding(for: task))
        }
    }

    private func binding(for task: Task) -> Binding<Task> {
        guard let index = taskManager.tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Can't find task in array")
        }
        return $taskManager.tasks[index]
    }
}
