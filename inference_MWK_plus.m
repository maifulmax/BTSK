function ansInfer = inference_MWK_plus(state,varargin)
maxIter = 30;
TOL = 1e-6;
CONDUCTION_RATE = 0.8;
if nargin == 2
    CONDUCTION_RATE = varargin{1};
end


%get state
L = state.L;
Ntask = state.Ntask;
maxNworker = state.maxNworker;
Ndom = state.Ndom;
isParent = state.isParent;



Ability = ones(1,maxNworker);


err = Inf;
P_r = zeros(Ntask,Ndom);
for iter = 1:maxIter
    Ability_new = ones(1,maxNworker);
    if err < TOL
        break;
    end
    P_r = zeros(Ntask,Ndom);
    for task_j = 1:Ntask
        for worker_i = 1:maxNworker
            if L(task_j,worker_i) > 0
                vote = L(task_j,worker_i);
                P_r(task_j,vote) = P_r(task_j,vote) + Ability(worker_i); 
            end
        end
        P_r(task_j,:) = P_r(task_j,:)/sum(P_r(task_j,:));  
    end
    P_r_new =P_r*((isParent-eye(Ndom))*CONDUCTION_RATE+eye(Ndom));
    P_r_new = P_r_new.*(P_r>0);

    %uniform
    for task_j = 1:Ntask
        P_r(task_j,:) = P_r_new(task_j,:)/sum(P_r_new(task_j,:));
    end
    

    %update ability
    for worker_i = 1:maxNworker
        tem = 0;
        for task_j = 1:Ntask
            if L(task_j,worker_i) > 0
                vote = L(task_j,worker_i);
                tem = tem + P_r(task_j,vote);
            end
        end
        uni = sum(L(:,worker_i)>0);
        if uni > 0
            Ability_new(worker_i) = tem/sum(L(:,worker_i)>0);
        else
            Ability_new(worker_i) = 1;
        end
    end
    err = abs(Ability_new-Ability);
    Ability = Ability_new;
end

% aggregation
ansR = ones(1,Ntask);
for task_j = 1:Ntask
    max  = 0 ;
    maxIndex = [];
    for dom_g = 1:Ndom
        p = P_r(task_j,dom_g);
        if p > max
            maxIndex = dom_g;
            max = p;
        elseif p == max
            maxIndex = [maxIndex,dom_g];
        end
    end
    if ~isempty(maxIndex)
        ansR(task_j) = maxIndex(1);
    else
        ansR(task_j) = 1;
    end
    
end

% load GroundTruth.mat
% result = feedback(ansR,GroundTruth)

ansInfer.P_r = P_r;
ansInfer.ansR = ansR;
end

