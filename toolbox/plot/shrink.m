function small=shrink(big,ratio)
if nargin<2
    ratio=5;
end
small=big(1:ratio:end,1:ratio:end,1:ratio:end);
end

