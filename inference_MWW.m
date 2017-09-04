function ansInfer = inference_MWW(state)

L = state.L;
load GroundTruth.mat
model = crowd_model(L,GroundTruth);
result_MWW = MajorityWithWeight(model);
ansInfer.ansR = result_MWW.ans_labels;
end


