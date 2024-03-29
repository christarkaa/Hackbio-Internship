#!/usr/bin/env bash

#Creating my working directory
mkdir CHRIS

#Creating another directory called biocomputing
mkdir biocomputing

#Moving the biocomputing directory into CHRIS
mv biocomputing CHRIS

#Changing the working directory
cd CHRIS/biocomputing

#Downloading the three files provided
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna 

wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype

wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk 

#Moving the wildtype.fna file to the CHRIS directory
mv wildtype.fna../CHRIS

#Removing the .gbk file
rm -r wildtype.gbk.1

#Confirming whether the file is a wildtype or mutant
if grep -q "tatatata" wildtype.fna; then echo "mutant"; else echo "wildtype"; fi

#Printing all the lines that show it is mutant into a new file
grep 'tatatata' wildtype.fna> mutanttype.fna

#Selecting a favourite gene
echo Androgen receptor

#Downloading the FASTA format of the gene from NCBI
wget -O AR.fasta "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=AH002624.2&rettype=fasta&retmode=text"  

#Counting the number of lines in the FASTA file (excluding the header)
grep -v "^>" AR.fasta | wc -l

#Counting the occurrences of each nucleotide base in the FASTA file
grep -o 'A' AR.fasta | wc -l  # Count occurrences of 'A'
grep -o 'G' AR.fasta | wc -l  # Count occurrences of 'G'
grep -o 'C' AR.fasta | wc -l  # Count occurrences of 'C'
grep -o 'T' AR.fasta | wc -l  # Count occurrences of 'T'

#Calculating the %GC content of the gene
awk '/^>/ {if (seq != "") {print "GC content:", (gc_count / length(seq)) * 100 "%"}; printf $0 "\t"; seq=""; gc_count=0; 
next} {seq = seq $0; gc_count += gsub(/[GCgc]/,"")} END {print "GC content:", (gc_count / length(seq)) * 100 "%"}' 
AR.fasta

#Creating a nucleotide file titled with my name
nano chris.fasta

#Counting the occurrences of each nucleotide base and storing the counts in variables
C=$(grep -o "C" AR.fasta | wc -l)
A=$(grep -o "A" AR.fasta | wc -l)
G=$(grep -o "G" AR.fasta | wc -l)
T=$(grep -o "T" AR.fasta | wc -l)

#Appending the counts to the nucleotide file
echo "G count is:$G" >> chris.fasta
echo "A count is:$A" >> chris.fasta
echo "C count is:$C" >> chris.fasta
echo "T count is:$T" >> chris.fasta

#Alternatively
C=$(grep -o "C" AR.fasta | wc -l) && A=$(grep -o "A" AR.fasta | wc -l) && G=$(grep -o "G" AR.fasta | wc -l) && T=$(grep -o "T" AR.fasta | wc -l) && echo "G count is:$G" >> chris.fasta && echo "A count is:$A" >> chris.fasta && echo "C count is:$C" >> chris.fasta && echo "T count is:$T" >> chris.fasta

#Clearing the terminal space
clear

#Printing all the commands used in this project
history
