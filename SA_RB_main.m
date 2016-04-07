clear
clc
a = 0.95;
t0 = 97;
tf = 3;
Lk = 1000;
k = 2;
alfa = 0.8;
r = 3;
p = 0:0.01:0.2;% 通过参数p或者r变动来观测相变点！
tmax = 10^3;    %随机游走法的迭代次数
M = 50; %同一组参量产生的实例的个数
P = zeros(1,length(p));
PP1 = zeros(length(p),M);
TT1 = zeros(length(p),M);

N1=20;
for pi = p
    nums = 0;
 for i = 1:M 
    [C,Q] = RB_plus(k,N1,alfa,r,pi);
    tic;[res,sol]=SA_RB_1(C,Q,N1,alfa,a,t0,tf,Lk);
    TT1(p==pi,i) = toc;
    PP1(p==pi,i) = res;
    disp(['目前计算的p=',num2str(pi)]);
    disp(['目前计算到第',num2str(i),'组'])
 end
end
save('dataN20.mat','TT1','PP1');