function result = rangePerformance(rangeSet,inferMethod,evaluationMethod, meanRedun, maxRedun, minRedun )
load Data3.mat
load GroundTruth.mat
inference = str2func(inferMethod);
evaluation = str2func(evaluationMethod);

Ntask = 984;
maxNworker = 500;
Ndom = 149;
Budget = Ntask*meanRedun;
resultSet = [];
NiterSet = [];
for range  = rangeSet
    state = initialState(Budget,Ntask,maxNworker,Ndom);

    % load GroundTruth.mat
    Niter = 1;
    F = zeros(1,Ntask);

    for i = 1:minRedun
        [state,iterTask]=PickUp(state,F,1,maxRedun);
        iterData = Crowdsourcing(Data3,iterTask,state.point);
        state=addData(state,iterData);
    end
    budget = state.budget;
    F = evaluation(state);
    iterData = [];
    while budget>0
        [state,iterTask]=PickUp(state,F,range,maxRedun); 
        iterData = Crowdsourcing(Data3,iterTask,state.point);
        state=addData(state,iterData);
        F = evaluation(state);
    %     result = feedback(state.P_r,GroundTruth)
        range
        Niter  = Niter+1
        budget = state.budget
    end
    %statistic
    state = inference(state);
    result_final = feedback(state.ansR,GroundTruth)
    resultSet = [resultSet, result_final];
    NiterSet = [NiterSet, Niter];
end

N = length(resultSet);
accuracy = zeros(1,N);
coherence = zeros(1,N);
hitRate = zeros(1,N);
for i = 1:N
    accuracy(i) = resultSet(i).accuracy;
    coherence(i) = resultSet(i).coherence;
    hitRate(i) = resultSet(i).hitRate;
end

result.inferMethod =inferMethod;
result.evaluationMethod = evaluationMethod;
result.rangeSet = rangeSet;
result.accuracy = accuracy;
result.coherence = coherence;
result.hitRate = hitRate;
result.NiterSet = NiterSet;

end

