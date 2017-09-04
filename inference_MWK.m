function ansInfer = inference_MWK(state)

L = state.L;
load GroundTruth.mat
model = crowd_model(L,GroundTruth);
result_MWK = MajorityWithKnowledge(model,state.isParent);
ansInfer.ansR = result_MWK.ans_labels;
end


