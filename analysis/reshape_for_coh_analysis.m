%% Shaping Data
% short code written so that an output with columns of average
% delta, theta, alpha, beta, low gamma, and high gamma are provided

%% CREATING A COMPILED COHERENCE ARRAY

% Check if delta_avg is 1x32, and transpose it if necessary
if size(delta_avg, 1) == 1 && size(delta_avg, 2) == 32
    delta_avg = delta_avg.';
end

% Check if theta_avg is 1x32, and transpose it if necessary
if size(theta_avg, 1) == 1 && size(theta_avg, 2) == 32
    theta_avg = theta_avg.';
end

% Check if alpha_avg is 1x32, and transpose it if necessary
if size(alpha_avg, 1) == 1 && size(alpha_avg, 2) == 32
    alpha_avg = alpha_avg.';
end

% Check if beta_avg is 1x32, and transpose it if necessary
if size(beta_avg, 1) == 1 && size(beta_avg, 2) == 32
    beta_avg = beta_avg.';
end

% Check if lowgamma_avg is 1x32, and transpose it if necessary
if size(lowgamma_avg, 1) == 1 && size(lowgamma_avg, 2) == 32
    lowgamma_avg = lowgamma_avg.';
end

% Check if higamma_avg is 1x32, and transpose it if necessary
if size(higamma_avg, 1) == 1 && size(higamma_avg, 2) == 32
    higamma_avg = higamma_avg.';
end

% Concatenate the coherence arrays into a 32x6 array
COHERENCE_array = [delta_avg, theta_avg, alpha_avg, beta_avg, lowgamma_avg, higamma_avg];

%% CREATING A COMPILED SEM ARRAY

% Check if delta_sem is 1x32, and transpose it if necessary
if size(delta_sem, 1) == 1 && size(delta_sem, 2) == 32
    delta_sem = delta_sem.';
end

% Check if theta_sem is 1x32, and transpose it if necessary
if size(theta_sem, 1) == 1 && size(theta_sem, 2) == 32
    theta_sem = theta_sem.';
end

% Check if alpha_sem is 1x32, and transpose it if necessary
if size(alpha_sem, 1) == 1 && size(alpha_sem, 2) == 32
    alpha_sem = alpha_sem.';
end

% Check if beta_sem is 1x32, and transpose it if necessary
if size(beta_sem, 1) == 1 && size(beta_sem, 2) == 32
    beta_sem = beta_sem.';
end

% Check if lowgamma_sem is 1x32, and transpose it if necessary
if size(lowgamma_sem, 1) == 1 && size(lowgamma_sem, 2) == 32
    lowgamma_sem = lowgamma_sem.';
end

% Check if higamma_sem is 1x32, and transpose it if necessary
if size(higamma_sem, 1) == 1 && size(higamma_sem, 2) == 32
    higamma_sem = higamma_sem.';
end

% Concatenate the SEM arrays into a 32x6 array
SEM_array = [delta_sem, theta_sem, alpha_sem, beta_sem, lowgamma_sem, higamma_sem];
