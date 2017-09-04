function ansInfer = inference_pro_full(state,varargin)
initial_pi = 0.5;
FEASIBLE_RATE = 0.5;
if nargin == 2
    FEASIBLE_RATE = varargin{1};
end

maxIter = 30;
TOL = 1e-6;
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



pi= ones(1,maxNworker)*initial_pi;

% Pass = P_r;
error = Inf;
for iter = 1:maxIter
    if error <TOL
        break;
    else
        P_r = Estep(pi,L,isParent,isLeafNode,depth,Ntask,maxNworker);
        pi_new = Mstep(P_r,L,isParent,initial_pi,Ntask,maxNworker);
        error = sum(abs(pi_new-pi))/sum(pi);
        pi = pi_new;
    end
%     iter
%     error
end
P_r = Estep(pi,L,isParent,isLeafNode,depth,Ntask,maxNworker);


ansR = ones(1,Ntask);
pass = P_r*isParent';
for task_j = 1:Ntask
    for h = 0:6
        [pro, I] = max(pass(task_j,:).*(hight==h));
        if pro>= FEASIBLE_RATE
            ansR(task_j) = I;
            break;
        end
    end
end
% load GroundTruth.mat
% result = feedback(ansR,GroundTruth)


ansInfer.P_r = P_r;
ansInfer.ansR = ansR;
end

function P_r = Estep(pi,L,isParent,isLeafNode,depth,Ntask,maxNworker)
Ndom = size(isParent,1);
P_r = ones(Ntask,Ndom);
for task_j = 1:Ntask
    for worker_i = 1:maxNworker
        vote = L(task_j,worker_i);
        if vote>0
            part = zeros(1,Ndom);
            for dom_g = 1:Ndom
                if isParent(vote,dom_g)
                    part(dom_g) = pi(worker_i)/depth(dom_g);
                else
                    part(dom_g) = (1-pi(worker_i))/(Ndom-depth(dom_g));
                end
            end
            P_r(task_j,:) = P_r(task_j,:).*part.*isLeafNode;
%             Idx1 = isParent(vote,:).*isLeafNode;
%             Idx2 = (~isParent(vote,:)).*isLeafNode;
%             part1 = Idx1*pi(worker_i);
%             part2 = Idx2*(1-pi(worker_i));
%             P_r(task_j,:) = P_r(task_j,:).*(part1 + part2).*isLeafNode;

        end
    end
    P_r(task_j,:) = P_r(task_j,:)/sum(P_r(task_j,:));
end
end

function pi = Mstep(P_r,L,isParent,initial_pi,Ntask,maxNworker)
% Ndom = length(isLeafNode);
pi = ones(1,maxNworker)*initial_pi;
Idx = (L>0);
for worker_i = 1:maxNworker
    N = sum(Idx(:,worker_i));
    tem = 0;
    for task_j = 1:Ntask
        vote = L(task_j,worker_i);
        if vote>0
            tem = tem + sum(isParent(vote,:).*P_r(task_j,:));
        end
    end
    if N>0
        pi(worker_i) = tem/N;
    end
end
end

