function f = EmpericalDist(x,Dist)
%EMPERICALDIST Summary of this function goes here
%   Detailed explanation goes here
if(Dist==1)
    %A latent class approach to tourists� length of stayq
    %Joaqu�n Alegre*, Sara Mateo, Lloren� Pou
   EE=[3.40829931063182,0.00881398735196171;3.93772803337501,0.0155369981538116;4.44455585326993,0.0188163548257220;4.96848545304796,0.0189772198796128;5.48130434772688,0.0133860556041810;5.94688709458487,0.0993323618133982;6.47118475948502,0.177671050896286;7.04401094459150,0.216611850699468;7.52736119515215,0.202152895509036;8.00750530605875,0.128341260276678;8.58813557073403,0.0311984225988036;9.07425744107278,0.0430846722031999;9.59427271670668,0.0462830528731274;10.1096237308535,0.0619369422045602;10.5905078398546,0.0612605512370329;11.0988604430937,0.0507581361519360;11.6290644355972,0.0335263879292669;12.1844206825646,0.0222754863524931;12.6932897178647,0.0238716833061144;13.1902155754719,0.118467301020509;13.7821462822580,0.170052224815592;14.2445018924270,0.175908090674426;14.7227511236173,0.135138420495934;15.2566104721782,0.0467452507433632;15.7822436490803,0.00439335188985668;16.3121607379877,0.00260047770373106;16.8276854002671,0.00177554284285231;17.2748680389445,0.00272957960709108;17.8225644878089,0.00133480159734323;18.3189143619953,0.00135652559393751;18.8338450203781,0.00118534897595812;19.3573487878091,0.00115983296847122;19.9068710302932,0.00328131406811061;20.4507800933972,0.00750338982901666;20.9433983876484,0.00856134991190827;21.4386728696754,0.00839583075071115;21.9198369531115,0.00608413882077141;22.4044530440758,0.00201962405975564;22.9912957581282,0.00145340527431470;23.5847267323148,0.00126414065843738;24.0347642040358,0.00149907528682813;24.5395816994836,0.00141355108499752;25.0756651473596,0.00122177651086086;25.5830501453912,0.00145922109751095;26.0491600424685,0.00101276815766549;26.5635645788302,0.00150213576984282;27.1687402453216,0.00142100399496603;27.6474514801979,0.00165719360248651;28.1385072939224,0.00178630469635022;28.7433375032324,0.00181277660677170];
   NC=sum(pchip(EE(:,1),EE(:,2),[3:28]));
   f=pchip(EE(:,1),EE(:,2),x)./NC;
   f(x<3)=0;
   f(x>28)=0;
end

end

