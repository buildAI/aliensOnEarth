import Foundation
//function to export data to pdf file
public func outputPDFFile(data: [[String: String]]) {
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
    
}

//function to export data to text file
public func outputTextFile(data: [[String: String]]) {
    
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
}