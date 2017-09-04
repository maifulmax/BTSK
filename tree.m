classdef tree

    properties
        ParentList;
    end
    
    methods
        function obj = tree()
            load ParentList2.mat
            obj.ParentList = ParentList2;
        end
        
        function children = getChildren(obj,node)
            children = find(obj.ParentList==node);
        end
        
        function parents = getParents(obj,node)
            parents = node;
            while obj.ParentList(node) ~=0
                node = obj.ParentList(node);
                parents = [node,parents];
            end
        end
        
        function commonParent = getCommonParent(obj,node1,node2)
            parents1 = obj.getParents(node1);
            parents2 = obj.getParents(node2);
            N = min(length(parents1),length(parents2));
            commonParent = 0;
            for i = 1:N
                if parents1(i)==parents2(i)
                    commonParent = parents1(i);
                else
                    return;
                end
            end
        end
        
        function depth = getDepth(obj,node)
            parents = obj.getParents(node);
            depth = length(parents);
        end
        
        function hight = getHight(obj,node)
            children = obj.getChildren(node);
            if isempty(children)
                hight = 0;
            else
                hight = 0;
                for i = 1:length(children)
                    hight_i = obj.getHight(children(i));
                    if hight_i > hight
                        hight = hight_i;
                    end
                end
                hight = hight + 1;
            end
        end
        
        function Specificity = getSpecificity(obj,node)
            depth = obj.getDepth(node);
            hight = obj.getHight(node);
            Specificity = depth/(depth+hight);
        end
        
        function flag = isParent(obj,node1,node2)
            parents = obj.getParents(node2);
            flag = ismember(node1,parents);
        end
        
        function flag = isLeafNode(obj, node)
            children = obj.getChildren(node);
            if isempty(children)
                flag = true;
            else
                flag = false;
            end
        end
        
        
        
    end
    
end

