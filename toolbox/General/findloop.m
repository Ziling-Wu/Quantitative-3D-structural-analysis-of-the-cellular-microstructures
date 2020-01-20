function [lp4,lp5,lp6,lp7,nb,fnb]=findloop(ce,n0,datas)
thres = 90;
lp4=[];
lp5=[];
lp6=[];
lp7=[];


% the first order neighbor 
t1= ce(ce(:,1)==n0,2);
t1=[t1;ce(ce(:,2)==n0,1)];
n1=[];nb1=[];
for i=1:length(t1)
    n1=[n1,{t1(i)}];
    nb1=[nb1,t1(i)];
end
nb(1)={n1};
fnb(1)={nb1'};

nb2=[];

% the 2nd order neighbors 
  for i=1:length(n1)   % all the first order neighbor nodes  
        t2= ce(ce(:,1)==nb{1}{i},2);
        t2=[t2;ce(ce(:,2)==nb{1}{i},1)];
        t2=t2(t2~=n0);% make sure the 2nd order is not the 0th order 
        n2t=[];
        for j=1:length(t2)
             n2t=[n2t,{t2(j)}];
             nb2=[nb2,t2(j)];
        end
        n2{i}=n2t;
  end

  nb(2)={n2};
  fnb(2)={nb2'};
  
%%   the 3rd order neighbors 
clear temp loop 
nb3=[];
loop=null(3);
   for i=1:length(n1)% all the first order neighbor nodes  
              for j=1:length(n2{i})% all the second order neighbor nodes  
                temp= ce(ce(:,1)==nb{2}{i}{j},2);
                temp=[temp;ce(ce(:,2)==nb{2}{i}{j},1)];
                temp=temp(temp~=n1{i}); 
                if ~isempty(find(temp==n0)) 
                    loop=[loop,[i,j,find(temp==n0)]];
                end
                t3=[];
                for k=1:length(temp)
                    t3=[t3,{temp(k)}];
                    nb3=[nb3,temp(k)];
                end
                n3{i}{j}=t3;
              end          
   end
   nb(3)={n3};
   fnb(3)={nb3'};
    
   
   %%   the 4th order neighbors 
clear n4 t4 temp loop nb4
   
loop=null(4); nb4=[];
   for i=1:length(n1)
              for j=1:length(n2{i})
                  for k=1:length(n3{i}{j})
                temp= ce(ce(:,1)==nb{3}{i}{j}{k},2);
                temp=[temp;ce(ce(:,2)==nb{3}{i}{j}{k},1)];
                temp=temp(temp~=n2{i}{j}); 
                if ~isempty(find(temp==n0)) 
                    loop=[loop;[i,j,k,find(temp==n0)]];
                end
                t4=[];
                for l=1:length(temp)
                    t4=[t4,{temp(l)}];
                     nb4=[nb4,temp(l)];
                end
                n4{i}{j}{k}=t4;
                  end
              end          
   end
    nb(4)={n4};
    fnb(4)={nb4'};
    if ~isempty(loop)
    lp4=zeros(size(loop));
    for i=1:size(loop,1)
    lp4(i,:)=[n0,nb{1}{loop(i,1)},nb{2}{loop(i,1)}{loop(i,2)},nb{3}{loop(i,1)}{loop(i,2)}{loop(i,3)}];
    end
    % delete rows with repeated nodes in one row
    record = [];
    for i = 1:size(lp4,1)
        if length(unique(lp4(i,:)))==4
            record = [record,i];
        end
    end
    lp4 = lp4(record,:);
    % delete repeated rows
    lp4Sum = prod(lp4(:,2:4),2);
    lp4Sum = lp4Sum/10^(floor(log(mean(lp4Sum))./log(10)));
    [~,ia,~]= unique(round(lp4Sum,4));
    lp4 = lp4(ia,:);
    end
    %% the 5th order neighbors 
clear n5 t5 temp loop
   
loop=null(5);nb5=[];
   for i=1:length(n1)
              for j=1:length(n2{i})
                  for k=1:length(n3{i}{j})
                      for l=1:length(n4{i}{j}{k})
                temp= ce(ce(:,1)==nb{4}{i}{j}{k}{l},2);
                temp=[temp;ce(ce(:,2)==nb{4}{i}{j}{k}{l},1)];
                temp=temp(temp~=n3{i}{j}{k}); 
                if ~isempty(find(temp==n0)) 
                    loop=[loop;[i,j,k,l,find(temp==n0)]];
                end
                t5=[];
                for m=1:length(temp)
                    t5=[t5,{temp(m)}];
                    nb5=[nb5,temp(m)];
                end
                n5{i}{j}{k}{l}=t5;
                      end
                  end
              end          
   end
   
    nb(5)={n5};
    fnb(5)={nb5'};
    
  if ~isempty(loop)
    lp5=zeros(size(loop));
    for i=1:size(loop,1)
    lp5(i,:)=[n0,nb{1}{loop(i,1)},nb{2}{loop(i,1)}{loop(i,2)},nb{3}{loop(i,1)}{loop(i,2)}{loop(i,3)},nb{4}{loop(i,1)}{loop(i,2)}{loop(i,3)}{loop(i,4)}];
    end
    % delete rows with repeated nodes in one row
    record = [];
    for i = 1:size(lp5,1)
        if length(unique(lp5(i,:)))==5
            record = [record,i];
        end
    end
    lp5 = lp5(record,:);
    % delete repeated rows
    lp5Sum = prod(lp5(:,2:5),2);
    lp5Sum = lp5Sum/10^(floor(log(mean(lp5Sum))./log(10)));
    [~,ia,~]= unique(round(lp5Sum,4));
    lp5 = lp5(ia,:);
    
  end
    
     %% the 6th order neighbors 
clear n6 t6 temp loop
   
loop=null(6);nb6=[];
   for i=1:length(n1)
              for j=1:length(n2{i})
                  for k=1:length(n3{i}{j})
                      for l=1:length(n4{i}{j}{k})
                          for m=1:length(n5{i}{j}{k}{l})
                temp= ce(ce(:,1)==nb{5}{i}{j}{k}{l}{m},2);
                temp=[temp;ce(ce(:,2)==nb{5}{i}{j}{k}{l}{m},1)];
                temp=temp(temp~=n4{i}{j}{k}{l}); 
                if ~isempty(find(temp==n0)) 
                    loop=[loop;[i,j,k,l,m,find(temp==n0)]];
                end
                t6=[];
                for o=1:length(temp)
                    t6=[t6,{temp(o)}];
                    nb6=[nb6,temp(o)];
                end
                n6{i}{j}{k}{l}{m}=t6;
                          end
                      end
                  end
              end          
   end
   
    nb(6)={n6};
    fnb(6)={nb6'};
    
    
    
    
    
    if ~isempty(loop)    
    lp6=zeros(size(loop));
    for i=1:size(loop,1)
        lp6(i,:)=[n0,nb{1}{loop(i,1)},nb{2}{loop(i,1)}{loop(i,2)},nb{3}{loop(i,1)}{loop(i,2)}{loop(i,3)},nb{4}{loop(i,1)}{loop(i,2)}{loop(i,3)}{loop(i,4)},nb{5}{loop(i,1)}{loop(i,2)}{loop(i,3)}{loop(i,4)}{loop(i,5)}];
    end
    record = [];
     % delete rows with repeated nodes in one row
    for i = 1:size(lp6,1)
        if length(unique(lp6(i,:)))==6
            record = [record,i];
        end
    end
    lp6 = lp6(record,:);
    % delete repeated rows
    lp6Sum = prod(lp6(:,2:6),2);
    
    lp6Sum = lp6Sum/10^(floor(log(mean(lp6Sum))./log(10)));
    [~,ia,~]= unique(round(lp6Sum,4));
    lp6 = lp6(ia,:);
    
%     Thetarecord = [];% in one plane or not
%     for j = 1:size(lp6,1)
%         lp = lp6(j,:);
%         [x,y,z]=ind2sub(datas,lp');
%         v1 = [x(2)-x(1),y(2)-y(1),z(2)-z(1)];
%         v1 = v1/norm(v1);
%         v2 = [x(6)-x(1),y(6)-y(1),z(6)-z(1)];
%         v2 = v2/norm(v2);
%         v = cross(v1,v2);
%         for i =3:length(lp)
%             vt = [x(i)-x(i-1),y(i)-y(i-1),z(i)-z(i-1)];
%             vt = vt/norm(vt);
%             theta = abs(acosd(dot(vt,v)/(norm(vt)*norm(v)))-90);
%             Thetarecord(j,i-2) = theta;
%         end
%     end
%     loc = [];
%     for i = 1:size(Thetarecord,1)
%         if max(Thetarecord(i,:))<=thres
%             loc = [loc;i];
%         end
%     end
%     lp6 = lp6(loc,:);
    end
    
%% the 7th order neighbors 
clear n7 t7 temp loop
   
loop=null(7);nb7=[];
   for i=1:length(n1)
              for j=1:length(n2{i})
                  for k=1:length(n3{i}{j})
                      for l=1:length(n4{i}{j}{k})
                          for m=1:length(n5{i}{j}{k}{l})
                              for o=1:length(n6{i}{j}{k}{l}{m})
                temp= ce(ce(:,1)==nb{6}{i}{j}{k}{l}{m}{o},2);
                temp=[temp;ce(ce(:,2)==nb{6}{i}{j}{k}{l}{m}{o},1)];
                temp=temp(temp~=n5{i}{j}{k}{l}{m}); 
                if ~isempty(find(temp==n0)) 
                    loop=[loop;[i,j,k,l,m,o,find(temp==n0)]];
                end
                t7=[];
                for p=1:length(temp)
                    t7=[t7,{temp(p)}];
                    nb7=[nb7,temp(p)];
                end
                n7{i}{j}{k}{l}{m}{o}=t7;
                              end
                          end
                      end
                  end
              end          
   end
   
    nb(7)={n7};
    fnb(7)={nb7'};
    
    if ~isempty(loop)    
    lp7=zeros(size(loop));
    for i=1:size(loop,1)
        lp7(i,:)=[n0,nb{1}{loop(i,1)},nb{2}{loop(i,1)}{loop(i,2)},nb{3}{loop(i,1)}{loop(i,2)}{loop(i,3)},nb{4}{loop(i,1)}{loop(i,2)}{loop(i,3)}{loop(i,4)},nb{5}{loop(i,1)}{loop(i,2)}{loop(i,3)}{loop(i,4)}{loop(i,5)},nb{6}{loop(i,1)}{loop(i,2)}{loop(i,3)}{loop(i,4)}{loop(i,5)}{loop(i,6)}];
    end
    
    
    record = [];
    % delete rows with repeated nodes in one row
    for i = 1:size(lp7,1)
        if length(unique(lp7(i,:)))==7
            record = [record,i];
        end
    end
    lp7 = lp7(record,:);
    % delete repeated rows
    lp7Sum = prod(lp7(:,2:7),2);
    lp7Sum = lp7Sum/10^(floor(log(mean(lp7Sum))./log(10)));
    [~,ia,~]= unique(round(lp7Sum,4));
    lp7 = lp7(ia,:);
    
%     Thetarecord = [];% in one plane or not
% for j = 1:size(lp7,1)
%     lp = lp7(j,:);
%     [x,y,z]=ind2sub(datas,lp');
%     v1 = [x(2)-x(1),y(2)-y(1),z(2)-z(1)];
%     v1 = v1/norm(v1);
%     v2 = [x(7)-x(1),y(7)-y(1),z(7)-z(1)];
%     v2 = v2/norm(v2);
%     v = cross(v1,v2);
%     for i =3:length(lp)
%         vt = [x(i)-x(i-1),y(i)-y(i-1),z(i)-z(i-1)];
%         vt = vt/norm(vt);
%         theta = abs(acosd(dot(vt,v)/(norm(vt)*norm(v)))-90);
%         Thetarecord(j,i-2) = theta;
%     end
% end
% loc = [];
%     for i = 1:size(Thetarecord,1)
%         if max(Thetarecord(i,:))<=thres
%             loc = [loc;i];
%         end
%     end
%     lp7 = lp7(loc,:);
    end
end