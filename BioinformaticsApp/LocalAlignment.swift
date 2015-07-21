//
//  LocalAlignment.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import Foundation


public class LocalAlignment {
    var s1:String!
    var s2:String!
    var scorefun: ((Character,Character)->Int)!
    var gap:Int!
    
    
    public init(s1:String, s2:String, scorefun: ((Character,Character)->Int),gap:Int){
        self.s1=s1
        self.s2=s2
        self.scorefun=scorefun
        self.gap=gap
    }
    
    func zero(M:Int,N:Int)->[[Int]] {
        var matrix:[[Int]]=[]
        for i in 0..<M {
            var row=[Int]()
            for j in 0..<N {
                row.append(0)
            }
            matrix.append(row)
        }
        return matrix
    }
    
    public func eval()->(Int, String,String){
        let charArray1=Array(s1)
        let charArray2=Array(s2)
        let M=charArray1.count+1
        let N=charArray2.count+1
        var matrix = zero(M,N: N)
        var path=zero(M,N: N)  //0 diag, 2: row, 1 column,3 jump
        for i in 1..<M {
            matrix[i][0]=0
            path[i][0]=3
        }
        for i in 1..<N {
            matrix[0][i]=0
            path[0][i]=3
        }
        
        for i in 1..<M {
            for j in 1..<N {
                let score1=matrix[i-1][j]+self.gap
                let score2=matrix[i][j-1]+self.gap
                let score3=matrix[i-1][j-1]+self.scorefun(charArray1[i-1],charArray2[j-1])
                let score4=0
                let maxscore=maxElement([score1,score2,score3,score4])
                matrix[i][j]=maxscore
                if maxscore==score1 {
                    path[i][j]=1
                } else if maxscore==score2 {
                    path[i][j]=2
                } else if maxscore==score3 {
                    path[i][j]=0
                } else {
                    path[i][j]=3
                }
            }
        }
        
        let (maxscore, align1,align2) = findAlignment(charArray1,charArray2: charArray2,matrix: matrix,path: path)
        return (maxscore,align1,align2)
        
    }
    
    func findMaxScore(matrix: [[Int]], path: [[Int]]) -> (Int,Int,Int) {
        let M=path.count
        let N=path[0].count
        var maxscore:Int=Int(Int32.min)
        var (maxi,maxj)=(-1,-1)
        for i in 0..<M {
            for j in 0..<N {
                if matrix[i][j]>maxscore {
                    maxscore=matrix[i][j]
                    maxi=i
                    maxj=j
                }
            }
        }
        return (maxi,maxj,maxscore)
    }
    
    func findAlignment(charArray1:[Character],charArray2:[Character],matrix:[[Int]],path:[[Int]])->(Int,String,String) {
        var (i,j,maxscore) = findMaxScore(matrix,path:path)
        var align1:String=""
        var align2:String=""
        while i>0 || j>0 {
            let flag=path[i][j]
            if flag==0 {
                align1.append(charArray1[i-1])
                align2.append(charArray2[j-1])
                i=i-1
                j=j-1
            } else if flag==1 {
                align1.append(charArray1[i-1])
                align2.append(Character("-"))
                i=i-1
            } else if flag==2 {
                align1.append(Character("-"))
                align2.append(charArray2[j-1])
                j=j-1
            } else if flag==3 {
                i = -1
                j = -1
            }
        }
        
        align1=String(reverse(align1))
        align2=String(reverse(align2))
        return (maxscore,align1,align2)
    }
    
}