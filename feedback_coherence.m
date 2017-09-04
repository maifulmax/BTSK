function result = feedback_coherence(ansR, GroundTruth )
t =tree();


N = length(ansR);
flag = zeros(1,N);
for task_j = 1:N
    if t.isParent(ansR(task_j),GroundTruth(task_j))
        flag(task_j) = t.getSpecificity(ansR(task_j))/t.getSpecificity(GroundTruth(task_j));
    end
end
result = sum(flag)/N;


end

