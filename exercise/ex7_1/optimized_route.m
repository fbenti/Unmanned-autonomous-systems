function route = optimezed_route(route)
route2 =route;
rindex=ones(size(route,1),1);
for i=2:size(route,1)-1
    if (abs(route(i,1)-route(i-1,1))==1 && abs(route(i,1)-route(i+1,1))==1) ...
        ||(abs(route(i,2)-route(i-1,2))==1 && abs(route(i,2)-route(i+1,2))==1)...
        ||(abs(route(i,3)-route(i-1,3))==1 && abs(route(i,3)-route(i+1,3))==1)
        rindex(i)=0;
    end
end
route = route2(rindex==1,:);
end
