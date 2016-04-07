function [C,Q]=RB_plus(k,N,alfa,r,p)
%--------------------------------------------------------------------------
%   %�������RBģ�ͣ�C�д�Ÿ���Լ����Լ�����������Q�д������֮��Ĳ��ɼ���ֵ
%--------------------------------------------------------------------------
%   �ɸ������Ʋ������������Ӧ����
%   k��ʾÿ��Լ���к��еı�������
d = round(N^alfa);         %����������ֵ��
t = round(r*N*log(N));     %Լ���ĸ���
q = round(p*d^k);          %���ɼ���ֵ�ĸ���
%   ��ʼ���������
C=zeros(t,k);
Q=zeros(q,k,t);            %Q�е�����ά�ȣ�t��ʾ��Ӧ�ĵڼ���Լ����q ��ʾ�ڼ��鲻����ֵ��k��ʾ�ڼ���������
%   ����������ظ�ѡȡ t ��Լ����ÿ��Լ������������ظ��Ĵ�N��������ѡ��k������
zb = [];
for i=1:t  
    C(i,:)=sort(randnorepeat(k,N));
    is_OK = true;
    while(is_OK)
        Mb = rand(2*q,k);
        Mb = floor(Mb*d);
        zb = [zb;Mb];
        zb = unique(zb,'rows');
        if(size(zb,1)>=q)
            is_OK = false;
        end
    end
    %�����zb�г�ȡ���ɼ��ݵ�ֵ��
    cmc = randperm(size(zb,1),q);
    Q(1:q,:,i) = zb(cmc,:);
end
end