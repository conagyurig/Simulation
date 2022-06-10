
clear all;
close all;

sample = zeros(128,128);
%sets the number of pixels to be scanned in the sample



size1 = size(sample);
sizex = size1(1);
sizey = size1(2);
for i = 1:128;
    for j = 1:128;
    x = randi([0 10000], 1, 1);
    if x > 9990;
        sample(i,j) = 1;
    end
    end
end
se = strel('disk',12,4);
samplelarge = imdilate(sample, se);
se = strel('disk',4,4);
samplesmall = imdilate(sample, se);
for i = 1:128;
    for j = 1:128;
    x = randi([0 10000], 1, 1);
       if samplesmall(i,j) == 1;
           sample(i,j) = 1;
       end
       if x>9998 && samplelarge(i,j) == 1
           sample(i,j) = 1;
           %can speed up if random number generated only if samplelarge = 1
       end
    end
end
se = strel('disk',6,4);
sample = imdilate(sample, se);
%section above generates the tumour like sample distribution



figure()
image(sample,'CDataMapping','scaled')
%view a distribution
%%
%run zone exclusion algorithm
quada = [128,128,1,1];
%ans = scan(sample,quad);
time = 0
set = [0]
store_density = []
[set,time] = recurs(sample, quada, set,time);
density = (sum(sample,'All')/(128*128))*100;
scantime = 128*128;
efficiency = scantime/time
store = [efficiency]
store_density = [store_density density]
for i = 1:50
    time = 0;
    set = [0];
    sample = gen_sample(128);
    [set,time] = recurs(sample, quada, set,time);
    efficiency = scantime/time
    density = (sum(sample,'All')/(128*128))*100;
    store = [store efficiency];
    store_density = [store_density density];
end
for i = 1:50
    time = 0;
    set = [0];
    sample = gen_sample2(128);
    [set,time] = recurs(sample, quada, set,time);
    efficiency = scantime/time
    density = (sum(sample,'All')/(128*128))*100;
    store = [store efficiency];
    store_density = [store_density density];
end
for i = 1:50
    time = 0;
    set = [0];
    sample = gen_sample3(128);
    [set,time] = recurs(sample, quada, set,time);
    efficiency = scantime/time
    density = (sum(sample,'All')/(128*128))*100;
    store = [store efficiency];
    store_density = [store_density density];
end
for i = 1:50
    time = 0;
    set = [0];
    sample = gen_sample4(128);
    [set,time] = recurs(sample, quada, set,time);
    efficiency = scantime/time
    density = (sum(sample,'All')/(128*128))*100;
    store = [store efficiency];
    store_density = [store_density density];
end
for i = 1:50
    time = 0;
    set = [0];
    sample = gen_sample5(128);
    [set,time] = recurs(sample, quada, set,time);
    efficiency = scantime/time
    density = (sum(sample,'All')/(128*128))*100;
    store = [store efficiency];
    store_density = [store_density density];
end
for i = 1:50
    time = 0;
    set = [0];
    sample = gen_sample6(128);
    [set,time] = recurs(sample, quada, set,time);
    efficiency = scantime/time
    density = (sum(sample,'All')/(128*128))*100;
    store = [store efficiency];
    store_density = [store_density density];
end
output = zeros (128,128);
size2 = size(set);


%figure()
%image(output,'CDataMapping','scaled')
%colorbar
efficiency = scantime/time
   
scatter(store_density,store)

%%
clear f
stD = store_density'
st = store'
ft = fittype('-log(t) + b','indep','t')
f =fit(stD, st,ft)
figure
plot(f)
hold on
scatter(store_density,store)





