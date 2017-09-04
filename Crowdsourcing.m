function iterData = Crowdsourcing(Data,iterTask, point)
Ntem = length(iterTask);
iterData = cell(1,Ntem);
for j = 1:Ntem
    task_j = iterTask(j);
    iterData{j} = Data{task_j,point(task_j)};
end
end
