function F = evaluation_commonParent(state)
L = state.L;
Ntask = state.Ntask;
% maxNworker = state.maxNworker;
Ndom = state.Ndom;
Specificity_r = state.Specificity_r;
% isParent  = state.isParent;
% isLeafNode = state.isLeafNode;
commonParent = state.commonParent;
confidence = state.confidence;
% confidence = ones(Ntask,maxNworker);
eva = zeros(Ntask,Ndom);
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
        for k = i:Nj
%             worker1 = Lj{i}.worker_i;
            vote1 = Lj{i}.vote;
            confidence1 = Lj{i}.confidence;
%             worker2 = Lj{k}.worker_i;
            vote2 = Lj{k}.vote;
            confidence2 = Lj{k}.confidence;
            vote  = commonParent(vote1,vote2);
            weight = (confidence1+confidence2)/2;
            eva(task_j,vote) = eva(task_j,vote) + weight;
        end
    end
%     eva(task_j,:) = eva(task_j,:)/sum(eva(task_j,:));
%     eva(task_j,:) = eva(task_j,:)/Nj;
    S = 0;
    for dom_g  = 1:Ndom
        S = S + eva(task_j,dom_g)*Specificity_r(dom_g);
    end
    F(task_j) = S;
end



end

