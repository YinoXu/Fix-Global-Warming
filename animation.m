G = 6.6743 * 10^(-11); % gravitational forvce
M = 1.98892 * 10^30;
T_s = 5778;
r_s = 6.955 * 10^8;
tmax = 365.25 * 24 * 60 * 60;
res = 1.496 * 10^11;
size_d = res/4.2;
colockmax = 1000;
dt = tmax/colockmax*10;
sr = 1;
x = res;
y = 0;
u = 0;
v = sr * sqrt(G*M/res);

figure()
hold on
plot(0,0,'r*')
axis([-1.5e+11 3e+11 -2e+11 2e+11])
plots = gobjects(3, 1);
savex = zeros(1000,5);
savey = zeros(1000,5);
counter = 1;

for c = 0:size_d:res-2*size_d
    b = (res) - c;
    a = 2 * res - b;
    x = a;
    y = 0;
    u = 0;
    v = sqrt((b/a)*(2*G*M/(a+b)));
    
    % create a new plot object for this orbit
    plots(counter) = plot(x, y, '.');
    
    for clock = 1:colockmax
        t = clock * dt;
        r = sqrt(x^2+y^2);
        T_e = T_s * sqrt(r_s/2 * r);
        u = u - dt * G * M * x / r^3;
        v = v - dt * G * M * y / r^3;
        x = x + dt * u;
        y = y + dt * v;
        savex(clock, counter) = x;
        savey(clock, counter) = y;
    end
    counter = counter + 1;
   
end


for clock = 1:colockmax

    counter = 1;
    for c = 0:size_d:res-2*size_d
        
        % update the position of the Earth in the current orbit
        set(plots(counter), 'XData', savex(clock,counter), 'YData', savey(clock,counter));
        counter = counter + 1;
        drawnow % update the figure
    end
    
end

hold off