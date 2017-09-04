function F = evaluation_quadraticForm(state)
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

% eva = zeros(Ntask,Ndom);
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
        for k = 1:Nj
%             worker1 = Lj{i}.worker_i;
            vote1 = Lj{i}.vote;
            c1 = Lj{i}.confidence;
%             worker2 = Lj{k}.worker_i;
            vote2 = Lj{k}.vote;
            c2 = Lj{k}.confidence; 
            F(task_j) = F(task_j) + Specificity_r(vote1)*c1*isParent(vote1,vote2)*Specificity_r(vote2)*c2;
        end
    end
    
end



end

