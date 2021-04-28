function CrossHatchMap(minx,maxx,miny,maxy,ds,c,S)
%% CrossHatchMap(minx,maxx,miny,maxy,ds)
% Constructs a cross hatch for the underlay of the map to geoshow the impact
% of attacks on Reff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% minx - the minimum x value of the map
% maxx - the mximum x value of the map
% miny - the minimum y value of the map
% maxy - the mximum y value of the map
% ds - the spacing between the lines
% c - color of the lines
% S - the area you want the cross hatch contained in
xx=linspace(minx+miny-maxy,maxx,round(1/ds));

CH1=cell(length(xx),1);
CH2=cell(length(xx),1);
SS=5001;
dx=linspace(0,maxy-miny,SS);
dx=dx(2)-dx(1);
parfor ii=1:length(xx)
    xp=linspace(xx(ii),maxy-miny+xx(ii),SS);
    yp=(linspace(xx(ii),maxy-miny+xx(ii),SS)-xx(ii))+miny;
    f=inpolygon(xp,yp,S.Lon,S.Lat); 
    CH1{ii}=[yp(f); xp(f)]; % need to flip because plotting lat long [xp(f); yp(f)];

   yp=flip(yp);%-(linspace(xx(ii),maxy-miny+xx(ii),SS)-xx(ii))+maxy;   
   f=inpolygon(xp,yp,S.Lon,S.Lat); 

    CH2{ii}=[(yp(f)); xp(f)]; % need to flip because plotting lat long [xp(f); yp(f)];

end
for ii=1:length(xx)   
    P=CH1{ii};
    dP=P(1,2:end)-P(1,1:end-1);
        f=find(abs(dP-dx)>dx/2);
        if(~isempty(f))
            if(f(1)>1)
                geoshow(P(1,1:(f(1)-1)),P(2,1:(f(1)-1)),'color',c,'LineWidth',0.5); hold on; 
                lp=length(P(1,f(1):end));
                P=P(:,f(1):end);
            else
                lp=length(P(1,(f(1)+1):end));
                P=P(:,(f(1)+1):end);
            end
        else            
            geoshow(P(1,1:end),P(2,1:end),'color',c,'LineWidth',0.5); hold on; 
            lp=0;
        end
   while(lp>1)
        dP=P(1,2:end)-P(1,1:end-1);
        f=find(abs(dP-dx)>dx/2);
        if(~isempty(f))
            if(f(1)>1)
                geoshow(P(1,1:(f(1)-1)),P(2,1:(f(1)-1)),'color',c,'LineWidth',0.5); hold on; 
                lp=length(P(1,f(1):end));
                P=P(:,f(1):end);
            else
                lp=length(P(1,(f(1)+1):end));
                P=P(:,(f(1)+1):end);
            end
        else            
            geoshow(P(1,1:end),P(2,1:end),'color',c,'LineWidth',0.5); hold on; 
            lp=0;
        end
   end
    P=CH2{ii};
    dP=-(P(1,2:end)-P(1,1:end-1));
        f=find(abs(dP-dx)>dx/2);
        if(~isempty(f))
            if(f(1)>1)
                geoshow(P(1,1:(f(1)-1)),P(2,1:(f(1)-1)),'color',c,'LineWidth',0.5); hold on; 
                lp=length(P(1,f(1):end));
                P=P(:,f(1):end);
            else
                lp=length(P(1,(f(1)+1):end));
                P=P(:,(f(1)+1):end);
            end
        else            
            geoshow(P(1,1:end),P(2,1:end),'color',c,'LineWidth',0.5); hold on; 
            lp=0;
        end
   while(lp>1)
        dP=-(P(1,2:end)-P(1,1:end-1));
        f=find(abs(dP-dx)>dx/2);
        if(~isempty(f))
            if(f(1)>1)
                geoshow(P(1,1:(f(1)-1)),P(2,1:(f(1)-1)),'color',c,'LineWidth',0.5); hold on; 
                lp=length(P(1,f(1):end));
                P=P(:,f(1):end);
            else
                lp=length(P(1,(f(1)+1):end));
                P=P(:,(f(1)+1):end);
            end
        else            
            geoshow(P(1,1:end),P(2,1:end),'color',c,'LineWidth',0.5); hold on; 
            lp=0;
        end
   end
end
xlim([minx./40 maxx./40]);
ylim([miny./50 maxy./50]);
end

