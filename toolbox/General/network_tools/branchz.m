function z=branchz(p,cubenumber )
global datas cubez

[x,y,z]=ind2sub(datas,p);

z=mean(z)+cubez(cubenumber);
end