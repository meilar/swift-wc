import ArgumentParser
import Foundation


public func printBytes(path: String) throws {
    if let fileAttributes = try? FileManager.default.attributesOfItem(atPath: path) {
        if let bytes = fileAttributes[.size] as? Int64 {
            print("Number of bytes is \(bytes)")
        }
    }
}

public func printLines(path: String) throws {
    let contents = try String(contentsOfFile: path)
    let lines = contents.components(separatedBy: "\n")
    print(lines.count - 1)
}

@main
struct Tool: ParsableCommand {
    @Argument(help: "paste the path to the file you want to parse")
    public var path: String
    
    @Flag(name: .short)
    var line = false
    
    public func run() throws {
        
        if line {
            do {
                try(printLines(path: self.path))
            }
            catch {
                print("Could not count lines")
            }
        } else {
            
            do {
                try printBytes(path: self.path)
            }
            catch  {
                print("No text file found at that location")
            }
            
        }
    }
}
