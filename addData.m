function newState = addData(state,iterData)

%get state
L = state.L;
confidence = state.confidence;
Ntask = state.Ntask;
maxNworker = state.maxNworker;
newState = state;


WorkerIdxList = zeros(1,maxNworker);
LastWorkerIdx = 0;
TaskIdxList = zeros(1,Ntask);
LastTaskIdx = 0;
for  j = 1:length(iterData)
    task_j = iterData{j}.TaskIdx;
    worker_i = iterData{j}.WorkerIdx;
    vote = iterData{j}.ResponseId;
    L(task_j,worker_i) = vote;
    c = iterData{j}.Confidence;
    confidence(task_j,worker_i) = (c+1)/5;
    WorkerIdxList(worker_i) = 1;
    TaskIdxList(task_j) = 1;
    if worker_i > LastWorkerIdx
        LastWorkerIdx = worker_i;
    end
    if task_j > LastTaskIdx
        LastTaskIdx = task_j;
    end
end

%reform newState
newState.L = L;
newState.confidence = confidence;

end

