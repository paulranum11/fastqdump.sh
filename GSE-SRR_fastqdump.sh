#Download a GSM-SRR conversion table

if [ ! -f SRA_Accessions.tab]; then
wget ftp://ftp.ncbi.nlm.nih.gov/sra/reports/Metadata/SRA_Accessions.tab
fi

# Create an array containing all of the GSM accession numbers you are interested in
declare -a arr=("GSM2944170"
"GSM2944171"
"GSM2944172"
"GSM2944173"
"GSM2944174"
"GSM2944175"
"GSM2944176"
"GSM2944177"
"GSM2944178"
"GSM2944179"
"GSM2944180"
"GSM2944181"
"GSM2944182"
"GSM2944183")

# if we have not already made the trimmed SRA file then make it
if [ ! -f SRA_Accessions_Trimmed.tab ]; then

    #use a for loop to iterate through every GSM in the array created above
    for GSM in "${arr[@]}"
    do

        #Use grep to extract out the entries linked to your experiment of interest
        grep ^SRR SRA_Accessions.tab | grep $GSM >> SRA_Accessions_Trimmed.tab
    done
fi

#Get the SRR accession numbers for each file of interest and 
while IFS=$'\t' read -r -a myArray
do  
    fastq-dump -I --split-files --gzip "${myArray[0]}"
done < SRA_Accessions_Trimmed.tab
