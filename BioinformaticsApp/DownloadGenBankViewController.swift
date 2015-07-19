//
//  DownloadGenBankViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit


extension String {
    
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Return precent escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = map(self) { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return join("&", parameterArray)
    }
    
}

class DownloadGenBankViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var accessionText: UITextField!
    
    var rootView: RootTableViewController!
    
    @IBAction func downloadPressed(sender: UIButton) {
        let accession = accessionText.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if accession == "" {
            return showError("GenBank Id cannot be empty")
        }
        let (id, errMsg) = getId(accession)
        if id == nil {
            return showError(errMsg)
        }
        println("found id \(id)")
        
        let (fasta,errMsg2) = getFasta(id as! String)
        if fasta == nil {
            return showError(errMsg2)
        }
        
        let sequence = parseDNASequence(accession, fasta as! String)
        rootView.sequences.append(sequence)
        writeToFile(dataFilePath(), rootView.sequences)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func showError(errMsg:String){
        let controller2 = UIAlertController(
            title:"Error",
            message: errMsg, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK",
            style: .Default, handler: nil)
        controller2.addAction(cancelAction)
        self.presentViewController(controller2, animated: true,
            completion: nil)

        return
    }
    
    func getFasta(id:String)->(NSString?,String) {
        let url: String = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
        let parameters = ["db":"nuccore","id":"\(id)","retmode":"text","rettype":"fasta" ]
        let parameterString = parameters.stringFromHttpParameters()
        var errMsg:String=""
        var myHTMLString:NSString!
        let urlString="\(url)?\(parameterString)"
        if let requestURL = NSURL(string:urlString) {
        println(requestURL)
        var error: NSError?
        myHTMLString = NSString(contentsOfURL: requestURL, encoding: NSUTF8StringEncoding, error: &error)
        
        if let error = error {
                errMsg=("Error : \(error)")
        }
        } else {
            errMsg=("Error: \(urlString) doesn't seem to be a valid URL")
        }
        if errMsg == "" {
            //println(myHTMLString)
            return (myHTMLString,errMsg)
            
       }
       return (nil,errMsg)
    }
    
    func parseJSON4Id(jsonString:NSString)-> (NSString?,String){
        var errMsg="Error when paring JSON for Id"
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            if let searchResult = json["esearchresult"] as? NSDictionary {
                if let count=searchResult["count"] as? NSString {
                    if count == "0" {
                        errMsg="No record found"
                    } else {
                        if let idList = searchResult["idlist"] as? NSArray {
                                return (idList[0] as? NSString, errMsg)
                        }
                    }
                }
            }
        }
        return (nil,errMsg)
    }
    func getId(accession:String)->(NSString?,String) {
        let url: String = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
        let parameters = ["db":"nuccore","term":"\(accession)[accn]","retmode":"json" ]
        let parameterString = parameters.stringFromHttpParameters()
        var errMsg:String=""
        var myHTMLString:NSString!
        let urlString="\(url)?\(parameterString)"
        if let requestURL = NSURL(string:urlString) {
            println(requestURL)
            var error: NSError?
            myHTMLString = NSString(contentsOfURL: requestURL, encoding: NSUTF8StringEncoding, error: &error)
            
            if let error = error {
                errMsg=("Error : \(error)")
            }
        } else {
            errMsg=("Error: \(urlString) doesn't seem to be a valid URL")
        }
        if errMsg == "" {
            //println(myHTMLString)
           return parseJSON4Id(myHTMLString)
            
        }
        return (nil,errMsg)
        

        /*
        var request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
    
        var response: NSURLResponse? = nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error:nil)!
        var err: NSError
        println((response as! NSHTTPURLResponse).statusCode)
        
        println(NSString(data: dataVal,encoding: NSUTF8StringEncoding))
        */
        
        
    }
    
    
    @IBAction func cancelPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
