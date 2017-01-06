//
//  Integrate.swift
//  CI
//
//  Created by Lee Maguire on 04/01/2017.
//
//

import Foundation

let file = "CT_iOS_Frameworks.json"

func frameworkListExists(filename: String!) -> Bool {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    let filePath = url.appendingPathComponent(filename)?.path
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath!) {
        return true
    } else {
        return false
    }
}

func save(_ frameworks: [Framework]) {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: Framework.convertToDictionary(frameworks), options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        writeToFile(data: jsonString!)
    } catch {
        print("cannot write new dict")
        print(error.localizedDescription)
    }
}

func writeToFile(data: String!) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        
        let path = dir.appendingPathComponent(file)
        do {
            print("writing new values to file..")
            try data.write(to: path, atomically: true, encoding: String.Encoding.utf8)
        }
        catch { print("error writing to file") }
    }
}

func readFromFile() -> [String: Any] {
    var json = ""

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        
        let path = dir.appendingPathComponent(file)
        //reading
        do {
            json = try String(contentsOf: path, encoding: String.Encoding.utf8)
        }
        catch { print("error reading from file") }
    }
    
    //parse to json
    
    return convertToDictionary(text: json)!
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

@discardableResult func run(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = args
    print(args)
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

struct Framework {
    var name: String!
    var version: String!
    var buildNum = 0
    
    init(name: String!, version: String!) {
        self.name = name
        self.version = version
        buildNum = 1
    }
    
    init(dict: [String : Any]) {
        name = dict["name"] as! String
        version = dict["version"] as! String
        buildNum = dict["buildNum"] as? Int ?? 1
    }

    static func arrayFromDictionary(dict: [String : Any]) -> [Framework] {
        var frameworks:[Framework] = []
        guard let list = dict["frameworks"] as? [[String : Any]] else {
            return []
        }
        
        for obj in list {
            frameworks.append(Framework(dict:obj))
        }
        return frameworks
    }
}

extension Framework {
    static func convertToDictionary(_ objects: [Framework]) -> [String : Any] {
        var dict:[[String:Any]] = []
        for obj in objects {
            dict.append(["name" : obj.name, "version" : obj.version.strip(), "buildNum" : obj.buildNum])
        }
        
        return ["frameworks" : dict]
    }
}

extension String {
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int.init($0) ?? 0 }
    }
    
    func strip() -> String {
        return self.replacingOccurrences(of: "\n", with: "")
    }
}

@discardableResult
func shell(_ args: String...) -> String {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)
    print(output!)
    return output!
}

//Start Integration
print("Making sure we are building a new version of this framework..")

func start(_ args: [String]) {
    let frameworkToCheck = args[1]
    let buildScheme: String = args[2]
    let artifactsDir = args[3]
    let buildDir = args[4]
    
    print("WORKSPACE LOCATION: \(buildDir)")

    shell("mkdir", "-p", "\(artifactsDir)")
    shell("/usr/bin/xcodebuild" ,"build" ,"-workspace", "\(buildDir)" ,"-scheme", "\(buildScheme)")

    let versionToCheck = shell("defaults", "read", "\(artifactsDir)/\(frameworkToCheck).framework/Info", "CFBundleShortVersionString").strip()
    
    if !frameworkListExists(filename: file) {
        print("file does not exist")
        print("adding \(frameworkToCheck) to the framework list")
        save([Framework.init(name: frameworkToCheck, version: versionToCheck)])
    } else {
        print("Reading from json file...")
        let jsonList = readFromFile()
        var frameworks = Framework.arrayFromDictionary(dict: jsonList)
        var found = false

        for i in 0..<frameworks.count {
            if frameworks[i].name == frameworkToCheck {
                found = true
                print("last version: " + frameworks[i].version)
                print("new version: " + versionToCheck)
                frameworks[i].buildNum = frameworks[i].buildNum+1
                let versionCheck = frameworks[i].version.strip().versionToInt().lexicographicallyPrecedes(versionToCheck.versionToInt())
                
                if versionCheck {
                    //we have a new version let write to file
                    frameworks[i].version = versionToCheck
                    print("now lets push to cocoapods")
                    shell("Cocoapod", frameworkToCheck, versionToCheck)
                } else {
                    // there is no new version to push to cocoapods
                    print("This version of \(frameworkToCheck) already exists 👞💥")
                }
            }
        }
        
        save(frameworks)
        
        if !found {
            print("adding \(frameworkToCheck) to the framework list")
            frameworks.append(Framework.init(name: frameworkToCheck, version: versionToCheck))
            save(frameworks)
        }
    }
    
    print("Finished building \(frameworkToCheck)🎉 \(buildDir)")
}

start(CommandLine.arguments)


