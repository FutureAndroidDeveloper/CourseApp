import Foundation


enum TableStore {
    case tasks
    case courses
    
    var name: String {
        switch self {
        case .tasks:
            return "tasks"
        case .courses:
            return "courses"
        }
    }
}


class FileStore {
    
    var documentsDirectory : URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    private var tasks: [UserTaskCreateRequest]
    private var courses: [CourseCreateRequest]
    
    
    init() {
        tasks = []
        courses = []
        get(table: .tasks)
        get(table: .courses)
    }
    
    func getCourses() -> [CourseCreateRequest] {
        get(table: .courses)
        return courses
    }
    
    func getTasks() -> [UserTaskCreateRequest] {
        get(table: .tasks)
        return tasks
    }
    
    func printTasks() {
        print()
        tasks.forEach {
            print()
            print($0)
        }
    }
    
    func printCourses() {
        print()
        courses.forEach {
            print()
            print($0)
        }
    }
    
    func save(_ task: UserTaskCreateRequest) {
        tasks.append(task)
        save(table: .tasks)
    }
    
    func save(_ course: CourseCreateRequest) {
        courses.append(course)
        save(table: .courses)
    }
    
    func save(table: TableStore) {
        let fileURL = documentsDirectory.appendingPathComponent("\(table.name).plist")
        
        do {
            var dataToSave: Data
            
            switch table {
            case .tasks:
                dataToSave = try PropertyListEncoder().encode(self.tasks)
            case .courses:
                dataToSave = try PropertyListEncoder().encode(self.courses)
            }
            
            try dataToSave.write(to: fileURL)
        } catch {
            print(error)
        }
    }

    func get(table: TableStore) {
        let fileURL = documentsDirectory.appendingPathComponent("\(table.name).plist")
        do {
            let data = try Data(contentsOf: fileURL)
                        
            switch table {
            case .tasks:
                self.tasks = try PropertyListDecoder().decode([UserTaskCreateRequest].self, from: data)
                print(self.tasks)
            case .courses:
                self.courses = try PropertyListDecoder().decode([CourseCreateRequest].self, from: data)
                print(self.courses)
            }
            
        } catch {
            print("read error:", error)
        }
    }
    
    
//    private func save(text: String,
//                      toDirectory directory: String,
//                      withFileName fileName: String) {
//        guard let filePath = self.append(toPath: directory,
//                                         withPathComponent: fileName) else {
//            return
//        }
//
//        do {
//            try text.write(toFile: filePath,
//                           atomically: true,
//                           encoding: .utf8)
//        } catch {
//            print("Error", error)
//            return
//        }
//
//        print("Save successful")
//    }
//
//    private func read(fromDocumentsWithFileName fileName: String) {
//        guard let filePath = self.append(toPath: self.documentDirectory(),
//                                         withPathComponent: fileName) else {
//                                            return
//        }
//
//        do {
//            let savedString = try String(contentsOfFile: filePath)
//
//            print(savedString)
//        } catch {
//            print("Error reading saved file")
//        }
//    }
//
//    private func documentDirectory() -> String {
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
//                                                                    .userDomainMask,
//                                                                    true)
//        return documentDirectory[0]
//    }
//
//    private func append(toPath path: String,
//                        withPathComponent pathComponent: String) -> String? {
//        if var pathURL = URL(string: path) {
//            pathURL.appendPathComponent(pathComponent)
//
//            return pathURL.absoluteString
//        }
//
//        return nil
//    }
}
