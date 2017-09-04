function result = feedback_hit(ansR, GroundTruth )
t =tree();


N = length(ansR);
flag = zeros(1,N);
for task_j = 1:N
    if t.isParent(ansR(task_j),GroundTruth(task_j))
        flag(task_j) = 1;
    end
end
result= sum(flag)/N;


end