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

# Delta -------------------------------------------------------------------

delta_values <- filter(coherence, freq_band == "delta")
ggplot(delta_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  labs(title = "Distribution in Coherence in Delta", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(vars(test_session,lobe), nrow = 2, ncol = 4)
ggsave("delta_distribution.png",path = "plots/histograms/lobes",width = 4000,height = 2160, units = c("px"))

# Theta -------------------------------------------------------------------

theta_values <- filter(coherence, freq_band == "theta")
ggplot(theta_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  labs(title = "Distribution in Coherence in Theta", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(vars(test_session,lobe), nrow = 2, ncol = 4)
ggsave("theta_distribution.png",path = "plots/histograms/lobes",width = 4000,height = 2160, units = c("px"))

# Alpha -------------------------------------------------------------------

alpha_values <- filter(coherence, freq_band == "alpha")
ggplot(alpha_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  labs(title = "Distribution in Coherence in Alpha", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(vars(test_session,lobe), nrow = 2, ncol = 4)
ggsave("alpha_distribution.png",path = "plots/histograms/lobes",width = 4000,height = 2160, units = c("px"))

# Beta -------------------------------------------------------------------

beta_values <- filter(coherence, freq_band == "beta")
ggplot(beta_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  labs(title = "Distribution in Coherence in Beta", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(vars(test_session,lobe), nrow = 2, ncol = 4)
ggsave("beta_distribution.png",path = "plots/histograms/lobes",width = 4000,height = 2160, units = c("px"))

# Low Gamma -------------------------------------------------------------------

lowgamma_values <- filter(coherence, freq_band == "lowgamma")
ggplot(lowgamma_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  labs(title = "Distribution in Coherence in Low Gamma", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(vars(test_session,lobe), nrow = 2, ncol = 4)
ggsave("lowgamma_distribution.png",path = "plots/histograms/lobes",width = 4000,height = 2160, units = c("px"))

# High Gamma -------------------------------------------------------------------

higamma_values <- filter(coherence, freq_band == "higamma")
ggplot(higamma_values, aes(x = avg_coh, fill = condition)) +
  geom_histogram(binwidth = 0.01, color="#e9ecef", alpha=0.6, position = 'identity') +
  labs(title = "Distribution in Coherence in High Gamma", x = "Average Coherence", y = "Count", fill="Condition") +
  facet_wrap(vars(test_session,lobe), nrow = 2, ncol = 4)
ggsave("higamma_distribution.png",path = "plots/histograms/lobes",width = 4000,height = 2160, units = c("px"))
