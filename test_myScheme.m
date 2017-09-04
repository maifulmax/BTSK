clear;

Ntask = 984;
maxNworker = 500;
Ndom = 149;
meanRedun = 10;
maxRedun = 15;
minRedun = 5;
range = 0.5;
infer_method = 'inference_MWW';
evaluation_method = 'evaluation_weight';



Budget = Ntask*meanRedun;
inference = str2func(infer_method);
evaluation = str2func(evaluation_method);
budget = Budget;
state = initialState(budget,Ntask,maxNworker,Ndom);
load Data3.mat
load GroundTruth.mat
Niter = 1;
F = zeros(1,Ntask);

for i = 1:minRedun
	[state,iterTask]=PickUp(state,F,1,maxRedun);
	iterData = Crowdsourcing(Data3,iterTask,state.point);
	state = addData(state,iterData);
end

budget = state.budget;
F = evaluation(state);
iterData = [];
while budget>0
	[state,iterTask]=PickUp(state,F,range,maxRedun); 
    iterData = Crowdsourcing(Data3,iterTask,state.point);
    state=addData(state,iterData);
    F = evaluation(state);
    Niter  = Niter+1;
	budget = state.budget;
end

ansInfer = inference(state);
infer_method
result = feedback(ansInfer.ansR,GroundTruth)


% no scheme
state_compare = initialState(Budget,Ntask,maxNworker,Ndom);
for i = 1:meanRedun
    point = ones(1,Ntask)*i;
	iterData = Crowdsourcing(Data3,1:Ntask,point);
	state_compare = addData(state_compare,iterData);
end
ansInfer_compare = inference(state_compare);
result_noScheme = feedback(ansInfer_compare.ansR,GroundTruth)

