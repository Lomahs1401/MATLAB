function [vu]= calVU(ste_norm,zcr_norm, T)
    %ham calVU ket hop ste_norm va zcr_norm de tim vi tri voiced va
    %unvoiced
    % tham so : ste_norm = mang ste da duoc chuan hoa
    %                 zcr_norm = mang zcr da duoc chuan hoa
    %                 T : nguong chung cua ste va zcr
    % ham return mang vu, neu vu(i) = 1 -> tai frame i tin hieu la voiced va nguoc lai 
    for i=1:length(ste_norm)
        if(ste_norm(i) - zcr_norm(i) < T || ste_norm(i)<-0.8 )
            vu(i)=0;
        else vu(i)=1;
        end
    end
end