#Data Visualization of Metagenomic Assembled Sequences from Las Salinas of Cabo Rojo, P.R.
#Semester Project - Introduction to R
#Roseliz Ríos Alemar
#BIOL6694-096
#Dr. Pablo Gutierrez Fonseca

#Packages Needed
install.packages("tidyverse")
install.packages("pheatmap")

#Libraried
library(tidyverse)
library(pheatmap)

#Datasets
CheckM2_Quality_Report <- read_tsv("quality_report_COPY.tsv")
View(CheckM2_Quality_Report)

BAT_Taxonomic_Classification <- read_tsv(
  "out.BAT.bin.classification.txt",
  comment = "#",
  col_names = FALSE,
  show_col_types = FALSE
)

colnames(BAT_Taxonomic_Classification) <-
  c("BinFile", "Classification", "Reason", "Lineage", "LineageScores")

BAT_Taxonomy <- BAT_Taxonomic_Classification %>%
  mutate(
    BinID = str_remove(BinFile, "\\.fna$"),
    DomainScore = as.numeric(str_split_fixed(LineageScores, ";", 3)[,2])
  ) %>%
  group_by(BinID) %>%
  slice_max(DomainScore, n = 1, with_ties = FALSE) %>%
  ungroup()

View(BAT_Taxonomy)

any(duplicated(BAT_Taxonomy$BinID))
#No Duplicates Found

#Joined Datasets (CheckM2 + BAT results)
CheckM2_Quality_Report <- CheckM2_Quality_Report %>%
  rename(BinID = Name)

bins_all <- CheckM2_Quality_Report %>%
  left_join(BAT_Taxonomy, by = "BinID")

View(bins_all)

#Dataset Info/Quality

#Total bins
nrow(bins_all)

#Total bins with taxonomy classification
sum(!is.na(bins_all$Lineage))
  #Total = 256

#Total bins with CheckM2 completeness info
sum(!is.na(bins_all$Completeness))
  #Total = 256

#Dataset quality overview
nrow(bins_hq_all)
View(bins_hq_all)

#Salinibacter bins
sal_all <- bins_all %>%
  filter(!is.na(Lineage)) %>%
  filter(str_detect(Lineage, "g__Salinibacter"))

nrow(sal_all)
View(sal_all)

#Salinibacter high vs low completeness
sal_high <- sal_all %>% filter(Completeness >= 30)
sal_low  <- sal_all %>% filter(Completeness < 30)

nrow(sal_high)
nrow(sal_low)

#Completeness vs Contamination (all bins)
bins_flagged <- bins_all %>%
  mutate(
    Group = case_when(
      BinID %in% sal_high$BinID ~ "Salinibacter (>=30%)",
      BinID %in% sal_low$BinID  ~ "Salinibacter (<30%)",
      TRUE ~ "Other bins"
    )
  )

ggplot() +
  geom_point(
    data = subset(bins_flagged, Group == "Other bins"),
    aes(Completeness, Contamination),
    shape = 21,              
    fill = "#A00050",
    color = "black",
    alpha = 0.15,
    size = 2,
    stroke = 0.3
  ) +
  geom_point(
    data = subset(bins_flagged, Group != "Other bins"),
    aes(Completeness, Contamination, fill = Group),
    shape = 21,              
    color = "black",
    alpha = 0.95,
    size = 3.4,
    stroke = 0.6
  ) +
  scale_fill_manual(values = c(
    "Salinibacter (<30%)" = "skyblue",
    "Salinibacter (>=30%)" = "mediumpurple"
  )) +
  coord_cartesian(xlim = c(0, 40), ylim = c(0, 5)) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0,
                              face = "bold",
                              color = "pink4",
                              size = 16)
  ) +
  labs(
    title = "Metagenome Assembled Genome (MAG) Quality",
    x = "Completeness (%)",
    y = "Contamination (%)",
    fill = "Salinibacter Completeness"
  )

#Save as png
ggsave(
  filename = "MAG_Quality.png",
  width = 7,
  height = 5,
  dpi = 300
)

# Taxonomy Classification Graphs
#1 Domain + Phylum
tax_all <- bins_all %>%
  filter(!is.na(Lineage)) %>%
  mutate(
    Domain = str_extract(Lineage, "d__[^;]+") %>% str_remove("^d__"),
    Phylum = str_extract(Lineage, "p__[^;]+") %>% str_remove("^p__")
  ) %>%
  filter(!is.na(Domain), !is.na(Phylum))

phylum_by_domain <- tax_all %>%
  count(Domain, Phylum, name = "n") %>%
  arrange(Domain, desc(n)) %>%
  mutate(Phylum = factor(Phylum, levels = rev(unique(Phylum))))

phylum_plot <- ggplot(phylum_by_domain, aes(x = Phylum, y = n, fill = Domain)) +
  geom_col(color = "black") +
  scale_fill_manual(values = c(
    "Bacteria" = "#D47FA6",
    "Archaea"  = "#A00050"
  )) +
  coord_flip() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
  labs(
    title = "Phylum-level composition of all MAGs",
    x = "Phylum",
    y = "Number of bins",
    fill = "Domain"
  )

ggsave(
  filename = "Phylum_Composition.png",
  plot = phylum_plot,
  width = 7,
  height = 5,
  dpi = 300
)

#2 Genus + Phylum
tax_all <- bins_all %>%
  filter(!is.na(Lineage)) %>%
  mutate(
    Domain = str_extract(Lineage, "d__[^;]+") %>% str_remove("^d__"),
    Genus  = str_extract(Lineage, "g__[^;]+") %>% str_remove("^g__")
  ) %>%
  filter(!is.na(Domain), !is.na(Genus))

genus_by_domain <- tax_all %>%
  count(Domain, Genus, name = "n") %>%
  arrange(Domain, desc(n)) %>%
  mutate(Genus = factor(Genus, levels = rev(unique(Genus))))

ggplot(genus_by_domain, aes(x = Genus, y = n, fill = Domain)) +
  geom_col(color = "black") +
  scale_fill_manual(values = c(
    "Bacteria" = "#D47FA6",
    "Archaea"  = "#A00050"
  )) +
  coord_flip() +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  labs(
    title = "Genus-level composition of all MAGs",
    x = "Genus",
    y = "Number of bins",
    fill = "Domain"
  )

genus_plot <- ggplot(genus_by_domain, aes(x = Genus, y = n, fill = Domain)) +
  geom_col(color = "black") +
  scale_fill_manual(values = c(
    "Bacteria" = "#D47FA6",
    "Archaea"  = "#A00050"
  )) +
  coord_flip() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
  labs(
    title = "Genus-level composition of all MAGs",
    x = "Genus",
    y = "Number of bins",
    fill = "Domain"
  )

ggsave(
  filename = "Genus_Composition.png",
  plot = genus_plot,
  width = 7,
  height = 6,
  dpi = 300
)

names(sal_all)

#Salinibacter Heatmap
#Checking for NAs in Salinibacter features
sal_all %>%
  select(any_of(c("BinID","Completeness","Contamination","Coding_Density","Contig_N50"))) %>%
  summarise(across(everything(), ~sum(!is.na(.))))

#Heatmap :)
features_to_use <- c("Completeness", "Contamination", "Coding_Density", "Contig_N50")

heat_df <- sal_all %>%
  select(BinID, all_of(features_to_use)) %>%
  drop_na()

mat <- heat_df %>%
  column_to_rownames("BinID") %>%
  as.matrix()

pheatmap(
  mat,
  scale = "column",
  main = "Salinibacter MAGs Quality Features"
)

pheatmap(
  mat,
  scale = "column",
  main = "Salinibacter MAGs quality features",
  filename = "Salinibacter_Heatmap.png",
  width = 7,
  height = 5
)

#End of Script // 12/16/2025 // Roseliz Ríos Alemar