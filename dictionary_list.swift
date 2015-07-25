var autoIncrementer1 = 0
//dictionary to display the list of ways to export data
var fileFormatsDisplayList = [autoIncrementer1++: "Don't export data", autoIncrementer1++: "Text Format", autoIncrementer1++: "PDF Format"]
//dictionary to store the different functions available for exporting data
//never use 0 in this dictionary because 0 is to prevent export of data
var autoIncrementer2 = 0
var filesFormatsFunctionList = [++autoIncrementer2: outputTextFile, ++autoIncrementer2: outputPDFFile]