import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject private var authManager = AuthManager()
    @StateObject private var taskManager = TaskManager()
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                TaskListView()
                    .environmentObject(authManager)
                    .environmentObject(taskManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    
    let users = [
        User(username: "User1", password: "password1"),
        User(username: "user2", password: "password2")
    ]
    
    func login(username: String, password: String) -> Bool {
        if let _ = users.first(where: { $0.username == username && $0.password == password }) {
            isAuthenticated = true
            return true
        }
        return false
    }
    
    func logout() {
        isAuthenticated = false
    }
}

struct User {
    let username: String
    let password: String
}

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var categories: [TaskCategory] = [
        TaskCategory(name: "Travail", color: .blue),
        TaskCategory(name: "Personnel", color: .green),
        TaskCategory(name: "Loisirs", color: .orange)
    ]
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func moveTask(_ task: Task, to status: TaskStatus) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].status = status
        }
    }
    
    func getTasks(for status: TaskStatus) -> [Task] {
        return tasks.filter { $0.status == status }
    }
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var status: TaskStatus
    var difficulty: TaskDifficulty
    var category: TaskCategory
}

enum TaskStatus: String, CaseIterable {
    case todo = "À faire"
    case inProgress = "En cours"
    case done = "Terminé"
}

struct TaskCategory: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var color: Color
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TaskCategory, rhs: TaskCategory) -> Bool {
        lhs.id == rhs.id
    }
}

enum TaskDifficulty: String, CaseIterable {
    case easy = "Facile"
    case medium = "Moyen"
    case hard = "Difficile"
    
    var color: Color {
        switch self {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}
