//
//  BioAlgorithm.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/19/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import Foundation


func dna_to_rna(seq: String)->String{
    var rna=""
    for char in seq {
        if char == "T" {
            rna.append(Character("U"))
        } else {
            rna.append(char)
        }
    }
    return rna
}

func dna_to_protein(seq: String)->String{
    let rna=dna_to_rna(seq)
    let mapping = ["GUC": "V", "ACC": "T", "GUA": "V", "GUG": "V", "ACU": "T", "AAC": "N", "CCU": "P", "UAU": "Y", "UAG": "Stop", "AGC": "S", "ACA": "T", "CAU": "H", "AAU": "N", "GUU": "V", "CAC": "H", "ACG": "T", "AGU": "S", "CCA": "P", "CCG": "P", "CCC": "P", "GGU": "G", "UCU": "S", "AUG": "M", "UGC": "C", "CAG": "Q", "GAU": "D", "UGG": "W", "CGG": "R", "UCG": "S", "AGG": "R", "GGG": "G", "UCC": "S", "UCA": "S", "UAA": "Stop", "GGA": "G", "UAC": "Y", "GAC": "D", "UGU": "C", "AUA": "I", "GCA": "A", "AUC": "I", "CUU": "L", "GGC": "G", "GCG": "A", "CUG": "L", "GAG": "E", "CUC": "L", "AGA": "R", "CUA": "L", "GCC": "A", "AAA": "K", "AUU": "I", "AAG": "K", "CAA": "Q", "UUU": "F", "CGU": "R", "CGC": "R", "CGA": "R", "GAA": "E", "GCU": "A", "UUG": "L", "UUA": "L", "UGA": "Stop", "UUC": "F"]
    let characters = Array(rna)
    var i=0
    var triplechar=""
    var protein=""
    while i < count(characters) {
        triplechar.append(characters[i])
        if i%3 == 2 {
            if mapping[triplechar] == "Stop" {
                //return protein
            } else {
                protein = protein + mapping[triplechar]!
            }
            triplechar=""
        }
        i++
    }
    return protein
}


func kmer_generate(kmersize: Int, seqString:String)->[String] {
    let seq = seqString as NSString
    var i=0
    var kmer=""
    var kmerList:[String]=[]
    for i in 0..<(count(seqString)-kmersize+1) {
        kmerList.append(seq.substringWithRange(NSRange(location: i, length: kmersize)))
    }
    return kmerList
}


func kmer_reverse_complement(kmer:String)->String {
    let mapping:[Character:Character] = ["A":"T", "T":"A", "C":"G", "G":"C"]
    var compKmer=""
    for char in reverse(kmer) {
        compKmer.append(mapping[char]!)
    }
    return compKmer
}

func kmer_less_complement(kmer:String)->String {
    let revComp=kmer_reverse_complement(kmer)
    if kmer>revComp {
        return revComp
    } else {
        return kmer
    }
}

func kmer_freq(kmers:[String])->[String:Float]{
    var freqMap = [String:Float]()
    let length=Float(kmers.count)
    for kmer in kmers {
        let lessKmer=kmer_less_complement(kmer)
        if let val=freqMap[lessKmer] {
            freqMap[lessKmer] = freqMap[lessKmer]! + 1.0/length
        } else {
            freqMap[lessKmer] = 1.0/length
        }
    }
    return freqMap
    
}