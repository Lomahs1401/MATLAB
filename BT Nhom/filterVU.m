function [filter]= filterVU(data)
    % Ham filterVU loc du lieu bat thuong cua mang vu
    % tham so : data : du lieu dau vao (mang vu)
    % ham return mang filter la mang vu sau khi duoc filter
    
    % filter 11011
    for i=2:length(data)-1
        if(data(i) ~= data(i+1)) && (data(i) ~=data(i-1))
            data(i)= data(i-1);
        end
    end
    
    % filter 110011
    for i=2:length(data)-2
        if(data(i) == data(i+1)) && (data(i) ~=data(i-1)) &&(data(i) ~=data(i+2))
            data(i)= data(i-1);
            data(i+1)= data(i-1);
        end
    end
        filter=data;
end