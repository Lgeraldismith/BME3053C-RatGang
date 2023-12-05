% Author: Lucas Geraldi-Smith   
% Group Members: Neeley De La Mata, Javier Vento
%Course: BME 3053C Computer Applications for BME 
%Term: Fall 2023
%J. Crayton Pruitt Family Department of Biomedical Engineering
%University of Florida
%Email:lgeraldismith@ufl.edu 
%November 27th, 2023
%Get specified file name from user
function niftiData = ReadImage(filename)
% Assuming your script is in the same folder as the subfolder
scriptFolder = fileparts(mfilename('fullpath'));
% Specify the subfolder name
subfolderName = 'MRI_Images';
% Construct the full path to the subfolder
subfolderPath = fullfile(scriptFolder, subfolderName);
% Construct the full path to the NIfTI image
imageFilePath = fullfile(subfolderPath, filename);
% Read the nifti image using niftiread
UnAdjustedNiftiData = niftiread(imageFilePath);
% Call AddContrast function to increase contrast on all images
niftiData = AddContrast(UnAdjustedNiftiData);
end