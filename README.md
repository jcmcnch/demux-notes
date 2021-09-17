# Notes on demultiplexing 515Y reads with cutadapt (last updated 2021-09-17)

## Preamble

This repository documents how I do second-round demultiplexing (i.e. for the inline barcodes contained in the 515Y reads) for the Fuhrman lab standard tag protocol after using something like bcl2fastq or illumina-utils to split out the reverse indices.

### Steps

1. First, clone and enter the repo:

```
git clone https://github.com/jcmcnch/demux-notes.git
cd demux-notes
```

2. Now, create a `cutadapt-env` based on the env subfolder in `demux-notes`. For example:

```
conda env create --name cutadapt-env --file env/cutadapt-env.yaml
#could also use mamba
#mamba env create --name cutadapt-env --file env/cutadapt-env.yaml
```

3. Next, construct a tab-separated (tsv) spreadsheet (I use excel/libreoffice to edit more easily and then export to tsv) that contains in the first column your sample ID (i.e. what you want your output files to be named) and the # of the barcode in the second column. For the third column, put the name of your sample file (i.e. your partially demultiplexed fastq, but minus the `.fastq` suffix) wherever you switch reverse indices. An example can be found [here](https://github.com/jcmcnch/demux-notes/blob/master/generate-fastas-for-cutadapt/input/bioGEOTRACES-sample-input.tsv).

4. Go into the subdirectory `generate-fastas-for-cutadapt`.
```
cd generate-fastas-for-cutadapt
```

5. Copy your tsv file into the input folder, overwriting the input file and erase the example output files.

```
cp myfile input/bioGEOTRACES-sample-input.tsv
rm output/*
```

6. Run the script (uses basic python functions such as `csv` and `sys` so should work by default on most pythons).

```
chmod u+x run.sh
./run.sh
```

7. Now copy the output folder to a directory below the location of your demultiplexed data, naming it `00-adapter-fastas`. Then enter that directory. For example let's say your partially demultiplexed data (i.e. a bunch of different fastqs, each corresponding to a different index) is in `/home/inigo/mydemuxdata/00-raw`. Then you would do the following:

```
cp -r output /home/inigo/mydemuxdata/00-adapter-fastas
cd /home/inigo/mydemuxdata/
```

8. Now you should be ready to run the script contained in the demux-notes repo, but you may have to edit the input/output folders to suit your needs. But assuming your raw data is in a folder called `00-raw` and you don't mind your demultiplexed data going into a folder called `demultiplexed` you can just run it as follows:

```
cp <full path to your demux-notes dowloaded repo>/00-run-cutadapt-recursively.sh
chmod u+x 00-run-cutadapt-recursively.sh
./00-run-cutadapt-recursively.sh
```

If it's giving you errors, try appending `echo` to the beginning of line 11. That will print out the commands `cutadapt` will execute and you can look for typos or missing filenames etc.
