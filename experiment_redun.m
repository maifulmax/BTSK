clear;
inferMethodList = [];
inferMethodList{1} = 'inference_MV';
inferMethodList{2} = 'inference_MWW';
inferMethodList{3} = 'inference_MWK';
inferMethodList{4} = 'inference_MWK_plus';
inferMethodList{5} = 'inference_confidence';
inferMethodList{6} = 'inference_pro_full';
redunSet = 5:19;


N = length(redunSet);
m = length(inferMethodList);
performance = cell(1,m);
time = 1;
for meanRedun = redunSet
    results_uniform = uniformScheme( inferMethodList, meanRedun);
    for i = 1:m
        performance{i}.accuracy(time) = results_uniform.accuracy(i);
        performance{i}.coherence(time) = results_uniform.coherence(i);
        performance{i}.hitRate(time) = results_uniform.hitRate(i);
    end
    time = time + 1;
end

subplot(1,3,1)
plot(redunSet,performance{1}.accuracy,'-b*');
hold on;
plot(redunSet,performance{2}.accuracy,'-rx');
plot(redunSet,performance{3}.accuracy,'-gs');
plot(redunSet,performance{4}.accuracy,'-kd');
plot(redunSet,performance{5}.accuracy,'-yp');
plot(redunSet,performance{6}.accuracy,'-m+');
legend('MV','MWW','MWK','MWK+','MWC','ProFull');
title('Accuracy performance');
xlabel('redundancy');


subplot(1,3,2)
plot(redunSet,performance{1}.coherence,'-b*');
hold on;
plot(redunSet,performance{2}.coherence,'-rx');
plot(redunSet,performance{3}.coherence,'-gs');
plot(redunSet,performance{4}.coherence,'-kd');
plot(redunSet,performance{5}.coherence,'-yp');
plot(redunSet,performance{6}.coherence,'-m+');
legend('MV','MWW','MWK','MWK+','MWC','ProFull');
title('Coherence performance');
xlabel('redundancy');

subplot(1,3,3)
plot(redunSet,performance{1}.hitRate,'-b*');
hold on;
plot(redunSet,performance{2}.hitRate,'-rx');
plot(redunSet,performance{3}.hitRate,'-gs');
plot(redunSet,performance{4}.hitRate,'-kd');
plot(redunSet,performance{5}.hitRate,'-yp');
plot(redunSet,performance{6}.hitRate,'-m+');
legend('MV','MWW','MWK','MWK+','MWC','ProFull');
title('HitRate performance');
xlabel('redundancy');

saveas(gcf,'experiment_redun.fig');


