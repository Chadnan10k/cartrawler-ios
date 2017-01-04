//
//  Integrate.swift
//  CI
//
//  Created by Lee Maguire on 04/01/2017.
//
//

import Foundation

let file = "Frameworks1.json"

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
    
}

func writeToFile(data: String!) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        
        let path = dir.appendingPathComponent(file)
        do {
            try data.write(to: path, atomically: false, encoding: String.Encoding.utf8)
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
    
    init(dict: [String : Any]) {
        name = dict["name"] as! String
        version = dict["version"] as! String
    }
    
    static func arrayFromDictionary(dict: [String : Any]) -> [Framework] {
        var frameworks:[Framework] = []
        
        for obj in dict["frameworks"] as! [[String : Any]] {
            frameworks.append(Framework(dict:obj))
        }
        
        return frameworks
    }
}

extension String {
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int.init($0) ?? 0 }
    }
}

//Start Integration
print("Making sure we are building a new version of this framework..")

if !frameworkListExists(filename: file) {
    //create the file
    print("Initializing json file")
    let initData = ["frameworks" :
                [
                    [ "name" : "CartrawlerAPI", "version" : "2.0.0" ],
                    [ "name" : "CartrawlerSDK", "version" : "2.0.0" ],
                    [ "name" : "CartrawlerRental", "version" : "2.0.0" ],
                    [ "name" : "CartrawlerInPath", "version" : "2.0.0" ]
                ]
               ]
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: initData, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        writeToFile(data: jsonString!)
    } catch {
        print("cannot create init dict")
        print(error.localizedDescription)
    }
}

func start(_ args: [String]) {
    let frameworkToCheck = args[1]
    let versionToCheck = args[2]
    
    let storeVersion = "3.14.10"
    let currentVersion = "3.130.10"
    storeVersion.versionToInt().lexicographicallyPrecedes(currentVersion.versionToInt())

    
    
    print("Reading from json file...")
    let jsonList = readFromFile()
    let frameworks = Framework.arrayFromDictionary(dict: jsonList)
    for framework in frameworks {
        if framework.name == frameworkToCheck {
            print("last version: " + framework.version)
            print("new version: " + versionToCheck)
            let versionCheck = framework.version.versionToInt().lexicographicallyPrecedes(versionToCheck.versionToInt())
            if versionCheck {
                //we have a new version let write to file
                framework.version = versionToCheck
                save(frameworks)
            } else {
                // there is no new version to push to cocoapods
            }
            
        }
    }
    
}

start(CommandLine.arguments)


