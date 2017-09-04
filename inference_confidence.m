function ansInfer = inference_confidence(state)

% FeasibleRate = 0.9;

%get state
L = state.L;
Ntask = state.Ntask;
maxNworker = state.maxNworker;
Ndom = state.Ndom;
Specificity_r = state.Specificity_r;
isParent = state.isParent;
isLeafNode = state.isLeafNode;
% isLeafNode = ones(1,Ndom);
depth = state.depth;
hight = state.hight;
confidence = state.confidence;


P_r = zeros(Ntask,Ndom);
ansR = ones(1,Ntask);
for task_j = 1:Ntask
    for worker_i = 1:maxNworker
        vote = L(task_j,worker_i);
        c = confidence(task_j,worker_i);
        if vote > 0
            P_r(task_j,vote) = P_r(task_j,vote) + c*Specificity_r(vote);
%             P_r(task_j,vote) = P_r(task_j,vote) + c;
        end
    end
    [~,I] = max(P_r(task_j,:));
    ansR(task_j) = I;
end
ansInfer.P_r = P_r;
ansInfer.ansR = ansR;



end

