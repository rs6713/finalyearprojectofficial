%Input rows are the sentences, cols are the variabls
function sentenceVectors=extractPCA(sentences, sentenceIds, numDims)
    %idx=randperm(size(sentences,2));
    %newSize=min(10000,size(sentences,2));%Newsize necessary to reduce memory usage
    uniqSentenceIds=unique(sentenceIds);
    sw=0;
    for u=1:length(uniqSentenceIds)
        withinClassIdx=find(sentenceIds==uniqSentenceIds(u));
        sentencesIn=sentences(withinClassIdx,:);
        %for all dimensions within this class
        for d=1:size(sentencesIn,2)
            meany=mean(sentencesIn(:,d));
            sw=sw+(sentencesIn(:,d)-meany)*(sentencesIn(:,d)-meany).';  
        end
    end
    sb=0;
    for u= 1:length(uniqSentenceIds)
        withinClassIdx=find(sentenceIds==uniqSentenceIds(u));
        for i=1:length(widthinClassIdx)
            sWithin(u)=
        end
        
    end
    scatterIn
    
    meanS=mean(sentences,2);%col vector
    sentenceVector=bsxfun(@minus,sentences,meanS);
    covy=sentenceVector(:,idx(1:newSize)).'*sentenceVector(:,idx(1:newSize))/size(sentenceVector,1);
    [eigVecs, eigVals]=eig(covy);%eigVecs cols are eigenVectors
    eigVals=diag(eigVals);%col vector
    eigVals=eigVals.';
    [eigVals,i]=sort(eigVals,'descend');
    eigVecs(:,:)=eigVecs(:,i);
    eigVecs=eigVecs(:,1:numDims);
    
    for s= 1: size(sentences,1)
        for i=1: numDims
            temp= sentenceVector(s,idx(1:newSize))*eigVecs(:,i);
            sentenceVectors(s,i)= temp;
        end
    end
    
end