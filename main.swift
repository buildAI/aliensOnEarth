import Foundation
func input() -> String {
 var keyboard = NSFileHandle.fileHandleWithStandardInput()
 var inputData = keyboard.availableData
 var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
 return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

func giveItToFile(str: String, fileType: Int) {
	let location = "/Users/buildAI/Desktop/multunus/test.txt"
	//write
	str.writeToFile( location, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
}

func inputString() -> String {
	println("Enter the codeName:")
	var str = input() + "\t"
	println("Enter the blood colour:")
	str += input() + "\t"
	println("Enter the number of antennas:")
	str += input() + "\t"
	println("Enter the number of legs:")
	str += input() + "\t"
	println("Enter the home planet:")
	str += input() + "\n"
	return str
}
var checkToContinue = "y"
var userInput = ""
while (checkToContinue == "y" || checkToContinue == "Y") {
	userInput += inputString()
	println("Press y or Y to continue")
	checkToContinue = input()
}
println("Press 1 for text file and 2 for PDF")
var fileTypeCounter = input().toInt()!
giveItToFile(userInput,fileTypeCounter)