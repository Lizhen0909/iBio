# A Bioinformatics App on iPhone
## Introduction
The App demostrates a few of basic functions and algorthms for Bioinformatics.
* Manage Nucleotides sequences. Use may download them from GenBank by accession numbers
* Translate DNA sequences to RAN/protein
* k-mer generating/couting/charting
* Local/global alignment for protein strings

## Development Environment
* Xcode 6.3 / Swift 1.2
* iOS 8 

## Usage

### Data management

A table view of the App shows the list of DNA sequences. A few samples are provided for the first time user. The table shows the *accession number*, *version* and *description* of the sequence. Further information can be found [here](http://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html).

The **Edit** button on the up right deletes recrods, which is persistent on the disk. 

The **New** button on the up left creates a new record and takes user to the edit view. When finishing editing, use the save button on the up-right to save the change.

Creating a record mannually is tedious, the **Download** button right next to *New* let user to download a record from GenBank. Just input the **accession number** and click **Download**. The function is implemented using NCBI [Entrez Programming Utilities](http://www.ncbi.nlm.nih.gov/books/NBK25501/) webservices. 

## Project Reference
The App applies [ios-charts](https://github.com/danielgindi/ios-charts) to draw histogram chart for k-mer profiles.

## Reference
1. Bioinformatics: [https://en.wikipedia.org/wiki/Bioinformatics](https://en.wikipedia.org/wiki/Bioinformatics)
2. GenBank: [http://www.ncbi.nlm.nih.gov/genbank/](http://www.ncbi.nlm.nih.gov/genbank/)
3. FASTA format: [https://en.wikipedia.org/wiki/FASTA_format](https://en.wikipedia.org/wiki/FASTA_format)
4. K-mer: [https://en.wikipedia.org/wiki/K-mer](https://en.wikipedia.org/wiki/K-mer)
5. Sequence alignment: [https://en.wikipedia.org/wiki/Sequence_alignment](https://en.wikipedia.org/wiki/K-mer)
6.  David Mark , Jack Nutting , Kim Topley , Fredrik Olsson , Jeff LaMarche. *Beginning iPhone Development with Swift: Exploring the iOS SDK(2014)*. ISBN13: 978-1-484204-10-8


