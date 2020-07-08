function m = refine_down_to_h( msh,h )
%REFINE_DOWN_TO_H 

xc=dGmeshpoints(msh);
dx=dGmeshdiams(msh);
m=(dx>h(xc));
end

