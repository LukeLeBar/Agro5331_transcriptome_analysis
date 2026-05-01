awk -F'\t' '
NR==1 {
    for (i=2; i<=58; i++) {
        headers[i] = $i
        counts[i] = 0
    }
    next
}
{
    for (i=2; i<=58; i++) {
        if ($i != 0) counts[i]++
    }
}
END {
    for (i=2; i<=58; i++) {
        print headers[i] "\t" counts[i]
    }
}' merged_gene_counts.tsv > number_expressed_genes.txt
