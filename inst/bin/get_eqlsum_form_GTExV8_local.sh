#!/bin/bash

# 设置参数
gene_id="$1"
input_file="$2"
outname="$3"

# 开始时间
#start_time=$(date +%s)

# 定义函数
pre_coloc() {
  gene=$1
  echo "当前基因: $gene"
  # 使用awk提取指定基因ID的行
  zcat "${input_file}" | awk -v gene_id="$gene_id" -F '\t' 'BEGIN {OFS = "\t"} NR == 1 || $7 == gene_id {print}' > "${outname}_eqtlsum_hg38_raw.txt"
  awk -v OFS='\t' 'BEGIN {print "CHR", "BP", "SNP", "effect_allele", "other_allele", "eaf", "beta", "se", "pval", "N"} NR > 1 {print $13, $14,$18 ,$16, $15, $6, $9, $10, $3, $11/2}' "${outname}_eqtlsum_hg38_raw.txt" > "${outname}_eqtlsum_hg38.txt" 
  #rm "${path}${gene}_eqtlsum_from_GTEx_Whole_Blood_hg38_raw.txt"
  
}

# 执行函数
pre_coloc "$gene_id"

# 结束时间
#end_time=$(date +%s)
#elapsed_time=$((end_time - start_time))

# 显示运行时间
#echo "程序运行时间： ${elapsed_time} 秒"

