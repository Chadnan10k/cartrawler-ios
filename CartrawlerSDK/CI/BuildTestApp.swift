//
//  BuildTestApp.swift
//  CI
//
//  Created by Lee Maguire on 12/01/2017.
//
//

import Foundation

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

func main() {
    shell("pod")
}

main()
