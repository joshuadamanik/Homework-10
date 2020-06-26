function phaseout = doubleIntegratorContinuous(input)

t  = input.phase.time;
x = input.phase.state(:,1);
y = input.phase.state(:,2);
vx = input.phase.state(:,3);
vy = input.phase.state(:,4);
u  = input.phase.control(:,1);

N = size(input.phase.control(:,1));

xdot = vx;
ydot = vy;
vxdot = zeros(N);
vydot = u;

phaseout.dynamics = [xdot, ydot, vxdot, vydot];
phaseout.integrand = 0.5*(u.^2);
