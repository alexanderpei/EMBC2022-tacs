function [Zout, allZ, idxOut] = fn_cluster_perm_coh(coh1, coh2, freq1, freq2, nPerm, alpha, cfg) 

nTrial = size(freq1.powspctrm,1);

Z = (atanh(abs(coh2.cohspctrm)) - atanh(abs(coh1.cohspctrm))) ... 
    /sqrt((1/(coh1.dof(1)-2))+(1/(coh2.dof(1)-2))); 

h = Z > norminv(1-alpha);
h = [0 h 0];
Z = [0 Z 0];

idxOut = fn_find_cluster_idx(h);
Zout = sum(Z(idxOut));

% Do the permutation test
allCoh = cat(1, freq1.crsspctrm, freq2.crsspctrm);
allZ = zeros(1, nPerm);

for idxPerm = 1:nPerm
    randIdx = randperm(nTrial*2);
    freq1.crsspctrm = allCoh(randIdx(1:nTrial),:,:);
    freq2.crsspctrm = allCoh(randIdx(nTrial+1:nTrial*2),:,:);
    
    tempCoh1 = ft_connectivityanalysis(cfg, freq1);
    tempCoh2 = ft_connectivityanalysis(cfg, freq2);
    
    Z = (atanh(abs(tempCoh2.cohspctrm)) - atanh(abs(tempCoh1.cohspctrm))) ... 
        /sqrt((1/(tempCoh1.dof(1)-2))+(1/(tempCoh2.dof(1)-2))); 

    h = Z > norminv(1-alpha);
    h = [0 h 0];
    Z = [0 Z 0];
    idxClust = fn_find_cluster_idx(h);
    allZ(idxPerm) = sum(Z(idxClust));
    
end