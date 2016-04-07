clear
clc
a = 0.95;
t0 = 97;
tf = 3;
Lk = 1000;
k = 2;
alfa = 0.8;
r = 3;
p = 0:0.01:0.2;% ͨ������p����r�䶯���۲����㣡
tmax = 10^3;    %������߷��ĵ�������
M = 50; %ͬһ�����������ʵ���ĸ���
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
    disp(['Ŀǰ�����p=',num2str(pi)]);
    disp(['Ŀǰ���㵽��',num2str(i),'��'])
 end
end
save('dataN20.mat','TT1','PP1');