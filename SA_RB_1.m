function [res,sol]=SA_RB_1(C,Q,N,alfa,a,t0,tf,Lk)
%--------------------------------------------------------------------------
%   尝试在tmax次循环中给出RB模型的一个可行解，如果不能找到，那么返回全零数组。
%   C、Q分别为产生的RB模型实例，tmax是最大的循环次数，N是变量个数，alfa是参数
%--------------------------------------------------------------------------
    d=round(N^alfa);%定义域的大小
    [~,k,tt] = size(Q);
%其他参数
    qw = 1:k;
    dw = 0:d-1;
% a = 0.99;
% t0 = 97;
% tf = 3;
% t = t0;
%  Markov_length = 10000;
t=t0;%初始温度
sol_new = floor(rand(1,N)*d);         %产生初始解
%sol_new是每次产生的新解；sol_current是当前解，sol_best是冷却中的最好解；
E_current = inf;  %E_current是当前解对应的回路距离
E_best = inf;     %E_best是最优解对应的回路距离
                  %E_new是新解的
sol_current = sol_new;
sol_best = sol_new;


while t >= tf
    for r = 1:Lk;     %Markov链长度
        is_SAT = false;
        %产生随机扰动
        
        if (rand<3/t) %随机决定是进行那种交换
            sol_new = sol_best;%对最优解进行扰动
            jcsx=randperm(tt);%随机不重复选取出检验顺序
            ci = 0;
            for ti = jcsx
                Cti = C(ti,:);%取出约束变量集中的第ti个约束,即Cti中存放的是约束变量
                Qti = Q(:,:,ti);
                solvv = sol_new(Cti(1:k));
                if is_exit(solvv,Qti)==1
                    ci = ti;
                    break;
                end
            end
            if ci~=0
                %那么就相当于随机找到一个不满足的约束。
                Ci = C(ci,:);
                Qi = Q(:,:,ci);
                indr = randi(k);%取出一个随机的位置
                cindr = (qw~=indr);
                vr = Ci(indr);%取出indr对应的变量
                cvr = Ci(cindr);
                sol_cvr = sol_new(cvr);
                loc = (Qi(:,cindr)==sol_cvr);
                iicQ = Qi(loc,indr);%全部的vr不能取得值
                ocQ = setdiff(dw,iicQ);
                sol_new(vr)=ocQ(floor(rand()*length(ocQ)+1));%对解进行修正
            end
        else
            nn = randi(N);
            if rand<0.5
                 sol_new(1:nn) = floor(rand(1,nn)*d);
            else
                 sol_new(nn:N) = floor(rand(1,N-nn+1)*d);
            end
        end
        %检查是否满足约束
        %计算目标函数值
        E_new = jishu_isexit(C,Q,sol_new);
        if E_new < E_current
            E_current = E_new;
            sol_current = sol_new;
            if E_new < E_best
                %把冷却过程中的最好解保存下来
                E_best = E_new;
                sol_best = sol_new;
            end
        else
        %若新解的目标函数值小于当前解，则以一定概率接受新解
            if(rand<exp(-(E_new-E_current)./t))
                E_current = E_new;
                sol_current = sol_new;
            else
                sol_new = sol_current;
            end
        end
        
        if E_best==0
            is_SAT = true;
            break
        end
    end
    if(is_SAT)
        break;
    end
    t = t .*a;
end
sol = sol_best;
res = E_best;
% disp('最优解为：')
% disp(sol_best)
disp('最少不满足约束的个数：')
disp(E_best)
end