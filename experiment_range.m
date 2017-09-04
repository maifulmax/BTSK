clear;
load Data3.mat
load GroundTruth.mat
rangeSet = 0.1:0.1:1;

Ntask = 984;
maxNworker = 500;
Ndom = 149;
meanRedun = 12;
maxRedun = 19;
minRedun = 5;

result_MWK_plus = rangePerformance(rangeSet,'inference_MWK_plus','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_confidence = rangePerformance(rangeSet,'inference_confidence','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_pro_full = rangePerformance(rangeSet,'inference_pro_full','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);

subplot(1,4,1)
plot(rangeSet,result_MWK_plus.accuracy,'-b*');
hold on;
plot(rangeSet,result_MWK_plus.coherence,'-rx');
plot(rangeSet,result_MWK_plus.hitRate,'-gs');
axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MWK+');
xlabel('range');

subplot(1,4,2)
plot(rangeSet,result_confidence.accuracy,'-b*');
hold on;
plot(rangeSet,result_confidence.coherence,'-rx');
plot(rangeSet,result_confidence.hitRate,'-gs');
axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MWC');
xlabel('range');


subplot(1,4,3)
plot(rangeSet,result_pro_full.accuracy,'-b*');
hold on;
plot(rangeSet,result_pro_full.coherence,'-rx');
plot(rangeSet,result_pro_full.hitRate,'-gs');
axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on ProFull');
xlabel('range');
subplot(1,4,4)
plot(rangeSet,result_pro_full.NiterSet,'-k');
hold on 
axis([0.1 1 0 60]);
title('Number of iterations');
xlabel('range');




saveas(gcf,'experiment_range.fig');

