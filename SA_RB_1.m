function [res,sol]=SA_RB_1(C,Q,N,alfa,a,t0,tf,Lk)
%--------------------------------------------------------------------------
%   ������tmax��ѭ���и���RBģ�͵�һ�����н⣬��������ҵ�����ô����ȫ�����顣
%   C��Q�ֱ�Ϊ������RBģ��ʵ����tmax������ѭ��������N�Ǳ���������alfa�ǲ���
%--------------------------------------------------------------------------
    d=round(N^alfa);%������Ĵ�С
    [~,k,tt] = size(Q);
%��������
    qw = 1:k;
    dw = 0:d-1;
% a = 0.99;
% t0 = 97;
% tf = 3;
% t = t0;
%  Markov_length = 10000;
t=t0;%��ʼ�¶�
sol_new = floor(rand(1,N)*d);         %������ʼ��
%sol_new��ÿ�β������½⣻sol_current�ǵ�ǰ�⣬sol_best����ȴ�е���ý⣻
E_current = inf;  %E_current�ǵ�ǰ���Ӧ�Ļ�·����
E_best = inf;     %E_best�����Ž��Ӧ�Ļ�·����
                  %E_new���½��
sol_current = sol_new;
sol_best = sol_new;


while t >= tf
    for r = 1:Lk;     %Markov������
        is_SAT = false;
        %��������Ŷ�
        
        if (rand<3/t) %��������ǽ������ֽ���
            sol_new = sol_best;%�����Ž�����Ŷ�
            jcsx=randperm(tt);%������ظ�ѡȡ������˳��
            ci = 0;
            for ti = jcsx
                Cti = C(ti,:);%ȡ��Լ���������еĵ�ti��Լ��,��Cti�д�ŵ���Լ������
                Qti = Q(:,:,ti);
                solvv = sol_new(Cti(1:k));
                if is_exit(solvv,Qti)==1
                    ci = ti;
                    break;
                end
            end
            if ci~=0
                %��ô���൱������ҵ�һ���������Լ����
                Ci = C(ci,:);
                Qi = Q(:,:,ci);
                indr = randi(k);%ȡ��һ�������λ��
                cindr = (qw~=indr);
                vr = Ci(indr);%ȡ��indr��Ӧ�ı���
                cvr = Ci(cindr);
                sol_cvr = sol_new(cvr);
                loc = (Qi(:,cindr)==sol_cvr);
                iicQ = Qi(loc,indr);%ȫ����vr����ȡ��ֵ
                ocQ = setdiff(dw,iicQ);
                sol_new(vr)=ocQ(floor(rand()*length(ocQ)+1));%�Խ��������
            end
        else
            nn = randi(N);
            if rand<0.5
                 sol_new(1:nn) = floor(rand(1,nn)*d);
            else
                 sol_new(nn:N) = floor(rand(1,N-nn+1)*d);
            end
        end
        %����Ƿ�����Լ��
        %����Ŀ�꺯��ֵ
        E_new = jishu_isexit(C,Q,sol_new);
        if E_new < E_current
            E_current = E_new;
            sol_current = sol_new;
            if E_new < E_best
                %����ȴ�����е���ýⱣ������
                E_best = E_new;
                sol_best = sol_new;
            end
        else
        %���½��Ŀ�꺯��ֵС�ڵ�ǰ�⣬����һ�����ʽ����½�
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
% disp('���Ž�Ϊ��')
% disp(sol_best)
disp('���ٲ�����Լ���ĸ�����')
disp(E_best)
end