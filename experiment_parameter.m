clear

load Data3.mat
load GroundTruth.mat
%% 10 redundancy
Ntask = 984;
maxNworker = 500;
Ndom = 149;
meanRedun = 10;
maxRedun = 15;
minRedun = 5;
Budget = Ntask*meanRedun;
budget = Budget;

state = initialState(budget,Ntask,maxNworker,Ndom);
for i = 1:meanRedun
    point = ones(1,Ntask)*i;
	iterData = Crowdsourcing(Data3,1:Ntask,point);
	state = addData(state,iterData);
end



CONDUCTION_RATE_SET = 0:0.1:1;
N = length(CONDUCTION_RATE_SET);
result_MWK_plus.accuracy = zeros(1,N);
result_MWK_plus.coherence = zeros(1,N);
result_MWK_plus.hitRate = zeros(1,N);
for i = 1:N
    r = inference_MWK_plus(state,CONDUCTION_RATE_SET(i));
    fb = feedback(r.ansR,GroundTruth);
    result_MWK_plus.accuracy(i) = fb.accuracy;
    result_MWK_plus.coherence(i) = fb.coherence;
    result_MWK_plus.hitRate(i) = fb.hitRate; 
    MWK_puls_time = i
end

FEASIBLE_RATE_SET = 0:0.1:1;
N = length(FEASIBLE_RATE_SET);
result_pro_full.accuracy = zeros(1,N);
result_pro_full.coherence = zeros(1,N);
result_pro_full.hitRate = zeros(1,N);
for i = 1:N
    r = inference_pro_full(state,FEASIBLE_RATE_SET(i));
    fb = feedback(r.ansR,GroundTruth);
    result_pro_full.accuracy(i) = fb.accuracy;
    result_pro_full.coherence(i) = fb.coherence;
    result_pro_full.hitRate(i) = fb.hitRate;  
    pro_full_time = i
end

r = inference_MWK(state);
benchmark = feedback(r.ansR,GroundTruth);

subplot(1,2,1)
plot(CONDUCTION_RATE_SET,result_MWK_plus.accuracy,'-b*');
hold on;
grid on;
plot(CONDUCTION_RATE_SET,result_MWK_plus.coherence,'-rx');
plot(CONDUCTION_RATE_SET,result_MWK_plus.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.accuracy,'--b');
plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.coherence,'--r');
plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.hitRate,'--g');
title('MWK+ performance with 10 redundancy');
xlabel('CONDUCTION RATE');

subplot(1,2,2)
plot(FEASIBLE_RATE_SET,result_pro_full.accuracy,'-b*');
hold on;
grid on;
plot(FEASIBLE_RATE_SET,result_pro_full.coherence,'-rx');
plot(FEASIBLE_RATE_SET,result_pro_full.hitRate,'-gs');
legend('accracy','coherence','hitRate');
plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.accuracy,'--b');
plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.coherence,'--r');
plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.hitRate,'--g');
title('ProFull performance with 10 redundancy');
xlabel('PEASIBLE RATE');


% %%12 redundancy
% Ntask = 984;
% maxNworker = 500;
% Ndom = 149;
% meanRedun = 12;
% maxRedun = 19;
% minRedun = 5;
% Budget = Ntask*meanRedun;
% budget = Budget;
% 
% state = initialState(budget,Ntask,maxNworker,Ndom);
% for i = 1:meanRedun
%     point = ones(1,Ntask)*i;
% 	iterData = Crowdsourcing(Data3,1:Ntask,point);
% 	state = addData(state,iterData);
% end
% 
% 
% 
% CONDUCTION_RATE_SET = 0:0.1:1;
% N = length(CONDUCTION_RATE_SET);
% result_MWK_plus.accuracy = zeros(1,N);
% result_MWK_plus.coherence = zeros(1,N);
% result_MWK_plus.hitRate = zeros(1,N);
% for i = 1:N
%     r = inference_MWK_plus(state,CONDUCTION_RATE_SET(i));
%     fb = feedback(r.ansR,GroundTruth);
%     result_MWK_plus.accuracy(i) = fb.accuracy;
%     result_MWK_plus.coherence(i) = fb.coherence;
%     result_MWK_plus.hitRate(i) = fb.hitRate; 
%     MWK_puls_time = i
% end
% 
% FEASIBLE_RATE_SET = 0:0.1:1;
% N = length(FEASIBLE_RATE_SET);
% result_pro_full.accuracy = zeros(1,N);
% result_pro_full.coherence = zeros(1,N);
% result_pro_full.hitRate = zeros(1,N);
% for i = 1:N
%     r = inference_pro_full(state,FEASIBLE_RATE_SET(i));
%     fb = feedback(r.ansR,GroundTruth);
%     result_pro_full.accuracy(i) = fb.accuracy;
%     result_pro_full.coherence(i) = fb.coherence;
%     result_pro_full.hitRate(i) = fb.hitRate;  
%     pro_full_time = i
% end
% 
% r = inference_MWK(state);
% benchmark = feedback(r.ansR,GroundTruth);
% 
% subplot(1,4,2)
% plot(CONDUCTION_RATE_SET,result_MWK_plus.accuracy,'-b*');
% hold on;
% plot(CONDUCTION_RATE_SET,result_MWK_plus.coherence,'-rx');
% plot(CONDUCTION_RATE_SET,result_MWK_plus.hitRate,'-gs');
% legend('accracy','coherence','hitRate');
% plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.accuracy,'--b');
% plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.coherence,'--r');
% plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.hitRate,'--g');
% title('MWK+ performance with 12 redundancy');
% xlabel('CONDUCTION RATE');
% 
% subplot(1,4,4)
% plot(FEASIBLE_RATE_SET,result_pro_full.accuracy,'-b*');
% hold on;
% plot(FEASIBLE_RATE_SET,result_pro_full.coherence,'-rx');
% plot(FEASIBLE_RATE_SET,result_pro_full.hitRate,'-gs');
% legend('accracy','coherence','hitRate');
% plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.accuracy,'--b');
% plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.coherence,'--r');
% plot(CONDUCTION_RATE_SET,ones(1,length(CONDUCTION_RATE_SET))*benchmark.hitRate,'--g');
% title('ProFull performance with 12 redundancy');
% xlabel('PEASIBLE RATE');




