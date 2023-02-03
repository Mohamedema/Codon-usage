## This code is used to estimate the MILC using the genetic code for the bacteria, 
## Then calculate the mean and median of the MILC for all the genes of each sample. 
## Finally, merge all the common genes across all models, then write a CSV of the result.


## Load the packages

library(coRdon)
library(Biostrings)
library(stringr)
library(dplyr)


## read the fasta formate

seq_name <- readSet(
  file= "X.fasta"
)

# calculate the MILC

seq_name <- codonTable(seq_name)

milc <- MILC(seq_name, id_or_name2 = "11")
milc <- data.frame(milc)
milc$seq.name <-  as.character(seq_name@ID)

names <- data.frame(str_split_fixed(milc$seq.name, fixed("|") , 2))
milc$seq.name <-  names$X1

## Calculate the mean and the median

milc <- milc %>% group_by(seq.name) %>%  summarise(milc.mean = mean(self),
                                                   milc.median = median(self))

## Merging and writing a CSV file

colnames(milc)[2:3] <- c("milc.mean.blast85.stage1", 
                         "milc.median.blast85.stage1")

df.all <- merge(df.all, milc, by = "seq.name")

write.csv(df.all , "milc.mean.median.common.csv", row.names = F)
