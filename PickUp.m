function [newState, iterTask] = PickUp( state, F, range, maxRedun)

newState = state;
budget = state.budget;
Ntask = state.Ntask;
point = state.point;

Nrange = round(range*Ntask);
Nrange = max(1,Nrange);
Valid =(point<maxRedun);
Nvalid = sum(Valid);

if budget<Nrange
    Nrange = budget;
elseif budget <= 0;
    iterTask = [];
    return;
end
Nrange = min(Nvalid,Nrange);
[~,I] = sort(F);
iterTask = zeros(1,Nrange);
Nget = 0;
for i = 1:length(F)
    task_j = I(i);
    if Nget>=Nrange
        break;
    elseif Valid(task_j)
        Nget = Nget+1;
        iterTask(Nget) = task_j;
        point(task_j) = point(task_j) + 1;
    end
end
budget = budget - Nrange;

newState.budget = budget;
newState.point = point;


end

