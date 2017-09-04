clear;
inferMethodList = [];
inferMethodList{1} = 'inference_MV';
inferMethodList{2} = 'inference_MWW';
inferMethodList{3} = 'inference_MWK';
inferMethodList{4} = 'inference_MWK_plus';
inferMethodList{5} = 'inference_confidence';
inferMethodList{6} = 'inference_pro_full';

meanRedun = 10;
maxRedun = 15;
minRedun = 5;
results_uniform = uniformScheme( inferMethodList, meanRedun);

N  = length(inferMethodList);
meanRedunSet = 7:0.5:12;
result = [];
for i = 1:length(meanRedunSet)
    results_my_quadratic= myScheme( inferMethodList,'evaluation_quadraticForm', meanRedunSet(i), maxRedun, minRedun);
    for j =1:N
        result{j}.accuracy(i) = results_my_quadratic.accuracy(j);
        result{j}.coherence(i) = results_my_quadratic.coherence(j);
        result{j}.hitRate(i) = results_my_quadratic.hitRate(j);
    end
    meanRedunSet(i)
end

subplot(2,3,1)
plot(meanRedunSet,result{1}.accuracy,'-b*');
hold on;
plot(meanRedunSet,result{1}.coherence,'-rx');
plot(meanRedunSet,result{1}.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.accuracy(1),'--b');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.coherence(1),'--r');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.hitRate(1),'--g');
title('Performance of QF on MV');
xlabel('redundancy mean');

subplot(2,3,2)
plot(meanRedunSet,result{2}.accuracy,'-b*');
hold on;
plot(meanRedunSet,result{2}.coherence,'-rx');
plot(meanRedunSet,result{2}.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.accuracy(2),'--b');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.coherence(2),'--r');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.hitRate(2),'--g');
title('Performance of QF on MWW');
xlabel('redundancy mean');

subplot(2,3,3)
plot(meanRedunSet,result{3}.accuracy,'-b*');
hold on;
plot(meanRedunSet,result{3}.coherence,'-rx');
plot(meanRedunSet,result{3}.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.accuracy(3),'--b');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.coherence(3),'--r');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.hitRate(3),'--g');
title('Performance of QF on MWK');
xlabel('redundancy mean');

subplot(2,3,4)
plot(meanRedunSet,result{4}.accuracy,'-b*');
hold on;
plot(meanRedunSet,result{4}.coherence,'-rx');
plot(meanRedunSet,result{4}.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.accuracy(4),'--b');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.coherence(4),'--r');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.hitRate(4),'--g');
title('Performance of QF on MWK+');
xlabel('redundancy mean');

subplot(2,3,5)
plot(meanRedunSet,result{5}.accuracy,'-b*');
hold on;
plot(meanRedunSet,result{5}.coherence,'-rx');
plot(meanRedunSet,result{5}.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.accuracy(5),'--b');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.coherence(5),'--r');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.hitRate(5),'--g');
title('Performance of QF on MWC');
xlabel('redundancy mean');

subplot(2,3,6)
plot(meanRedunSet,result{6}.accuracy,'-b*');
hold on;
plot(meanRedunSet,result{6}.coherence,'-rx');
plot(meanRedunSet,result{6}.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.accuracy(6),'--b');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.coherence(6),'--r');
plot(meanRedunSet,ones(1,length(meanRedunSet))*results_uniform.hitRate(6),'--g');
title('Performance of QF on ProFull');
xlabel('redundancy mean');

