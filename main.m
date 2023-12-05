% BME3053C Homework 11 Question 2 Fourier Transforms

% Author: Lucas Geraldi-Smith, Javier Vento, Neeley De La Mata  

% Group Members: Neeley De La Mata, Javier Vento

% Course: BME 3053C Computer Applications for BME 

% Term: Fall 2023

% J. Crayton Pruitt Family Department of Biomedical Engineering

% University of Florida

% Email:lgeraldismith@ufl.edu 

% December 3rd, 2023

clc; clear; close all;

% Enter NiFti File to read and create a name for final segmented file
filename = input('Enter Filename: ','s');
saved_filename = [filename(1:5) 'Segmentation.nii'];

% Run segmentation
Area = processNiftiFile(filename,saved_filename);

% Print slice areas 
disp(Area)