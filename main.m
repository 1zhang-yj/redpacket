% 使用多轮模拟的形式，以统计频率推算概率
% Use multi-round simulation to calculate probability based on statistical frequency
clear;clc;close all
peoplenum = 5;      % 抢红包的人数，Number of people grabbing red packets
packetnum = 100;    % 红包的总金额，Total amount of red packets
roundnum = 10000;   % 轮数越高越贴近实际概率（但需要花费更多时间和性能），The higher the number of rounds, the closer to the actual probability (but it will take more time and performance)
for i =1:1:roundnum
    temp = allget(packetnum,peoplenum);
    data(1:length(temp),i) = temp;
end
for i = 1:1:size(data,1)
    zdata(1,i)=mean(data(i,:));
    % 计算稳定性系数（消除了期望对方差量纲的影响，数值在0、1之间，数值越低越稳定）
    % Calculate the stability coefficient (eliminates the influence of expectation on the variance scale, with values between 0 and 1, the lower the value, the more stable)
    % 计算方法：期望的平方÷(期望的平方+方差)，Calculation method: square of the expectation ÷ (square of the expectation + variance)
    zdata(2,i)=(mean(data(i,:)))^2/((mean(data(i,:)))^2+var(data(i,:)));
end
figure
plot(zdata(1,:),'bo');hold on
plot([0 peoplenum+1],[packetnum/peoplenum packetnum/peoplenum],'--r')
title("期望与第几个拆开红包的关系");xlabel("第x个拆开");ylabel("金额期望（模拟值）");
title("Expectation and the Order of Opening Red Packets");xlabel("Order of opening");ylabel("Amount Expectation (Simulated Value)");
xlim([0 peoplenum+1]);ylim([0 packetnum])
figure
% 此图像可以通过点的密度直观看出各金额红包的多少，This graph can intuitively show the number of red packets with different amounts through the density of points
plot(sort(zdata(1,:)),'ro')
title("金额分布");xlabel("红包（已升序排列）");ylabel("金额");
title("Distribution of Amounts");xlabel("Red packets (sorted in ascending order)");ylabel("Amount");
figure
plot(zdata(2,:),'bo')
title("稳定性系数与第几个拆开红包的关系");xlabel("第x个拆开");ylabel("稳定性系数");
title("Stability Coefficient and the Order of Opening Red Packets");xlabel("Order of opening");ylabel("Stability Coefficient");
zdata = num2str(zdata)% 输出zdata，第一行为均值（模拟期望），第二行为稳定性系数，Output zdata, the first row is the mean (simulated expectation), the second row is the stability coefficient
% 计算不超过均值上下20%的红包频率，Calculate the frequency of red packets not exceeding ±20% of the mean
for i = 1:1:size(data,1)
    m = mean(data(i,:));
    n = 0;
    for j = 1:1:size(data,2)
        if data(i,j)>0.8*m && data(i,j)<1.2*m
            n=n+1;
        end
    end
    p(i)=n/size(data,2);
end
figure
plot(p,'or')
title("不超过均值上下20%的红包频率与第几个拆开红包的关系");xlabel("第x个拆开");ylabel("不超过均值上下20%的红包频率");
title("Frequency of Red Packets within ±20% of the Mean and the Order of Opening");xlabel("Order of opening");ylabel("Frequency within ±20% of the Mean");
% 计算不超过均值上下80%的红包频率，Calculate the frequency of red packets not exceeding ±80% of the mean
for i = 1:1:size(data,1)
    m = mean(data(i,:));
    n1 = 0;
    n2 = 0;
    for j = 1:1:size(data,2)
        if data(i,j)>0.2*m
            n1=n1+1;
        end
        if data(i,j)<1.8*m
            n2=n2+1;
        end
    end
    p(i)=n1/size(data,2);
    q(i)=n2/size(data,2);
end
figure
% 此图像蓝色为不超过180%的红包频率，红色为不低于20%的红包频率
% This graph shows the frequency of red packets not exceeding 180% of the mean in blue and not less than 20% of the mean in red
plot(p,'or');hold on;plot(q,'ob')
title("不超过均值上下80%的红包频率与第几个拆开红包的关系");xlabel("第x个拆开");ylabel("不超过均值上下80%的红包频率");
title("Frequency of Red Packets within ±80% of the Mean and the Order of Opening");xlabel("Order of opening");ylabel("Frequency within ±80% of the Mean");

% 函数：模拟一个红包完整抢完的数据，Function: Simulate the complete data of a red packet being grabbed
function gmoney = allget(total,people)
for i = 1:1:people-1
    money = oneget(total,people-i+1);
    total = total - money;
    gmoney(i) = money;
end
gmoney(people)=total;
end
% 函数：计算一次抢到的金额，使用二倍均值法，Function: Calculate the amount grabbed in one attempt, using the double mean method
function gmoney = oneget(total,people)
r = rand();
gmoney = r*total/people*2;
gmoney = ceil(gmoney*100)/100;
end
