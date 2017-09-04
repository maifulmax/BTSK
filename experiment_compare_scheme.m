clear;
inferMethodList = [];
inferMethodList{1} = 'inference_MV';
inferMethodList{2} = 'inference_MWW';
inferMethodList{3} = 'inference_MWK';
inferMethodList{4} = 'inference_MWK_plus';
inferMethodList{5} = 'inference_confidence';
inferMethodList{6} = 'inference_pro_full';

meanRedun = 10;
maxRedun = 15;
minRedun = 5;
results_uniform = uniformScheme( inferMethodList, meanRedun);
results_random = RandomScheme( inferMethodList, meanRedun, maxRedun, minRedun);
results_my_Sweight= myScheme( inferMethodList,'evaluation_Sweight', meanRedun, maxRedun, minRedun);
results_my_Cweight= myScheme( inferMethodList,'evaluation_Cweight', meanRedun, maxRedun, minRedun);
results_my_SCweight= myScheme( inferMethodList,'evaluation_SCweight', meanRedun, maxRedun, minRedun);
results_my_quadratic= myScheme( inferMethodList,'evaluation_quadraticForm', meanRedun, maxRedun, minRedun);


A = cell(19,8);
A{1,1} = 'Inference Method';
A{1,2} = 'measurement';
A{1,3} ='Uniform';
A{1,4} = 'Random';
A{1,5} = 'S-weight';
A{1,6} = 'C-weight';
A{1,7} = 'SC-weight';
A{1,8} = 'quadratic';
for i = 1:6
    A{3*i-1,1} = inferMethodList{i};
    
    A{3*i-1,2} = 'accuracy';
    A{3*i,2} = 'coherence';
    A{3*i+1,2} = 'hitRate';
    
    A{3*i-1,3} = results_uniform.accuracy(i);
    A{3*i,3} = results_uniform.coherence(i);
    A{3*i+1,3} = results_uniform.hitRate(i);
    
    A{3*i-1,4} = (results_random.accuracy(i)-results_uniform.accuracy(i))/results_uniform.accuracy(i);
    A{3*i,4} = (results_random.coherence(i)-results_uniform.coherence(i))/results_uniform.coherence(i);
    A{3*i+1,4} = (results_random.hitRate(i)-results_uniform.hitRate(i))/results_uniform.hitRate(i);

    A{3*i-1,5} = (results_my_Sweight.accuracy(i)-results_uniform.accuracy(i))/results_uniform.accuracy(i);
    A{3*i,5} = (results_my_Sweight.coherence(i)-results_uniform.coherence(i))/results_uniform.coherence(i);
    A{3*i+1,5} = (results_my_Sweight.hitRate(i)-results_uniform.hitRate(i))/results_uniform.hitRate(i);
    
    A{3*i-1,6} = (results_my_Cweight.accuracy(i)-results_uniform.accuracy(i))/results_uniform.accuracy(i);
    A{3*i,6} = (results_my_Cweight.coherence(i)-results_uniform.coherence(i))/results_uniform.coherence(i);
    A{3*i+1,6} = (results_my_Cweight.hitRate(i)-results_uniform.hitRate(i))/results_uniform.hitRate(i);
 
    A{3*i-1,7} = (results_my_SCweight.accuracy(i)-results_uniform.accuracy(i))/results_uniform.accuracy(i);
    A{3*i,7} = (results_my_SCweight.coherence(i)-results_uniform.coherence(i))/results_uniform.coherence(i);
    A{3*i+1,7} = (results_my_SCweight.hitRate(i)-results_uniform.hitRate(i))/results_uniform.hitRate(i);

    A{3*i-1,8} = (results_my_quadratic.accuracy(i)-results_uniform.accuracy(i))/results_uniform.accuracy(i);
    A{3*i,8} = (results_my_quadratic.coherence(i)-results_uniform.coherence(i))/results_uniform.coherence(i);
    A{3*i+1,8} = (results_my_quadratic.hitRate(i)-results_uniform.hitRate(i))/results_uniform.hitRate(i);
end

xlswrite('experiment_compare_scheme_6.xls',A);

