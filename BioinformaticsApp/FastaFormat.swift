//
//  FastaFile.swift
//  BioinformaticsApp
//
//  Created by Lizhen on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import Foundation

func uniqueSeq() -> String {
    struct Holder {
        static var index = 0
    }
    return "S0000\(++Holder.index)";
}


class DNASequence {
    var accession:String = uniqueSeq()
    var version:String = "Unknown-Version"
    var description:String = "A DNA Sequence"
    var sequence:String = "ACGT"

    var header: String {
        return ">" + version + " " + description
    }
    
    init(){
        
    }
    
    init(accession id:String, version v:String, description desc:String, sequence seq:String){
        self.accession=id
        self.version=v
        self.description=desc
        self.sequence=seq
    }
}

func readFastaEmbeded(fastaid :String) -> DNASequence {
    let path = NSBundle.mainBundle().pathForResource(fastaid, ofType: "fasta")
    let text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding,
        error: nil)
   return parseDNASequence(fastaid,text!)
}

func parseDNASequence(id:String, text: String) -> DNASequence {
    let lines=text.componentsSeparatedByString("\n")
    var header=lines[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    header=header.substringFromIndex(advance(header.startIndex,1))
    let idx = find(header, " ")!;
    let pos = distance(header.startIndex, idx);
   
    let version:String  = header.substringToIndex(advance(header.startIndex,pos+1))
    let desc:String = header.substringFromIndex(advance(header.startIndex,pos+1))
    var seq=""
    for i in 1..<lines.count {
        seq = seq + lines[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    return DNASequence(accession:id, version: version, description:desc, sequence: seq)
}


func writeToFile(filePath:String, sequences:[DNASequence]){
    var allRecords:NSMutableArray=[]
    for var i = 0; i < sequences.count; i++ {
        let seq=sequences[i]
        var stringRecord:NSMutableDictionary = ["accession":seq.accession, "version":seq.version, "description":seq.description, "sequence":seq.sequence]
        allRecords.addObject(stringRecord)
        
    }
    allRecords.writeToFile(filePath, atomically: true)
}


func readFromFile(filePath:String)->[DNASequence]{
    let array = NSArray(contentsOfFile: filePath)!
    var sequences: [DNASequence]=[]
    for var i = 0; i < array.count; i++ {
        let dictRecord = (array[i] as! NSDictionary)
        let seq=DNASequence(accession: (dictRecord["accession"] as! String),version:(dictRecord["version"] as! String),  description:(dictRecord["description"] as! String), sequence:(dictRecord["sequence"] as! String))
        sequences.append(seq)
    }
    return sequences
}


func dataFilePath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(
        NSSearchPathDirectory.DocumentDirectory,
        NSSearchPathDomainMask.UserDomainMask, true)
    let documentsDirectory = paths[0] as! NSString
    return documentsDirectory.stringByAppendingPathComponent("DNASequence.plist")  as String
}

func validateSequence(seqText:String)->String? {
    let whitespaces = NSCharacterSet(charactersInString: " \t\r\n")
    let dnachars=NSCharacterSet(charactersInString: "ACGTacgt")
    var newSeqText=""
    for char in seqText.unicodeScalars {
        if whitespaces.longCharacterIsMember(char.value) {
            
        } else if dnachars.longCharacterIsMember(char.value) {
           newSeqText.append(Character(char))
        } else {
            return nil
        }
    }
    
    return newSeqText
}