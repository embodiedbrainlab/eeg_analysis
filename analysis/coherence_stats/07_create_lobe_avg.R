library(tidyverse)
library(ggplot2)

#setwd(...)
coherence <- read_csv("coherence_conditions.csv")

# Refactor Categorical Variables ---------------------------------------

coherence <- coherence %>%
  mutate(test_session = fct_relevel(test_session, c("pretest", "posttest")),
         condition = fct_relevel(condition, c("dance","control")),
         freq_band = fct_relevel(freq_band, c("delta","theta","alpha","beta","lowgamma","higamma")),
         activity = fct_relevel(activity, c("baseline","eyegaze","convo","follow","lead","improv")),
         channel = fct_relevel(channel, c("Fp1","Fz","F3","F7","FT9","FC5","FC1",
                                          "C3","T7","TP9","CP5","CP1","Pz","P3",
                                          "P7","O1","Oz","O2","P4","P8","TP10",
                                          "CP6","CP2","Cz","C4","T8","FT10","FC6",
                                          "FC2","F4","F8","Fp2")))

## Remove SEM Column
coherence_wide <- coherence %>%
  select(-sem) %>%
  pivot_wider(names_from = channel, values_from = avg_coh)

lobe_avg <- coherence_wide %>%
  rowwise() %>%
  mutate(frontal = mean(c(Fp1,Fp2,F7,F8,F3,F4,Fz,FC5,FC1,FC2,FC6)),
         parietal = mean(c(P7,P3,Pz,P4,P8,CP1,CP2,CP5,CP6,C3,Cz,C4)),
         temporal = mean(c(FT9,FT10,T7,T8,TP9,TP10)),
         occipital = mean(c(O1,O2,Oz))) %>%
  select(!(Fp1:Fp2)) #removes channel columns for cleaner data array

## Pivot Long to be able to plot lobes separately
lobe_avg_long <- lobe_avg %>%
  pivot_longer(!c(participant_id,test_session,activity,freq_band,condition),
               names_to = "lobe",
               values_to = "avg_coh")

write_csv(lobe_avg_long, "lobe_averages.csv")