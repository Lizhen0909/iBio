# A Bioinformatics App on iPhone 

## Introduction
The App demostrates a few of basic functions and algorthms for Bioinformatics.
* Manage Nucleotides sequences. User may download them from GenBank by accession numbers
* Translate DNA sequences to RNA/protein sequences
* k-mer generating/counting/charting
* Local/global alignment for protein strings

## Development Environment
* Xcode 6.3 / Swift 1.2
* iOS 8 

## Usage

### Data management

An initial table view shows a list of DNA sequences. A few samples are provided for the first-time user. Each row shows the *accession number*, *version* and *description* of a sequence. Further information can be found [here](http://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html).

<img src="screenshot/screen_dna_seq.png" alt="show DNA sequence" width="350px" >

#### Delete
The **Edit** button on the up-right is used to delete records. The deleting is persistent. 

<img src="screenshot/screen_dna_seq_delete.png" alt="delete DNA sequence" width="350px" >

#### Add a new record
The **"+"** button on the up-left creates a new record. The *details* view is shown for editing. When finishing editing, use the **save** button on the up-right to apply the change. The changes are persistent on the device.

<img src="screenshot/screen_dna_seq_new.png" alt="add DNA sequence" width="350px" >

#### Edit
User may edit a existing record by select the row, it takes user to the same *detail* view as the **"+"** button.

#### Download 
Creating a record mannually is tedious, the **Download** button right next to **"+"** let user to download a record from GenBank. Just input the **accession number** and click **Download**. The function is implemented using NCBI [Entrez Programming Utilities](http://www.ncbi.nlm.nih.gov/books/NBK25501/) webservices. 

<img src="screenshot/screen_dna_seq_download.png" alt="download DNA sequence" width="350px" >

### Translating DNA to RNA/Protein
The **RNA** and **Protein** buttons on the buttom toolbar of *Details* view let user to translating the DNA sequences to RNA and Proten. 

<img src="screenshot/screen_dna_seq_protein.png" alt="Protein" width="350px" >

### k-mer functions
The **k-mer** button on the toolbar takes user to a tabbar view for k-mer related function. 

#### Settings
The setting tab lets user change the k-mer size. The default size is 4. When click *Calculate*, the underlying k-mer data is re-generated. 

<img src="screenshot/screen_kmer_setting.png" alt="kmer settings" width="350px" >

#### k-mer Freq
The **k-mer Freq** tab shows a table of ordered frequencies.

<img src="screenshot/screen_kmer_freq.png" alt="kmer freq" width="350px" >

#### Count Freq
The **Profile** tab shows the count frequencies.

<img src="screenshot/screen_kmer_count_freq.png" alt="count freq" width="350px" >

#### Chart
Finally the **Chart** tab shows the histogram chart for the count frequencies.

<img src="screenshot/screen_kmer_chart.png" alt="count chart" width="350px" >

### Alignment

#### Settings
<img src="screenshot/screen_align_setting.png" alt="alignment settings" width="350px" >

The **Align** button shows the alignment setting view. User needs to choose another sequence to align with. When clicking **Select** button, a picker view shown lets user to make the selection. 

<img src="screenshot/screen_align_select.png" alt="alignment choose" width="350px" >

User may also:
- choose a score matrix between **BLOSUM62** and **PAM250**
- choose **Global** or **Local** alignment
- change the gap penalty. Note that the penalty can not be negative.

#### Show the result
Finishing making all the choices, **Go** button shows the alignment result in a table view. The aligned sequences are divided into short lines to make it easy to read.

<img src="screenshot/screen_align_score.png" alt="alignment score" width="350px" >

## Project Reference
The App applies [ios-charts](https://github.com/danielgindi/ios-charts) to draw histogram chart for k-mer profiles.

The App uses NCBI [Entrez Programming Utilities](http://www.ncbi.nlm.nih.gov/books/NBK25501/) webservices to download data from GenBank

## Reference
1. Bioinformatics: [https://en.wikipedia.org/wiki/Bioinformatics](https://en.wikipedia.org/wiki/Bioinformatics)
2. GenBank: [http://www.ncbi.nlm.nih.gov/genbank/](http://www.ncbi.nlm.nih.gov/genbank/)
3. FASTA format: [https://en.wikipedia.org/wiki/FASTA_format](https://en.wikipedia.org/wiki/FASTA_format)
4. K-mer: [https://en.wikipedia.org/wiki/K-mer](https://en.wikipedia.org/wiki/K-mer)
5. Sequence alignment: [https://en.wikipedia.org/wiki/Sequence_alignment](https://en.wikipedia.org/wiki/K-mer)
6.  David Mark , Jack Nutting , Kim Topley , Fredrik Olsson , Jeff LaMarche. *Beginning iPhone Development with Swift: Exploring the iOS SDK(2014)*. ISBN13: 978-1-484204-10-8


