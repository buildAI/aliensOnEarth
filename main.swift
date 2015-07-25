import Foundation
//function to read data
func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

func appendToFile(path: String, string: String){
    let dir:NSURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DeveloperDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
    let fileurl =  dir.URLByAppendingPathComponent(path)
    
    let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    if NSFileManager.defaultManager().fileExistsAtPath(fileurl.path!) {
        var err:NSError?
        if let fileHandle = NSFileHandle(forWritingToURL: fileurl, error: &err) {
            fileHandle.seekToEndOfFile()
            fileHandle.writeData(data)
            fileHandle.closeFile()
        }
        else {
            println("Can't open fileHandle \(err)")
        }
    }
    else {
        var err:NSError?
        if !data.writeToURL(fileurl, options: .DataWritingAtomic, error: &err) {
            println("Can't write \(err)")
        }
    }
}

//function to export data to pdf file
func outputPDFFile(data: [[String: String]]) {
    var str = ""
    let txtlocation = "/Users/buildAI/Developer/aliensOnEarth/result.pdf" //output text file location
    str.writeToFile(txtlocation, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
    
    //pdf template location
    let pdfTemplateLocation = "/Users/buildAI/Developer/aliensOnEarth/pdf_template.txt".stringByExpandingTildeInPath
    var fileContent : String? = String(contentsOfFile: pdfTemplateLocation, encoding: NSUTF8StringEncoding, error: nil)
    var pdfDictTemplate = "BT /F1 12 Tf 50 Td ()Tj ET\n"
    let pdftemplate = fileContent!
    var height = 750
    let heightIndex = pdfDictTemplate.rangeOfString("Td")!.startIndex
    for i in 0..<data.count {
        var temp = pdfDictTemplate
        temp.splice("\(height) ", atIndex: heightIndex)
        var insertDataIndex = temp.rangeOfString(")")!.startIndex
        let space = "          "
        temp.splice(data[i]["home planet"]! + space, atIndex:insertDataIndex)
        temp.splice(data[i]["legs"]! + space, atIndex:insertDataIndex)
        temp.splice(data[i]["antennas"]! + space, atIndex:insertDataIndex)
        temp.splice(data[i]["blood colour"]! + space, atIndex:insertDataIndex)
        temp.splice(data[i]["code name"]! + space, atIndex:insertDataIndex)
        fileContent!.splice(temp,atIndex: fileContent!.rangeOfString("endstream")!.startIndex)
        height -= 30
    }
    appendToFile("aliensOnEarth/result.pdf", fileContent!)
    //output pdf file location
    // let pdfLocation = "/Users/buildAI/Developer/aliensOnEarth/result.pdf"
    // fileContent!.writeToFile( pdfLocation, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
}

func outputTextFile(data: [[String: String]]) {
    
    var str = ""
    let txtlocation = "/Users/buildAI/Developer/aliensOnEarth/result.txt" //output text file location
    str.writeToFile(txtlocation, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
    
    for i in 0..<data.count {
        appendToFile("aliensOnEarth/result.txt",data[i]["code name"]! + "\t")
        appendToFile("aliensOnEarth/result.txt",data[i]["blood colour"]! + "\t")
        appendToFile("aliensOnEarth/result.txt",data[i]["antennas"]! + "\t")
        appendToFile("aliensOnEarth/result.txt",data[i]["legs"]! + "\t")
        appendToFile("aliensOnEarth/result.txt",data[i]["home planet"]! + "\n")
    }
    //str.writeToFile(txtlocation, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
}

func readData() -> [String: String] {
    var dict = [String: String]()
    println("Enter the code name:")
    dict["code name"] = input()
    println("Enter the blood colour:")
    dict["blood colour"] = input()
    println("Enter the number of antennas:")
    dict["antennas"] = input()
    println("Enter the number of legs:")
    dict["legs"] = input()
    println("Enter the home planet:")
    dict["home planet"] = input()
    return dict
}

var checkToContinue = "y" //variable to store user response about inputting data
var userInput = [[String: String]]() //string array to store the input aliens' details

while (checkToContinue == "y" || checkToContinue == "Y") {
    userInput.append(readData())
    println("Press y or Y to continue, press other key to exit")
    checkToContinue = input()
}
//println("Press 1 for text file and 2 for PDF")
//var fileType = input().toInt()! //variable to store for the file type
//println(userInput)
//outputToFile(userInput,fileType)
outputPDFFile(userInput)