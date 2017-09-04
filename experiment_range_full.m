clear;
load Data3.mat
load GroundTruth.mat
rangeSet = 0.1:0.1:1;

Ntask = 984;
maxNworker = 500;
Ndom = 149;
meanRedun = 10;
maxRedun = 15;
minRedun = 5;
result_MV = rangePerformance(rangeSet,'inference_MV','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_MWW = rangePerformance(rangeSet,'inference_MWW','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_MWK = rangePerformance(rangeSet,'inference_MWK','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_MWK_plus = rangePerformance(rangeSet,'inference_MWK_plus','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_confidence = rangePerformance(rangeSet,'inference_confidence','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);
result_pro_full = rangePerformance(rangeSet,'inference_pro_full','evaluation_quadraticForm',meanRedun,maxRedun,minRedun);


subplot(2,4,1)
plot(rangeSet,result_MV.accuracy,'-b*');
hold on;
plot(rangeSet,result_MV.coherence,'-rx');
plot(rangeSet,result_MV.hitRate,'-gs');
% axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MV');
xlabel('range');

subplot(2,4,2)
plot(rangeSet,result_MWW.accuracy,'-b*');
hold on;
plot(rangeSet,result_MWW.coherence,'-rx');
plot(rangeSet,result_MWW.hitRate,'-gs');
% axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MWW');
xlabel('range');

subplot(2,4,3)
plot(rangeSet,result_MWK.accuracy,'-b*');
hold on;
plot(rangeSet,result_MWK.coherence,'-rx');
plot(rangeSet,result_MWK.hitRate,'-gs');
% axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MWK');
xlabel('range');


subplot(2,4,4)
plot(rangeSet,result_MWK_plus.accuracy,'-b*');
hold on;
plot(rangeSet,result_MWK_plus.coherence,'-rx');
plot(rangeSet,result_MWK_plus.hitRate,'-gs');
% axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MWK+');
xlabel('range');

subplot(2,4,5)
plot(rangeSet,result_confidence.accuracy,'-b*');
hold on;
plot(rangeSet,result_confidence.coherence,'-rx');
plot(rangeSet,result_confidence.hitRate,'-gs');
% axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on MWC');
xlabel('range');


subplot(2,4,6)
plot(rangeSet,result_pro_full.accuracy,'-b*');
hold on;
plot(rangeSet,result_pro_full.coherence,'-rx');
plot(rangeSet,result_pro_full.hitRate,'-gs');
% axis([0.1 1 0.34 0.48])
legend('accracy','coherence','hitRate');
title('Performance of QF on ProFull');
xlabel('range');
subplot(2,4,[7 8])
plot(rangeSet,result_pro_full.NiterSet,'-k');
hold on 
% axis([0.1 1 0 60]);
title('Number of iterations');
xlabel('range');




saveas(gcf,'experiment_range_full10.fig');

