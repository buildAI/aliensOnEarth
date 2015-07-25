import Foundation

//function to read data
func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

//function append data ta to file
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

//function to call another function to export data to particular file format
func outputToFile(data: [[String:String]], fileType: Int) {
	if fileType == 0 {
		exit(0)
	}else {
		for i in 0..<filesFormatsFunctionList.count {
			if fileType == (i + 1) {
				filesFormatsFunctionList[i+1]!(data)
			}
		}
	}
	
}

//function to read user input
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

println("Please press the key for respective export of data")
for i in 0..<fileFormatsDisplayList.count {
	println("\(i).\(fileFormatsDisplayList[i]!)")
}
var fileType = input().toInt()! //variable to store for the file type
outputToFile(userInput,fileType)