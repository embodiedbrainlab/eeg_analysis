library(tidyverse)
library(ggplot2)

#setwd(...)
coherence <- read_csv("lobe_averages.csv")

# Refactor Categorical Variables ---------------------------------------

coherence <- coherence %>%
  mutate(test_session = fct_relevel(test_session, c("pretest", "posttest")),
         condition = fct_relevel(condition, c("dance","control")),
         freq_band = fct_relevel(freq_band, c("delta","theta","alpha","beta","lowgamma","higamma")),
         activity = fct_relevel(activity, c("baseline","eyegaze","convo","follow","lead","improv")),
         lobe = fct_relevel(lobe, c("frontal","parietal","temporal","occipital")))

# Change Score --------------------------------------------------------------

coherence_change <- coherence %>%
  pivot_wider(names_from = test_session, values_from = c(avg_coh))

coherence_change <- coherence_change %>%
  mutate(change_score = posttest- pretest)

# Summary Boxplot ---------------------------------------------------------

## All Frequency Bands
ggplot(coherence_change, aes(x = condition, y = change_score, fill = lobe)) + 
  geom_boxplot() + 
  facet_wrap(vars(freq_band), nrow = 2, ncol = 3) + 
  labs(title = "Overall Change Score of Channels",
       x = "Condition", y = "Change Score")
ggsave("summaryplot_allfreq.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

## Plotting Gamma Bands Separately
gamma_coh_testing <- filter(coherence_change,freq_band == "lowgamma" | freq_band == "higamma")
ggplot(gamma_coh_testing, aes(x = condition, y = change_score, fill = lobe)) + 
  geom_boxplot() + 
  facet_wrap(vars(freq_band),
             nrow = 2, ncol = 2) + 
  labs(title = "Overall Change Score of Channels",
       x = "Condition", y = "Change Score")
ggsave("summaryplot_gamma_only.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

# Delta Boxplots ----------------------------------------------------------

delta_change <- filter(coherence_change,freq_band == "delta") 

## Creating Boxplots for each Channel
ggplot(delta_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in Delta Band", x = "Condition", y = "Change Score")
ggsave("delta_change.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

# Theta Boxplots -------------------------------------------------------------------

theta_change <- filter(coherence_change, freq_band == "theta")

## Creating Boxplots for each Channel
ggplot(theta_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in Theta Band", x = "Condition", y = "Change Score")
ggsave("theta_change.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

# Alpha Boxplots -------------------------------------------------------------------

alpha_change <- filter(coherence_change, freq_band == "alpha")

## Creating Boxplots for each Channel
ggplot(alpha_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in Alpha Band", x = "Condition", y = "Change Score")
ggsave("alpha_change.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

# Beta Boxplots -------------------------------------------------------------------

beta_change <- filter(coherence_change, freq_band == "beta")

## Creating Boxplots for each Channel
ggplot(beta_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in Beta Band", x = "Condition", y = "Change Score")
ggsave("beta_change.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

# Low Gamma Boxplots -------------------------------------------------------------------

lowgamma_change <- filter(coherence_change, freq_band == "lowgamma")

## Creating Boxplots for each Channel
ggplot(lowgamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in Low Gamma Band", x = "Condition", y = "Change Score")
ggsave("lowgamma_change.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

### Adjusting Scales (but this keeps some outliers out of view)
ggplot(lowgamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in Low Gamma Band (ADJUSTED SCALE, SOME OUTLIERS REMOVED)", x = "Condition", y = "Change Score") + 
  ylim(-0.025,0.025)
ggsave("low_gamma_change_adjusted_scale.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

# High Gamma Boxplots -------------------------------------------------------------------

higamma_change <- filter(coherence_change, freq_band == "higamma")

## Creating Boxplots for each Channel
ggplot(higamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in High Gamma Band", x = "Condition", y = "Change Score")
ggsave("higamma_change.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))

### Adjusting Scales (but this keeps some outliers out of view)
ggplot(higamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~lobe) + 
  labs(title = "Change Score in High Gamma Band (ADJUSTED SCALE, SOME OUTLIERS REMOVED)", x = "Condition", y = "Change Score") + 
  ylim(-0.04,0.04)
ggsave("hi_gamma_change_adjusted_scale.png",path = "plots/boxplots/lobes",width = 4000,height = 2160, units = c("px"))
