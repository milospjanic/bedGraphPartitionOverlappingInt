#!/bin/bash

for chr in {1..22}

do

export chr

(cut -f2 out.bedGraph.hg19.sort; cut -f3 out.bedGraph.hg19.sort) | sort -nu | perl -ne 'BEGIN{$i=0} chomp; push @F, $_; if($i++){print "chr$ENV{chr}\t$F[$i-2]\t$F[$i-1]\n"}' > b.bed

bedtools intersect -a out.bedGraph.hg19.sort -b b.bed | sort -k2n -k3n -k4nr | perl -lane 'print unless $h{$F[0,1,2]}++' > out.bedGraph.hg19.sort.$chr

done

cat out.bedGraph.hg19.sort.chr* >out.bedGraph.hg19.sort.merge

sort -k1,1 -k2,2n out.bedGraph.hg19.sort.merge > out.bedGraph.hg19.sort.merge.sort