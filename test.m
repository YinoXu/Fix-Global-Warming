G=6.6743e-11;
R=6.371e6;
m_jupiter=1.898e27;
des=1.4827e11;
tmax=365.25*24*60*60*7;
clockmax=1000;
dt=tmax/clockmax;
xsave = zeros(1,clockmax);
ysave = zeros(1,clockmax);
tsave = zeros(1,clockmax);
x=des; % distance from Jupiter to Earth
y=0; % Earth and Jupiter are assumed to be in the same plane
r=sqrt(x^2+y^2);
u=-0.7*sqrt(G*m_jupiter/r); % velocity towards Jupiter
v=sqrt(G*m_jupiter/r); % perpendicular velocity for an orbit
center = [0 0];

radius = des/2;
numPoints = 10000;
theta = linspace(0, 2*pi, numPoints);
Cx = center(1) + radius*cos(theta);
Cy = center(2) + radius*sin(theta);

plot(0,0,'r*');
hold on;
plot(Cx, Cy);
hold on;
hp=plot(x,y,'bo'); %Plot the blue colored circle markers
htrail=plot(x,y);
axis(1.1*[-des,des,-des,des]);
axis equal;
axis manual;

for clock=1:clockmax
    t=clock*dt;
    r=sqrt(x^2+y^2);
    if(r>0.7*des)
        u=u-dt*G*m_jupiter*x/r^3;
        v=v-dt*G*m_jupiter*y/r^3;
        x=x+dt*u;
        y=y+dt*v;
        r=sqrt(x^2+y^2);
        tsave(clock)=t;
        xsave(clock)=x;
        ysave(clock)=y;

        if(mod(clock,10)==0)
            hp.XData = x;
            hp.YData = y;
            htrail.XData=xsave(1:clock);
            htrail.YData=ysave(1:clock);
            drawnow;
        end
    end %end if
end


axis equal