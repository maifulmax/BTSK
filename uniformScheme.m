function results = uniformScheme( inferMethodList, meanRedun)

load Data3.mat
load GroundTruth.mat
Nmethods = length(inferMethodList);
results = [];
Ntask = 984;
maxNworker = 500;
Ndom = 149;
Budget = Ntask*meanRedun;
budget = Budget;

state = initialState(budget,Ntask,maxNworker,Ndom);
for i = 1:meanRedun
    point = ones(1,Ntask)*i;
	iterData = Crowdsourcing(Data3,1:Ntask,point);
	state = addData(state,iterData);
end



accuracy = zeros(1,Nmethods);
coherence = zeros(1,Nmethods);
hitRate = zeros(1,Nmethods);
for m = 1:Nmethods
    inference = str2func(inferMethodList{m});
    r = inference(state);
    fb = feedback(r.ansR,GroundTruth);
    accuracy(m) = fb.accuracy;
    coherence(m) = fb.coherence;
    hitRate(m) = fb.hitRate;
end

results.method = inferMethodList;
results.accuracy = accuracy;
results.coherence = coherence;
results.hitRate = hitRate;




end

% function newState = inputData(Data,lastPoint,state)
% 
% %get state
% L = state.L;
% confidence = state.confidence;
% Ntask = state.Ntask;
% newState = state;
% 
% 
% for task_j = 1:Ntask
%     for redun = 1:lastPoint(task_j)
%         worker_i = Data{task_j,redun}.TaskIdx;
%         vote = Data{task_j,redun}.ResponseId;
%         L(task_j,worker_i) = vote;
%         c = Data{task_j,redun}.Confidence;
%         confidence(task_j,worker_i) = (c+1)/5;
%     end
% end
% 
% newState.L = L;
% newState.confidence = confidence;
% 
% 
% end