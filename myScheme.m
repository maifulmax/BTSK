function results = myScheme( inferMethodList,evaluationMethod, meanRedun, maxRedun, minRedun)
range = 0.5;

load Data3.mat
load GroundTruth.mat
Nmethods = length(inferMethodList);
results = [];
Ntask = 984;
maxNworker = 500;
Ndom = 149;
Budget = Ntask*meanRedun;

evaluation = str2func(evaluationMethod);
budget = Budget;
state = initialState(budget,Ntask,maxNworker,Ndom);
F = zeros(1,Ntask);

Niter = 1;
for i = 1:minRedun
	[state,iterTask]=PickUp(state,F,1,maxRedun);
	iterData = Crowdsourcing(Data3,iterTask,state.point);
	state = addData(state,iterData);
end

budget = state.budget;
F = evaluation(state);
while budget>0
	[state,iterTask]=PickUp(state,F,range,maxRedun); 
    iterData = Crowdsourcing(Data3,iterTask,state.point);
    state=addData(state,iterData);
    F = evaluation(state);
    Niter  = Niter+1;
	budget = state.budget;
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

results.inferMethod = inferMethodList;
results.evaluationMethod = evaluationMethod;
results.Niter =Niter;
results.accuracy = accuracy;
results.coherence = coherence;
results.hitRate = hitRate;


end

