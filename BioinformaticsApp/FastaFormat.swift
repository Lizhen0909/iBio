//
//  FastaFile.swift
//  BioinformaticsApp
//
//  Created by Lizhen on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import Foundation


class DNASequence {
    var accession:String = "ABC00001"
    var version:String = "Unknown-Version"
    var description:String = "A DNA Sequence"
    var sequence:String = "ACGT"

    var header: String {
        return ">" + version + " " + description
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