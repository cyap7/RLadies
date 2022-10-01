#==============================================================================
#
# Data cleaning: Luo et al. base-resolution single-cell methylation profiles
#
#==============================================================================

#==============================================================================
# Directories
#==============================================================================

data=~/path/to/data/dir
scripts=~/path/to/script/dir
out=~/path/to/out/dir

#==============================================================================
# Download pseudobulk single-cell methylation data from Luo et al. 2022
#==============================================================================

# List of the following files waved within ${data}
# allc_Exc_L1-3_CUX2.tsv.gz
# allc_Exc_L2-4_RORB.tsv.gz
# allc_Exc_L4_PLCH1.tsv.gz
# allc_Exc_L4-5_FOXP2.tsv.gz
# allc_Exc_L4-5_TOX.tsv.gz
# allc_Exc_L4-6_LRRK1.tsv.gz
# allc_Exc_L5-6_PDZRN4.tsv.gz
# allc_Exc_L6_TLE4.tsv.gz
# allc_Exc_L6_TSHZ2.tsv.gz
# allc_Inh_CGE_LAMP5.tsv.gz
# allc_Inh_CGE_NDNF.tsv.gz
# allc_Inh_CGE_VIP.tsv.gz
# allc_Inh_CGE-MGE_CHST9.tsv.gz
# allc_Inh_MGE_B3GAT2.tsv.gz
# allc_Inh_MGE_CALB1.tsv.gz
# allc_Inh_MGE_PVALB.tsv.gz
# allc_Inh_MGE_UNC5B.tsv.gz
# allc_NonN_Astro_FGF3R.tsv.gz
# allc_NonN_Endo.tsv.gz
# allc_NonN_Micro.tsv.gz
# allc_NonN_Oligo_MBP.tsv.gz
# allc_NonN_OPC.tsv.gz
# allc_hs_fc_UMB_412.tsv.gz
# allc_Outlier.tsv.gz

#==============================================================================
# extract_CGN.sh: Extract CpGs (CG*) (+ optional coverage threhsold)
#==============================================================================

# This generates a file with the file names
ls ${data}/allc* | cut -f1 -d '.' > ${data}/filen.tmp

cd ${data}

# extract_CGN.sh is a wrapper for:
# zcat ${filen}.tsv.gz | grep CG[A-Z] | awk -v x="$thresh" '$6 >= x' > ${filen}_CGN_c${thresh}.tsv

while read p; do
qsub -v filen="$p",\
thresh=0 \
${scripts}/extract_CGN.sh
done <${data}/filen.tmp

#==============================================================================
# convert_cgn_gr.sh: wrapper to convert to GenomicRanges format
#==============================================================================

ls ${data}/allc* | cut -f11 -d '/' | grep .gz | cut -f1 -d '.' | sed 's/allc_//g' > ${data}/filen_all

while read p; do
echo "$p"
qsub -v scripts=${scripts},\
cgn_dir=${data}/allc_${p}_CGN_c0.tsv,\
filen=allc_${p}_CGN_c0_aut.rds,\
out_dir=${out} \
${scripts}/convert_cgn_gr.sh
done <${data}/filen_all
