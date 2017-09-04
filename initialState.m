function state = initialState(budget, Ntask, maxNworker, Ndom )

state.L = zeros(Ntask, maxNworker);
state.confidence = zeros(Ntask,maxNworker);
state.Ntask = Ntask;
state.maxNworker = maxNworker;
state.Ndom = Ndom;
state.Specificity_j = zeros(1,Ntask);
state.budget = budget;
state.point = zeros(1,Ntask);
t = tree();
Specificity_r = zeros(1,Ndom);
for dom_g = 1:Ndom
    Specificity_r(dom_g) = t.getSpecificity(dom_g); 
end
state.Specificity_r = Specificity_r;
isParent = zeros(Ndom,Ndom);
isLeafNode = zeros(1,Ndom);
depth = ones(1,Ndom);
hight = zeros(1,Ndom);
commonParent = ones(Ndom,Ndom);
for dom_g = 1:Ndom
    for dom_h = 1:Ndom
        isParent(dom_g,dom_h) = t.isParent(dom_g,dom_h);
        commonParent(dom_g,dom_h) = t.getCommonParent(dom_g,dom_h);
    end
    if t.isLeafNode(dom_g);
        isLeafNode(dom_g) = true;
    else
        isLeafNode(dom_g) = false;
    end
    depth(dom_g) = t.getDepth(dom_g);
    hight(dom_g) = t.getHight(dom_g);
end
state.isParent = isParent;
state.isLeafNode = isLeafNode;
state.depth = depth;
state.hight = hight;
state.commonParent = commonParent;
end

