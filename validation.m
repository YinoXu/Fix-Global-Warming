G = 6.6743 * 10^(-11);
M = 1.98892 * 10^30;
T_s = 5778;
r_s = 6.955 * 10^8;
tmax = 365.25 * 24 * 60 * 60;
res = 1.496 * 10^11;
size_d=res/5;
colockmax = 1000;

% Define range of time step sizes to test
dt_values = [10, 5, 1, 0.1, 0.01];

for dt = dt_values
    % Calculate number of time steps
    colockmax = ceil(tmax / dt);
    
    % Initialize arrays for saving trajectory
    xsave = zeros(1, colockmax);
    ysave = zeros(1, colockmax);
    tsave = zeros(1, colockmax);
    
    % Initialize initial conditions
    sr = 1;
    x = res;
    y = 0;
    u = 0;
    v = sr * sqrt(G * M / res);
    
    % Run simulation
    for clock = 1:colockmax
        t = clock * dt;
        r = sqrt(x^2 + y^2);
        T_e = T_s * sqrt(r_s / (2 * r));
        u = u - dt * G * M * x / r^3;
        v = v - dt * G * M * y / r^3;
        x = x + dt * u;
        y = y + dt * v;
        tsave(clock) = t;
        xsave(clock) = x;
        ysave(clock) = y;
    end
    
    % Plot trajectory
    figure
    plot(0, 0, 'r*')
    hold on
    plot(xsave, ysave)
    plot(xsave(1), ysave(1), 'go')
    plot(xsave(end), ysave(end), 'bo')
    axis equal
    xlabel('x (m)')
    ylabel('y (m)')
    title(sprintf('Trajectory (dt = %.3f s)', dt))
    
    % Calculate effective temperature and plot it as a function of time
    R = sqrt(xsave.^2 + ysave.^2);
    T_e_save = T_s * sqrt(r_s ./ (2 * R));
    figure
    plot(tsave, T_e_save)
    xlabel('Time (s)')
    ylabel('Effective temperature (K)')
    title(sprintf('Effective temperature (dt = %.3f s)', dt))
    xlim([0, tmax])
    ylim([100, 700])
end
