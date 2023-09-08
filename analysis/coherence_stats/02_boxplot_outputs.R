library(tidyverse)
library(ggplot2)

setwd("D:/dance_brain_study/coherence_stats_analysis")
coherence <- read_csv("coherence_conditions.csv")

# Refactor Categorical Variables ---------------------------------------
coherence <- coherence %>%
  mutate(test_session = fct_relevel(test_session, c("pretest", "posttest")),
         condition = fct_relevel(condition, c("dance","control")),
         freq_band = fct_relevel(freq_band, c("delta","theta","alpha","beta","lowgamma","higamma")))

# Summary Boxplot ---------------------------------------------------------
ggplot(coherence, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() + 
  facet_wrap(vars(condition,freq_band),
             nrow = 2, ncol = 6) + 
  labs(title = "Overall Average Coherence of Channels",
       x = "Testing Session", y = "Average Coherence")
ggsave("summaryplot.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

# Delta Boxplots ----------------------------------------------------------

## Creating Separate Datasets for Dance and Control
delta_dance <- filter(coherence,freq_band == "delta" & condition == "dance") 
delta_control <- filter(coherence,freq_band == "delta" & condition == "control")

### Creating Boxplots for each Channel in Dance Condition
ggplot(delta_dance, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Delta Band for DANCE Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("delta_dance.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

### Creating Boxplots for each Channel in Control Condition
ggplot(delta_control, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Delta Band for CONTROL Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("delta_control.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

# Theta Boxplots ----------------------------------------------------------

## Creating Separate Datasets for Dance and Control
theta_dance <- filter(coherence,freq_band == "theta" & condition == "dance") 
theta_control <- filter(coherence,freq_band == "theta" & condition == "control")

### Creating Boxplots for each Channel in Dance Condition
ggplot(theta_dance, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Theta Band for DANCE Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("theta_dance.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

### Creating Boxplots for each Channel in Control Condition
ggplot(theta_control, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Theta Band for CONTROL Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("theta_control.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

# Alpha Boxplots ----------------------------------------------------------

## Creating Separate Datasets for Dance and Control
alpha_dance <- filter(coherence,freq_band == "alpha" & condition == "dance") 
alpha_control <- filter(coherence,freq_band == "alpha" & condition == "control")

### Creating Boxplots for each Channel in Dance Condition
ggplot(alpha_dance, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Alpha Band for DANCE Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("alpha_dance.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

### Creating Boxplots for each Channel in Control Condition
ggplot(alpha_control, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Alpha Band for CONTROL Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("alpha_control.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

# Beta Boxplots -----------------------------------------------------------

## Creating Separate Datasets for Dance and Control
beta_dance <- filter(coherence,freq_band == "beta" & condition == "dance") 
beta_control <- filter(coherence,freq_band == "beta" & condition == "control")

### Creating Boxplots for each Channel in Dance Condition
ggplot(beta_dance, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Beta Band for DANCE Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("beta_dance.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

### Creating Boxplots for each Channel in Control Condition
ggplot(beta_control, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Beta Band for CONTROL Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("beta_control.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

# Low Gamma Boxplots ------------------------------------------------------

## Creating Separate Datasets for Dance and Control
lowgamma_dance <- filter(coherence,freq_band == "lowgamma" & condition == "dance") 
lowgamma_control <- filter(coherence,freq_band == "lowgamma" & condition == "control")

### Creating Boxplots for each Channel in Dance Condition
ggplot(lowgamma_dance, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Low Gamma Band for DANCE Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("lowgamma_dance.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

### Creating Boxplots for each Channel in Control Condition
ggplot(lowgamma_control, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in Low Gamma Band for CONTROL Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("lowgamma_control.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

# High Gamma Boxplots -----------------------------------------------------

## Creating Separate Datasets for Dance and Control
higamma_dance <- filter(coherence,freq_band == "higamma" & condition == "dance") 
higamma_control <- filter(coherence,freq_band == "higamma" & condition == "control")

### Creating Boxplots for each Channel in Dance Condition
ggplot(higamma_dance, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in High Gamma Band for DANCE Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("higamma_dance.png",path = "plots/",width = 4000,height = 2160, units = c("px"))

### Creating Boxplots for each Channel in Control Condition
ggplot(higamma_control, aes(x = test_session, y = avg_coh, fill = activity)) + 
  geom_boxplot() +
  facet_wrap(~channel, nrow = 4, ncol = 8) + 
  labs(title = "Average Coherence in High Gamma Band for CONTROL Participants",
       x = "Testing Session", y = "Average Coherence")
ggsave("higamma_control.png",path = "plots/",width = 4000,height = 2160, units = c("px"))


