
function reAdjustedData = AddContrast(data)
% Reshape 3d data into 2D matrix with dimensions (Height*Width) X Slice
reshapedData = reshape(data,[],size(data,3));
%Increase contrast for all images at once
adjustedData = imadjust(reshapedData);
%readjust data back into Height X Width X Slice
reAdjustedData = reshape(adjustedData,size(data));
end
