G = 6.6743 * 10^(-11);
M = 1.98892 * 10^30;
T_s = 5778;
r_s = 6.955 * 10^8;
tmax = 365.25 * 24 * 60 * 60;
res = 1.496 * 10^11;
size_d=res/4.2;
colockmax = 1000;
dt = tmax/colockmax;
xsave = zeros(1, colockmax);
ysave = zeros(1, colockmax);
tsave = zeros(1, colockmax);
sr=1;
x= res;
y=0;
u=0;
v=sr*sqrt(G*M/res);


 
 for c=0:size_d:res-1
     b = (res)-c;
     a = 2 * res - b;
     x=a;
     y=0;
     u=0;
     v=sqrt((b/a)*(2*G*M/(a+b)));
    
    for clock = 1:colockmax
        t = clock *dt;
        r = sqrt(x^2+y^2);
        T_e = T_s*sqrt(r_s/(2*r));
        u = u-dt*G*M*x/r^3;
        v = v-dt*G*M*y/r^3;
        x = x + dt*u;
        y = y + dt*v;
        tsave(clock) = t;
        xsave(clock) = x;
        ysave(clock) = y;
        rsave(clock) = r;
    end
     
     %plot(0,0,'r*', xsave, ysave)
     %plot([xsave(1), xsave(end)], [ysave(1), ysave(end)]);

     %axis equal 

      % Calculate the effective temperature and plot it as a function of time
    R = sqrt(xsave.^2+ysave.^2);
    T_e_save = T_s * sqrt(r_s./(2*R));
    figure
    plot(linspace(0, colockmax, 1000), T_e_save);
    axis equal
    xlim([0, colockmax])
    ylim([100, 800])
    hold on
    
    % Compute the average effective temperature over the simulation time
    avg_T_e = mean(T_e_save);

    fprintf('At c = %e m\n, the average effective temperature: %.2f K\n', c, avg_T_e)
     
 end

hold off
xlabel('Time (s)')
ylabel('Effective temperature (K)')