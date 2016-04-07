 function res=jishu_isexit(C,Q,sol)            %,N,alfa
%--------------------------------------------------------------------------
%   计算一个赋值sol违反约束的个数，利用ismember函数
%   C、Q分别为产生的RB模型实例
%--------------------------------------------------------------------------
 [~,k,t]=size(Q);                       %其他参数
 res = 0;
 for i = 1:t
     Ci = C(i,:);
     solvv = sol(Ci(1:k));
     Qi = Q(:,:,i);
     if is_exit(solvv,Qi)==1
         res = res + 1;
     end    
 end
 end