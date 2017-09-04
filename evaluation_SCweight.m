function F = evaluation_SCweight(state)
L = state.L;
confidence = state.confidence;
Ntask = state.Ntask;
% maxNworker = state.maxNworker;
Ndom = state.Ndom;
% Specificity_r = state.Specificity_r;
% isParent  = state.isParent;
% isLeafNode = state.isLeafNode;
isParent = state.isParent;
Specificity_r = state.Specificity_r;

F = ones(1,Ntask);
for task_j = 1:Ntask
    Nj = sum(L(task_j,:)>0);
    Lj = cell(1,Nj);
    workerSet = find(L(task_j,:)>0);
    for i = 1:Nj
        worker_i  = workerSet(i);
        Lj{i}.worker_i = worker_i;
        Lj{i}.vote = L(task_j,worker_i);
        Lj{i}.confidence = confidence(task_j,worker_i);
    end
    for i = 1:Nj
        vote = Lj{i}.vote;
        c = Lj{i}.confidence;
        F(task_j) = F(task_j) + Specificity_r(vote)*c;
    end
end



end

