% Define Transfer Function
s = tf('s');
sys = (0.03/(49*s^2+2.8*s+1)*(1/(s+1)));
[y,time] = step(sys);

% Find the critical gain value 
% corresponding to the neutral stability boundary
K_cr = margin(sys);

% Creating closed loop system with gain K_cr
Loop = series(K_cr,sys);
closed_system = feedback(Loop,1);
[y_cr, time] = step(closed_system,time);

% Find the period of oscillation P_cr
[~,idx] = findpeaks(y_cr);
P_cr = time(idx(2)) - time(idx(1));

% Plot the results
hold on
plot(time, y_cr, 'b')
plot([time(idx(1)) time(idx(2))],[max(y_cr) max(y_cr)],'r', 'LineWidth',2)

% Results output
K_cr, P_cr
P_Controller = [0.5*K_cr, 0, 0]
PI_Controller = [(0.45*K_cr), (1/(P_cr/1.2)), 0]
PID_Controller = [(0.6*K_cr), (1/(P_cr/2)), (P_cr/8)]