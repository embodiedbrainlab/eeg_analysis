library(tidyverse)

setwd("D:/dance_brain_study/coherence_stats_analysis")

coherence <- read_csv("final_coherence_array_w_headings.csv")

## Adding Condition variable
# Used participant randomization spreadsheet to indicate which participants were
# in the dance group, and which participants were in the control group.
coherence_w_conditions <- coherence %>% mutate(condition = ifelse((participant_id == "danc001") | 
                                                     (participant_id == "danc002") |
                                                     (participant_id == "danc006") |
                                                     (participant_id == "danc009") |
                                                     (participant_id == "danc012") |
                                                     (participant_id == "danc013") |
                                                     (participant_id == "danc015"),
                                                      "dance","control"))
write_csv(coherence_w_conditions,"coherence_conditions.csv")