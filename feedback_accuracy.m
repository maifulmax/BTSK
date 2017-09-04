function result = feedback_accuracy(ansR,GroundTruth)

result = sum(~(ansR-GroundTruth))/length(ansR);

end

