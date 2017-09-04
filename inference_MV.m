function ansInfer = inference_MV(state)

L = state.L;
load GroundTruth.mat
model = crowd_model(L,GroundTruth);
result_MV = MajorityVote(model);
ansInfer.ansR = result_MV.ans_labels;
end


