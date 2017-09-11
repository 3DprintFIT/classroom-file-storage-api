import Vapor
import Foundation

extension Droplet {
    func setupRoutes() throws {
        get("/") { req in
            return "Running..."
        }

        post("/") { req in

            guard let token = req.headers["Authorization"]?.string  else {
                throw Abort.unauthorized
            }


            if let t = self.config["production", "token"]?.string {
                if token != "token " + t {
                    throw Abort.unauthorized
                }
            }

            guard let filebytes = req.formData?["file"]?.part.body else {
                throw Abort.badRequest
            }

            guard let ext = req.formData?["extension"]?.string else {
                throw Abort.badRequest
            }

            let workPath = self.config.workDir

            let name = "\(UUID().uuidString).\(ext)"
            let imageFolder = "Public"
            let saveURL = URL(fileURLWithPath: workPath).appendingPathComponent(imageFolder, isDirectory: true).appendingPathComponent(name, isDirectory: false)

            do {
                let data = Data(bytes: filebytes)
                try data.write(to: saveURL)
            } catch {
                throw Abort.serverError
            }

            var json = JSON()
            try json.set("url", "https://files.jenkins.mit.ajty.cz/\(name)")
            return json
            
        }
    }
}
