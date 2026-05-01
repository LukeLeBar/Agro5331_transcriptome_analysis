#!/bin/bash
#SBATCH --job-name=sra_download
#SBATCH --time=24:00:00                 # Increased time since fastq-dump is a single-step process
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4              
#SBATCH --mem=16gb                     
#SBATCH --output=sra_log_%j.out
#SBATCH --error=sra_log_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lebar030@umn.edu # Put your UMN email here

module load sratoolkit/3.0.0

fastq-dump --split-files -F -Q 33 SRR20705522
fastq-dump --split-files -F -Q 33 SRR20705523
fastq-dump --split-files -F -Q 33 SRR20705524
fastq-dump --split-files -F -Q 33 SRR20705525
fastq-dump --split-files -F -Q 33 SRR20705526
fastq-dump --split-files -F -Q 33 SRR20705527
fastq-dump --split-files -F -Q 33 SRR20705528
fastq-dump --split-files -F -Q 33 SRR20705529
fastq-dump --split-files -F -Q 33 SRR20705530
fastq-dump --split-files -F -Q 33 SRR20705531
fastq-dump --split-files -F -Q 33 SRR20705532
fastq-dump --split-files -F -Q 33 SRR20705533
fastq-dump --split-files -F -Q 33 SRR20705534
fastq-dump --split-files -F -Q 33 SRR20705535
fastq-dump --split-files -F -Q 33 SRR20705536
fastq-dump --split-files -F -Q 33 SRR20705537
fastq-dump --split-files -F -Q 33 SRR20705538
fastq-dump --split-files -F -Q 33 SRR20705539
fastq-dump --split-files -F -Q 33 SRR20705540
fastq-dump --split-files -F -Q 33 SRR20705541
fastq-dump --split-files -F -Q 33 SRR20705542
fastq-dump --split-files -F -Q 33 SRR20705543
fastq-dump --split-files -F -Q 33 SRR20705544
fastq-dump --split-files -F -Q 33 SRR20705545
fastq-dump --split-files -F -Q 33 SRR20705546
fastq-dump --split-files -F -Q 33 SRR20705547
fastq-dump --split-files -F -Q 33 SRR20705548
fastq-dump --split-files -F -Q 33 SRR20705549
fastq-dump --split-files -F -Q 33 SRR20705550
fastq-dump --split-files -F -Q 33 SRR20705551
fastq-dump --split-files -F -Q 33 SRR20705552
fastq-dump --split-files -F -Q 33 SRR20705553
fastq-dump --split-files -F -Q 33 SRR20705554
fastq-dump --split-files -F -Q 33 SRR20705555
fastq-dump --split-files -F -Q 33 SRR20705556
fastq-dump --split-files -F -Q 33 SRR20705557
fastq-dump --split-files -F -Q 33 SRR20705558
fastq-dump --split-files -F -Q 33 SRR20705559
fastq-dump --split-files -F -Q 33 SRR20705560
fastq-dump --split-files -F -Q 33 SRR20705561
fastq-dump --split-files -F -Q 33 SRR20705562
fastq-dump --split-files -F -Q 33 SRR20705563
fastq-dump --split-files -F -Q 33 SRR20705564
fastq-dump --split-files -F -Q 33 SRR20705565
fastq-dump --split-files -F -Q 33 SRR20705566
fastq-dump --split-files -F -Q 33 SRR20705567
fastq-dump --split-files -F -Q 33 SRR20705568
fastq-dump --split-files -F -Q 33 SRR20705569
fastq-dump --split-files -F -Q 33 SRR20705570
fastq-dump --split-files -F -Q 33 SRR20705571
fastq-dump --split-files -F -Q 33 SRR20705572
fastq-dump --split-files -F -Q 33 SRR20705573
fastq-dump --split-files -F -Q 33 SRR20705574
fastq-dump --split-files -F -Q 33 SRR20705575
fastq-dump --split-files -F -Q 33 SRR20705576
fastq-dump --split-files -F -Q 33 SRR20705577
fastq-dump --split-files -F -Q 33 SRR20705578
fastq-dump --split-files -F -Q 33 SRR20705579
