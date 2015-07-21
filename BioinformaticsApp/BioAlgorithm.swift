//
//  BioAlgorithm.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/19/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import Foundation

public func BLOSUM62(char1:Character, char2:Character) -> Int {
    struct Holder {
        static var index:[Character:[Character:Int]] = ["A": ["A": 4, "C": 0, "E": -1, "D": -2, "G": 0, "F": -2, "I": -1, "H": -2, "K": -1, "M": -1, "L": -1, "N": -2, "Q": -1, "P": -1, "S": 1, "R": -1, "T": 0, "W": -3, "V": 0, "Y": -2], "C": ["A": 0, "C": 9, "E": -4, "D": -3, "G": -3, "F": -2, "I": -1, "H": -3, "K": -3, "M": -1, "L": -1, "N": -3, "Q": -3, "P": -3, "S": -1, "R": -3, "T": -1, "W": -2, "V": -1, "Y": -2], "E": ["A": -1, "C": -4, "E": 5, "D": 2, "G": -2, "F": -3, "I": -3, "H": 0, "K": 1, "M": -2, "L": -3, "N": 0, "Q": 2, "P": -1, "S": 0, "R": 0, "T": -1, "W": -3, "V": -2, "Y": -2], "D": ["A": -2, "C": -3, "E": 2, "D": 6, "G": -1, "F": -3, "I": -3, "H": -1, "K": -1, "M": -3, "L": -4, "N": 1, "Q": 0, "P": -1, "S": 0, "R": -2, "T": -1, "W": -4, "V": -3, "Y": -3], "G": ["A": 0, "C": -3, "E": -2, "D": -1, "G": 6, "F": -3, "I": -4, "H": -2, "K": -2, "M": -3, "L": -4, "N": 0, "Q": -2, "P": -2, "S": 0, "R": -2, "T": -2, "W": -2, "V": -3, "Y": -3], "F": ["A": -2, "C": -2, "E": -3, "D": -3, "G": -3, "F": 6, "I": 0, "H": -1, "K": -3, "M": 0, "L": 0, "N": -3, "Q": -3, "P": -4, "S": -2, "R": -3, "T": -2, "W": 1, "V": -1, "Y": 3], "I": ["A": -1, "C": -1, "E": -3, "D": -3, "G": -4, "F": 0, "I": 4, "H": -3, "K": -3, "M": 1, "L": 2, "N": -3, "Q": -3, "P": -3, "S": -2, "R": -3, "T": -1, "W": -3, "V": 3, "Y": -1], "H": ["A": -2, "C": -3, "E": 0, "D": -1, "G": -2, "F": -1, "I": -3, "H": 8, "K": -1, "M": -2, "L": -3, "N": 1, "Q": 0, "P": -2, "S": -1, "R": 0, "T": -2, "W": -2, "V": -3, "Y": 2], "K": ["A": -1, "C": -3, "E": 1, "D": -1, "G": -2, "F": -3, "I": -3, "H": -1, "K": 5, "M": -1, "L": -2, "N": 0, "Q": 1, "P": -1, "S": 0, "R": 2, "T": -1, "W": -3, "V": -2, "Y": -2], "M": ["A": -1, "C": -1, "E": -2, "D": -3, "G": -3, "F": 0, "I": 1, "H": -2, "K": -1, "M": 5, "L": 2, "N": -2, "Q": 0, "P": -2, "S": -1, "R": -1, "T": -1, "W": -1, "V": 1, "Y": -1], "L": ["A": -1, "C": -1, "E": -3, "D": -4, "G": -4, "F": 0, "I": 2, "H": -3, "K": -2, "M": 2, "L": 4, "N": -3, "Q": -2, "P": -3, "S": -2, "R": -2, "T": -1, "W": -2, "V": 1, "Y": -1], "N": ["A": -2, "C": -3, "E": 0, "D": 1, "G": 0, "F": -3, "I": -3, "H": 1, "K": 0, "M": -2, "L": -3, "N": 6, "Q": 0, "P": -2, "S": 1, "R": 0, "T": 0, "W": -4, "V": -3, "Y": -2], "Q": ["A": -1, "C": -3, "E": 2, "D": 0, "G": -2, "F": -3, "I": -3, "H": 0, "K": 1, "M": 0, "L": -2, "N": 0, "Q": 5, "P": -1, "S": 0, "R": 1, "T": -1, "W": -2, "V": -2, "Y": -1], "P": ["A": -1, "C": -3, "E": -1, "D": -1, "G": -2, "F": -4, "I": -3, "H": -2, "K": -1, "M": -2, "L": -3, "N": -2, "Q": -1, "P": 7, "S": -1, "R": -2, "T": -1, "W": -4, "V": -2, "Y": -3], "S": ["A": 1, "C": -1, "E": 0, "D": 0, "G": 0, "F": -2, "I": -2, "H": -1, "K": 0, "M": -1, "L": -2, "N": 1, "Q": 0, "P": -1, "S": 4, "R": -1, "T": 1, "W": -3, "V": -2, "Y": -2], "R": ["A": -1, "C": -3, "E": 0, "D": -2, "G": -2, "F": -3, "I": -3, "H": 0, "K": 2, "M": -1, "L": -2, "N": 0, "Q": 1, "P": -2, "S": -1, "R": 5, "T": -1, "W": -3, "V": -3, "Y": -2], "T": ["A": 0, "C": -1, "E": -1, "D": -1, "G": -2, "F": -2, "I": -1, "H": -2, "K": -1, "M": -1, "L": -1, "N": 0, "Q": -1, "P": -1, "S": 1, "R": -1, "T": 5, "W": -2, "V": 0, "Y": -2], "W": ["A": -3, "C": -2, "E": -3, "D": -4, "G": -2, "F": 1, "I": -3, "H": -2, "K": -3, "M": -1, "L": -2, "N": -4, "Q": -2, "P": -4, "S": -3, "R": -3, "T": -2, "W": 11, "V": -3, "Y": 2], "V": ["A": 0, "C": -1, "E": -2, "D": -3, "G": -3, "F": -1, "I": 3, "H": -3, "K": -2, "M": 1, "L": 1, "N": -3, "Q": -2, "P": -2, "S": -2, "R": -3, "T": 0, "W": -3, "V": 4, "Y": -1], "Y": ["A": -2, "C": -2, "E": -2, "D": -3, "G": -3, "F": 3, "I": -1, "H": 2, "K": -2, "M": -1, "L": -1, "N": -2, "Q": -1, "P": -3, "S": -2, "R": -2, "T": -2, "W": 2, "V": -1, "Y": 7]]
    }
    let submap:[Character:Int]=Holder.index[char1]!
    return submap[char2]!;
}

public func PAM250(char1:Character, char2:Character) -> Int {
    struct Holder {
        static var index:[Character:[Character:Int]] = ["A": ["A": 2, "C": -2, "E": 0, "D": 0, "G": 1, "F": -3, "I": -1, "H": -1, "K": -1, "M": -1, "L": -2, "N": 0, "Q": 0, "P": 1, "S": 1, "R": -2, "T": 1, "W": -6, "V": 0, "Y": -3], "C": ["A": -2, "C": 12, "E": -5, "D": -5, "G": -3, "F": -4, "I": -2, "H": -3, "K": -5, "M": -5, "L": -6, "N": -4, "Q": -5, "P": -3, "S": 0, "R": -4, "T": -2, "W": -8, "V": -2, "Y": 0], "E": ["A": 0, "C": -5, "E": 4, "D": 3, "G": 0, "F": -5, "I": -2, "H": 1, "K": 0, "M": -2, "L": -3, "N": 1, "Q": 2, "P": -1, "S": 0, "R": -1, "T": 0, "W": -7, "V": -2, "Y": -4], "D": ["A": 0, "C": -5, "E": 3, "D": 4, "G": 1, "F": -6, "I": -2, "H": 1, "K": 0, "M": -3, "L": -4, "N": 2, "Q": 2, "P": -1, "S": 0, "R": -1, "T": 0, "W": -7, "V": -2, "Y": -4], "G": ["A": 1, "C": -3, "E": 0, "D": 1, "G": 5, "F": -5, "I": -3, "H": -2, "K": -2, "M": -3, "L": -4, "N": 0, "Q": -1, "P": 0, "S": 1, "R": -3, "T": 0, "W": -7, "V": -1, "Y": -5], "F": ["A": -3, "C": -4, "E": -5, "D": -6, "G": -5, "F": 9, "I": 1, "H": -2, "K": -5, "M": 0, "L": 2, "N": -3, "Q": -5, "P": -5, "S": -3, "R": -4, "T": -3, "W": 0, "V": -1, "Y": 7], "I": ["A": -1, "C": -2, "E": -2, "D": -2, "G": -3, "F": 1, "I": 5, "H": -2, "K": -2, "M": 2, "L": 2, "N": -2, "Q": -2, "P": -2, "S": -1, "R": -2, "T": 0, "W": -5, "V": 4, "Y": -1], "H": ["A": -1, "C": -3, "E": 1, "D": 1, "G": -2, "F": -2, "I": -2, "H": 6, "K": 0, "M": -2, "L": -2, "N": 2, "Q": 3, "P": 0, "S": -1, "R": 2, "T": -1, "W": -3, "V": -2, "Y": 0], "K": ["A": -1, "C": -5, "E": 0, "D": 0, "G": -2, "F": -5, "I": -2, "H": 0, "K": 5, "M": 0, "L": -3, "N": 1, "Q": 1, "P": -1, "S": 0, "R": 3, "T": 0, "W": -3, "V": -2, "Y": -4], "M": ["A": -1, "C": -5, "E": -2, "D": -3, "G": -3, "F": 0, "I": 2, "H": -2, "K": 0, "M": 6, "L": 4, "N": -2, "Q": -1, "P": -2, "S": -2, "R": 0, "T": -1, "W": -4, "V": 2, "Y": -2], "L": ["A": -2, "C": -6, "E": -3, "D": -4, "G": -4, "F": 2, "I": 2, "H": -2, "K": -3, "M": 4, "L": 6, "N": -3, "Q": -2, "P": -3, "S": -3, "R": -3, "T": -2, "W": -2, "V": 2, "Y": -1], "N": ["A": 0, "C": -4, "E": 1, "D": 2, "G": 0, "F": -3, "I": -2, "H": 2, "K": 1, "M": -2, "L": -3, "N": 2, "Q": 1, "P": 0, "S": 1, "R": 0, "T": 0, "W": -4, "V": -2, "Y": -2], "Q": ["A": 0, "C": -5, "E": 2, "D": 2, "G": -1, "F": -5, "I": -2, "H": 3, "K": 1, "M": -1, "L": -2, "N": 1, "Q": 4, "P": 0, "S": -1, "R": 1, "T": -1, "W": -5, "V": -2, "Y": -4], "P": ["A": 1, "C": -3, "E": -1, "D": -1, "G": 0, "F": -5, "I": -2, "H": 0, "K": -1, "M": -2, "L": -3, "N": 0, "Q": 0, "P": 6, "S": 1, "R": 0, "T": 0, "W": -6, "V": -1, "Y": -5], "S": ["A": 1, "C": 0, "E": 0, "D": 0, "G": 1, "F": -3, "I": -1, "H": -1, "K": 0, "M": -2, "L": -3, "N": 1, "Q": -1, "P": 1, "S": 2, "R": 0, "T": 1, "W": -2, "V": -1, "Y": -3], "R": ["A": -2, "C": -4, "E": -1, "D": -1, "G": -3, "F": -4, "I": -2, "H": 2, "K": 3, "M": 0, "L": -3, "N": 0, "Q": 1, "P": 0, "S": 0, "R": 6, "T": -1, "W": 2, "V": -2, "Y": -4], "T": ["A": 1, "C": -2, "E": 0, "D": 0, "G": 0, "F": -3, "I": 0, "H": -1, "K": 0, "M": -1, "L": -2, "N": 0, "Q": -1, "P": 0, "S": 1, "R": -1, "T": 3, "W": -5, "V": 0, "Y": -3], "W": ["A": -6, "C": -8, "E": -7, "D": -7, "G": -7, "F": 0, "I": -5, "H": -3, "K": -3, "M": -4, "L": -2, "N": -4, "Q": -5, "P": -6, "S": -2, "R": 2, "T": -5, "W": 17, "V": -6, "Y": 0], "V": ["A": 0, "C": -2, "E": -2, "D": -2, "G": -1, "F": -1, "I": 4, "H": -2, "K": -2, "M": 2, "L": 2, "N": -2, "Q": -2, "P": -1, "S": -1, "R": -2, "T": 0, "W": -6, "V": 4, "Y": -2], "Y": ["A": -3, "C": 0, "E": -4, "D": -4, "G": -5, "F": 7, "I": -1, "H": 0, "K": -4, "M": -2, "L": -1, "N": -2, "Q": -4, "P": -5, "S": -3, "R": -4, "T": -3, "W": 0, "V": -2, "Y": 10]]
    }
    let submap:[Character:Int]=Holder.index[char1]!
    return submap[char2]!
}

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
            freqMap[lessKmer] = val + 1.0/length
        } else {
            freqMap[lessKmer] = 1.0/length
        }
    }
    return freqMap
}

func kmer_count(kmers:[String])->[String:Int]{
    var countMap = [String:Int]()
    for kmer in kmers {
        let lessKmer=kmer_less_complement(kmer)
        if let val=countMap[lessKmer] {
            countMap[lessKmer] = val + 1
        } else {
            countMap[lessKmer] = 1
        }
    }
    return countMap
}

func kmer_profile(kmers:[String])->[Int:Float]{
    let countMap=kmer_count(kmers)
    let length=Float(countMap.count)
    var profileMap = [Int:Float]()
    for (kmer,cnt) in countMap {
        if let val=profileMap[cnt] {
            profileMap[cnt] = val + 1.0/length
        } else {
            profileMap[cnt] = 1.0/length
        }
    }
    return profileMap
}


















