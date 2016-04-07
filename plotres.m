%概率图
ans0 = sum(PP0==0,2)/50;
ans1 = sum(PP1==0,2)/50;
ans2 = sum(PP2==0,2)/50;
ans3 = sum(PP3==0,2)/50;
ans4 = sum(PP4==0,2)/50;
p = 0:0.01:0.2;
figure(1)
plot(p,ans0,':*',p,ans1,':+',p,ans2,':o',p,ans3,':s',p,ans4,':d');
legend('N=20','N=40','N=60','N=80','N=100');
title('模拟退火算法求解RB模型的实验结果');
xlabel('p')
ylabel('可解概率P')
%时间图
tans0 = sum(TT0,2);
tans1 = sum(TT1,2);
tans2 = sum(TT2,2);
tans3 = sum(TT3,2);
tans4 = sum(TT4,2);
tt1 = [tans0(p==0.06),tans1(p==0.06),tans2(p==0.06),tans3(p==0.06),tans4(p==0.06)];
figure(2)
plot(20:20:100,tt1,':*')
w = p(19);
tt2 = [tans0(p==w),tans1(p==w),tans2(p==w),tans3(p==w),tans4(p==w)];
figure(3)
plot([20,40,60,80,100],tt2,':*')



%%
NNN = 20:20:100;
for i = 1:21
    ttt(i,:) = [tans0(i),tans1(i),tans2(i),tans3(i),tans4(i)];
    figure(i+3);
    plot(NNN,ttt(i,:),':*')
end
