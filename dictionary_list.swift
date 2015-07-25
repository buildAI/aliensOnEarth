//dictionary to display the list of ways to export data
var fileFormatsDisplayList = [0: "Don't export data", 1: "Text Format", 2: "PDF Format"]
//dictionary to store the different functions available for exporting data
//never use 0 in this dictionary because 0 is to prevent export of data
var filesFormatsFunctionList = [1: outputTextFile, 2: outputPDFFile]