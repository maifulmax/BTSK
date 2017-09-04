function result = feedback(ansR,GroundTruth)

result.accuracy = feedback_accuracy(ansR,GroundTruth);
result.coherence = feedback_coherence(ansR,GroundTruth);
result.hitRate  = feedback_hit(ansR,GroundTruth);

end