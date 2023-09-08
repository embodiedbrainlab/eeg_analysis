library(tidyverse)
library(ggplot2)
library(hrbrthemes)

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

# Overall Distribution (Dance vs. Control) -----------------------------------

ggplot(coherence, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Overall Distribution in Coherence", x = "Average Coherence", y = "Count", fill="Condition")
ggsave("overall_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))

# Delta Distribution ------------------------------------------------------

delta_values <- filter(coherence, freq_band == "delta")
ggplot(delta_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Distribution in Coherence in Delta", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(~test_session)
ggsave("delta_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))

# Theta Distribution ------------------------------------------------------

theta_values <- filter(coherence, freq_band == "theta")
ggplot(theta_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Distribution in Coherence in Theta", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(~test_session)
ggsave("theta_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))

# Alpha Distribution ------------------------------------------------------

alpha_values <- filter(coherence, freq_band == "alpha")
ggplot(alpha_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Distribution in Coherence in Alpha", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(~test_session)
ggsave("alpha_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))

# Beta Distribution -------------------------------------------------------

beta_values <- filter(coherence, freq_band == "beta")
ggplot(beta_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Distribution in Coherence in Beta", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(~test_session)
ggsave("beta_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))


# Low Gamma Distribution --------------------------------------------------

lowgamma_values <- filter(coherence, freq_band == "lowgamma")
ggplot(lowgamma_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Distribution in Coherence in Low Gamma", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(~test_session)
ggsave("lowgamma_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))


# High Gamma Distribution -------------------------------------------------

higamma_values <- filter(coherence, freq_band == "higamma")
ggplot(higamma_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  theme_ipsum() +
  labs(title = "Distribution in Coherence in High Gamma", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(~test_session)
ggsave("higamma_distribution.png",path = "plots/histograms/",width = 4000,height = 2160, units = c("px"))
