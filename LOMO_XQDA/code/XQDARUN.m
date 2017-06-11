function [dist,classLabelGal2, classLabelProb2]=XQDARUN(galFea, probFea,galClassLabel,probClassLabel, iter, options)
                        
    numMatches=size(galFea,1);
    p = randperm(numMatches);
    galFea1 = galFea(p(1:int16(numMatches/2)), : );
    probFea1 = probFea(p(1:int16(numMatches/2)), : );
    classLabelGal1=galClassLabel(p(1:int16(numMatches/2)));
    classLabelProb1=probClassLabel(p(1:int16(numMatches/2)));


    t0 = tic;
    xqdaOptions.qdaDims=size(galFea1,2);
    xqdaOptions.verboes=true;
                       
    [W, M] = XQDA(galFea1, probFea1, classLabelGal1', classLabelProb1', xqdaOptions);
    fprintf('The computed subspace dimension %d \n', size(W,2));
    
    clear galFea1 probFea1
    trainTime = toc(t0);
    
    %Squeeze removes singleton dimensions
    galFea2 = galFea(p(int16(numMatches/2)+1 : end), : );
    probFea2 = probFea(p(int16(numMatches/2)+1 : end), : );
    classLabelGal2=galClassLabel(p(int16(numMatches/2)+1 : end));
    classLabelProb2=probClassLabel(p(int16(numMatches/2)+1 : end));
                        
                        
    t0 = tic;
    %Produces score matrix of all distances between probe
    %and gallery images
    dist = MahDist(M, galFea2 * W, probFea2 * W);
    clear galFea2 probFea2 M W
    matchTime = toc(t0);      

    fprintf('Fold %d: ', iter);
    fprintf('Training time: %.3g seconds. ', trainTime);    
    fprintf('Matching time: %.3g seconds.\n', matchTime); 
    
end