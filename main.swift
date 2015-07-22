import Foundation
//function to read data
func input() -> String {
	var keyboard = NSFileHandle.fileHandleWithStandardInput()
	var inputData = keyboard.availableData
	var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
	return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

//function to export data to text file
func outputTextFile(data: [String]) {
	var str = ""
	let location = "/Users/buildAI/Developer/aliensOnEarth/result.txt"
	for i in 0..<data.count {
		str += data[i]
	}
	str.writeToFile(location, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
}

//function to export data to pdf file
func outputPDFFile(data: [String]) {
	let location1 = "/Users/buildAI/Developer/aliensOnEarth/pdf_template.txt".stringByExpandingTildeInPath
	var fileContent : String? = String(contentsOfFile: location1, encoding: NSUTF8StringEncoding, error: nil)
	var pdfDictTemplate = "BT /F1 12 Tf 50 Td ()Tj ET\n"
	let pdftemplate = fileContent!
	var height = 750
	let heightIndex = pdfDictTemplate.rangeOfString("Td")!.startIndex
	for i in 0..<data.count {
		var temp = pdfDictTemplate
		temp.splice("\(height) ", atIndex: heightIndex)
		var insertDataIndex = temp.rangeOfString(")")!.startIndex
		temp.splice(data[i], atIndex:insertDataIndex)
		fileContent!.splice(temp,atIndex: fileContent!.rangeOfString("endstream")!.startIndex)
		height -= 30
	}
    let location2 = "/Users/buildAI/Developer/aliensOnEarth/result.pdf"
    fileContent!.writeToFile( location2, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
}

//function to call another function to export data to particular file format
func outputToFile(str: [String], fileType: Int) {
	if fileType == 1 {
		outputTextFile(str)
	} else if fileType == 2 {
		outputPDFFile(str)
	}
	
}

//function to store the each instance of user input data
func inputString() -> String {
	let space = "                  "
	println("Enter the code name:")
	var str = input() + space
	println("Enter the blood colour:")
	str += input() + space
	println("Enter the number of antennas:")
	str += input() + space 
	println("Enter the number of legs:")
	str += input() + space
	println("Enter the home planet:")
	str += input() + "\n"
	return str
}

var checkToContinue = "y" //variable to store user response about inputting data
var userInput = [String]() //string array to store the input aliens' details

while (checkToContinue == "y" || checkToContinue == "Y") {
	userInput.append(inputString())
	println("Press y or Y to continue, press other key to exit")
	checkToContinue = input()
}

println("Press 1 for text file and 2 for PDF")
var fileType = input().toInt()! //variable to store for the file type
outputToFile(userInput,fileType)