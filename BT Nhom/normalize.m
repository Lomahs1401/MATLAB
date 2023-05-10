function g = normalize(f, T)
    % chuẩn hóa hàm f với tham số thứ 2 là threshold
    % -> return hàm g nằm trong khoảng [0, 1] và T là trục hoành
    Nf = length(f);
    g = zeros(Nf, 1);
    fmax = max(f);
    fmin = min(f);

    for i= 1 : Nf
        if(f(i) >= T)
            g(i) = (f(i)-T)/(fmax-T);
        else
            g(i) = (f(i)-T)/(T-fmin);
        end
    end
end