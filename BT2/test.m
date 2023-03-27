clear
close all
clc

nx = 0:4; % specify the support
x = 5:-1:1; % specify sequence
n0 = 2;
% (a) First folding, then shifting
[y1, ny1] = fold(x,nx);
[y1, ny1] = shift(y1,ny1,-n0);
% (b) First shifting, then folding
[y2, ny2] = shift(x,nx,-n0);
[y2, ny2] = fold(y2,ny2);
% Plot
hf = figconfg('P0202');
xylimit = [min([nx(1),ny1(1),ny2(1)])-1,max([nx(end),ny1(end)...
,ny2(end)])+1,min(x)-1,max(x)+1];
subplot(3,1,1)
stem(nx,x,'fill')
axis(xylimit)
ylabel('x[n]','fontsize',LFS); title('x[n]','fontsize',TFS);
set(gca,'Xtick',xylimit(1):xylimit(2))
subplot(3,1,2)
stem(ny1,y1,'fill')
axis(xylimit)
ylabel('y_1[n]','fontsize',LFS);
title('y_1[n]: Folding and Shifting','fontsize',TFS)
set(gca,'Xtick',xylimit(1):xylimit(2))
subplot(3,1,3)
stem(ny2,y2,'fill')
axis(xylimit)
xlabel('n','fontsize',LFS); ylabel('y_2[n]','fontsize',LFS);
title('y_2[n]: Shifting and Folding','fontsize',TFS)
set(gca,'Xtick',xylimit(1):xylimit(2))