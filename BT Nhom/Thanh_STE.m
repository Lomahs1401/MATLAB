    ChuanCuaThay = [0.45,0.81,1.53,1.85,2.69,2.86,3.78,4.15,4.84,5.14,5.58];
    [x,Fs] = audioread('TinHieuKiemThu\01MDA.wav');
    %1 frame 20 ms
    time = 20;
    % nguong chuan hoa
    
    % Fs là tan so lay mau
    % so mau cua 1 frame
    N = Fs.*time./1000; 
    Nguong = 0.01;
    %so frame cua x ung voi thoi gian time
    n = (length(x))/(N) ;

    % mảng thời gian thực ứng với mẫu
    for i= 1:length(x)
        thoiGianThuc(i) = 1./Fs*i;
    end

    ste = 0;
    for i =1:n
        ste = [ste,0];
    end
    
    m = 1;
    %Tinh STE
    for i = 1 : round(n) 
        for j = 1 : N
            ste(i) = ste(i) + x(m).^2;
            m = m+1;
            if (m>length(x))
                break;
            end
        end
    end
    
    % chuan hoa ham ste
    for i = 1: n
        ste_ChuanHoa(i) = ste(i)./(max(ste)-0);
    end
    
    %Thoi gian ung voi tung frame
    for i=1:n
        t(i) = i.*time./1000;
    end


    %chuan hoa ve 1 ham
    ChuanHoa = ste_ChuanHoa ;
 
    
    k=1;
    check = 0; %check la 0 khi unvoice la 1 khi voice
    matran =0;% luu gia tri t khi trung voi nguong
    if(ChuanHoa(i) >= Nguong)
        check = 1;
    end
    for i= 2:length(ChuanHoa)
        if(ChuanHoa(i) >= Nguong)
            if(check==0 )
                matran(k)=time*i/1000; 
                check = 1;
            end
        else
            if(check==1 )
                matran(k)=time*i/1000;   
                check = 0;
            end
        end
        k=k+1;
    end
    x2 = ChuanHoa;
    figure(3)
    
    subplot(4, 1, 1)
    plot(thoiGianThuc,x,'LineWidth',1.1)
    hold on
    plot(t,ste_ChuanHoa,'LineWidth',1.1)
    hold off
    xlabel('Time, s')
    ylabel('bien do')
    title('Short-Time Energy')

    subplot(4, 1, 2)
    plot(t,ChuanHoa,'LineWidth',1.1)
    hold on
    yline(Nguong,'r','LineWidth',1.1);
    hold off
    title('Nguong')
    xlabel('Time, s')
    ylabel('bien do')
    
    subplot(4, 1,3 )
    grid on
    plot(thoiGianThuc,x);
    hold on
    for i = 1:length(matran)
        xline(matran(i),'r','LineWidth',1.2);
    end
    title('Voice/Unvoice')
    xlabel('Time, s')
    ylabel('bien do')

    subplot(4, 1,4 )
    grid on
    plot(thoiGianThuc,x);
    hold off
    for  i=1:length(ChuanCuaThay)
        xline(ChuanCuaThay(i),'color','red','Linestyle','--');
    end
    xlabel('Time, s')
    title('Chuan cua thay')
    ylabel('bien do')
    
    
    function trave = sgn(bien)
        if(bien>=0)
            trave = 1;
        else
            trave = -1;
        end
    end