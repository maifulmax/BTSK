function results = RandomScheme( inferMethodList, meanRedun, maxRedun, minRedun)
randomTimes = 10;
load Data3.mat
load GroundTruth.mat
Nmethods = length(inferMethodList);
results = [];
Ntask = 984;
maxNworker = 500;
Ndom = 149;
Budget = Ntask*meanRedun;
budget = Budget;
accuracySet = zeros(Nmethods,randomTimes);
coherenceSet = zeros(Nmethods,randomTimes);
hitRateSet = zeros(Nmethods,randomTimes);

for time = 1:randomTimes
    state = initialState(budget,Ntask,maxNworker,Ndom);
    lastPoint = oneTry(Budget,Ntask,maxRedun,minRedun);
    state = inputData(Data3,lastPoint,state);
    
    
    for m  = 1:Nmethods
        inference = str2func(inferMethodList{m});
        r = inference(state);
        fb = feedback(r.ansR,GroundTruth);
        accuracySet(m,time) = fb.accuracy;
        coherenceSet(m,time) = fb.coherence;
        hitRateSet(m,time) = fb.hitRate;
    end
end
results.method = inferMethodList;
results.accuracy = mean(accuracySet,2);
results.coherence = mean(coherenceSet,2);
results.hitRate = mean(hitRateSet,2);
end


function lastPoint = oneTry(Budget,Ntask,maxRedun,minRedun)

lastPoint = ones(1,Ntask)*minRedun;
budget = Budget- Ntask*minRedun;

while (budget>0)
    tem = randsrc(1,1,1:Ntask);
    if lastPoint(tem) < maxRedun;
        lastPoint(tem) = lastPoint(tem) + 1;
        budget = budget - 1;
    end
end

end
function newState = inputData(Data,lastPoint,state)

%get state
L = state.L;
confidence = state.confidence;
Ntask = state.Ntask;
newState = state;


for task_j = 1:Ntask
    for redun = 1:lastPoint(task_j)
        worker_i = Data{task_j,redun}.WorkerIdx;
        vote = Data{task_j,redun}.ResponseId;
        L(task_j,worker_i) = vote;
        c = Data{task_j,redun}.Confidence;
        confidence(task_j,worker_i) = (c+1)/5;
    end
end

newState.L = L;
newState.confidence = confidence;


end

