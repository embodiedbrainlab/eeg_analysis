library(tidyverse)
library(ggplot2)

setwd("D:/dance_brain_study/coherence_stats_analysis")
coherence <- read_csv("coherence_conditions.csv")

# Refactor Categorical Variables ---------------------------------------
coherence <- coherence %>%
  mutate(test_session = fct_relevel(test_session, c("pretest", "posttest")),
         condition = fct_relevel(condition, c("dance","control")),
         freq_band = fct_relevel(freq_band, c("delta","theta","alpha","beta","lowgamma","higamma")),
         channel = fct_relevel(channel, c("Fp1","Fz","F3","F7","FT9","FC5","FC1",
                                          "C3","T7","TP9","CP5","CP1","Pz","P3",
                                          "P7","O1","Oz","O2","P4","P8","TP10",
                                          "CP6","CP2","Cz","C4","T8","FT10","FC6",
                                          "FC2","F4","F8","Fp2")))



# Overall Avgs - Including All Activities ---------------------------------

## Dance - Pre-test
dance_pretest <- filter(coherence,test_session == "pretest" & condition == "dance")

dance_pretest_totalavg <- dance_pretest %>%
  group_by(channel,freq_band) %>%
  summarize(tot_avg_coh = mean(avg_coh)) %>%
  pivot_wider(names_from = freq_band, values_from = tot_avg_coh)

write.csv(dance_pretest_totalavg, "topoplot/topoplot_data/dance_pretest_avgs.csv", row.names = FALSE)

## Dance - Post-Test

dance_posttest <- filter(coherence,test_session == "posttest" & condition == "dance")

dance_posttest_totalavg <- dance_posttest %>%
  group_by(channel,freq_band) %>%
  summarize(tot_avg_coh = mean(avg_coh)) %>%
  pivot_wider(names_from = freq_band, values_from = tot_avg_coh)

write.csv(dance_posttest_totalavg, "topoplot/topoplot_data/dance_posttest_avgs.csv", row.names = FALSE)

### Control

## Posttest