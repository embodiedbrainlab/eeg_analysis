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
### We do this so that we can match pretest and posttest coherence values
coh_no_sem <- coherence %>%
  select(-sem)

# Channels become columns
coherence_wide <- coh_no_sem %>%
  pivot_wider(names_from = channel, values_from = avg_coh)

#Calculate Average Across Channels
coh_whole_brain_avg <- coherence_wide %>%
  rowwise() %>%
  mutate(whole_brain_avg = mean(c_across(Fp1:Fp2)))

#Remove Columns of Channels
whole_brain_avg_clean <- coh_whole_brain_avg %>%
  select(!(Fp1:Fp2))

#Subtract for whole brain change score
whole_brain_change <- whole_brain_avg_clean %>%
  pivot_wider(names_from = test_session, values_from = whole_brain_avg)

#Change Score
whole_brain_change <- whole_brain_change %>%
  mutate(change_score = posttest - pretest)

## Cleaning up final array for SPSS
whole_brain_change_final <- whole_brain_change %>%
  select(!c(posttest,pretest,condition)) %>%
  pivot_wider(names_from = activity, values_from = change_score)

write_csv(whole_brain_change_final, "whole_brain_change_scores_for_SPSS.csv")
