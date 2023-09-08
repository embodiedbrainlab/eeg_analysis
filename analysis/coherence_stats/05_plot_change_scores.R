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

# Pivot Wide --------------------------------------------------------------

## Remove SEM Column
### We do this so that we can match pretest and posttest coherence values
coh_no_sem <- coherence %>%
  select(-sem)

coherence_change <- coh_no_sem %>%
  pivot_wider(names_from = test_session, values_from = c(avg_coh))

# Calculate Change Score --------------------------------------------------

coherence_change <- coherence_change %>%
  mutate(change_score = posttest- pretest)


# Summary Boxplot ---------------------------------------------------------

## All Frequency Bands
ggplot(coherence_change, aes(x = condition, y = change_score)) + 
  geom_boxplot() + 
  facet_wrap(vars(freq_band),
             nrow = 2, ncol = 6) + 
  labs(title = "Overall Change Score of Channels",
       x = "Condition", y = "Change Score")
ggsave("summaryplot_allfreq.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

## Plotting Gamma Bands Separately
gamma_coh_testing <- filter(coherence_change,freq_band == "lowgamma" | freq_band == "higamma")
ggplot(gamma_coh_testing, aes(x = condition, y = change_score)) + 
  geom_boxplot() + 
  facet_wrap(vars(freq_band),
             nrow = 2, ncol = 2) + 
  labs(title = "Overall Change Score of Channels",
       x = "Condition", y = "Change Score")
ggsave("summaryplot_gamma_only.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

# Delta Boxplots ----------------------------------------------------------

delta_change <- filter(coherence_change,freq_band == "delta") 

## Creating Boxplots for each Channel
ggplot(delta_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in Delta Band", x = "Condition", y = "Change Score")
ggsave("delta_change.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

# Theta Boxplots -------------------------------------------------------------------

theta_change <- filter(coherence_change, freq_band == "theta")

## Creating Boxplots for each Channel
ggplot(theta_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in Theta Band", x = "Condition", y = "Change Score")
ggsave("theta_change.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

# Alpha Boxplots ----------------------------------------------------------

alpha_change <- filter(coherence_change, freq_band == "alpha")

## Creating Boxplots for each Channel
ggplot(alpha_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in Alpha Band", x = "Condition", y = "Change Score")
ggsave("alpha_change.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

# Beta Boxplots -----------------------------------------------------------

beta_change <- filter(coherence_change, freq_band == "beta")

## Creating Boxplots for each Channel
ggplot(beta_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in Beta Band", x = "Condition", y = "Change Score")
ggsave("beta_change.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

# Low Gamma Boxplots ------------------------------------------------------

lowgamma_change <- filter(coherence_change, freq_band == "lowgamma")

## Creating Boxplots for each Channel
ggplot(lowgamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in Low Gamma Band", x = "Condition", y = "Change Score")
ggsave("low_gamma_change.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

### Adjusting Scales (but this keeps some outliers out of view)
ggplot(lowgamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in Low Gamma Band (ADJUSTED SCALE, SOME OUTLIERS REMOVED)", x = "Condition", y = "Change Score") + 
  ylim(-0.05,0.05)
ggsave("low_gamma_change_adjusted_scale.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

# High Gamma Boxplots -----------------------------------------------------

higamma_change <- filter(coherence_change, freq_band == "higamma")

## Creating Boxplots for each Channel
ggplot(higamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in High Gamma Band", x = "Condition", y = "Change Score")
ggsave("hi_gamma_change.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))

### Adjusting Scales (but this keeps some outliers out of view)
ggplot(higamma_change, aes(x = condition, y = change_score, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Change Score in High Gamma Band (ADJUSTED SCALE, SOME OUTLIERS REMOVED)", x = "Condition", y = "Change Score") + 
  ylim(-0.05,0.05)
ggsave("hi_gamma_change_adjusted_scale.png",path = "plots/boxplots",width = 4000,height = 2160, units = c("px"))