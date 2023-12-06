function Area = processNiftiFile(niftiFilePath,saved_filename)
    % Load the NIFTI file
    niftiData = ReadImage(niftiFilePath);

    % Display a dialog box describing the process, pause exec till it
    % closes
    msg = 'Please use the Volume Segmenter app to segment the volume. After segmentation, close the app. Click Okay to begin.';
    uiwait(msgbox(msg, 'Volume Segmenter App', 'help'));

    % Display an instructrional image to assist in segmentation process
    % according to lab SOP
    imshow('Instructional_Image.png')

    % Dialog box for further instructions
    msgbox('First, locate the junction between the tibia and fibula and navigate to the slice before the two black structures touch. Then, navigate to the draw tab of the volumeSegmenter and click "Polygon". Draw the appropriate muscle annotation according to the 2nd instructional image. Skip 7 slices ahead and again draw an appropriate annotation. After two annotations are completed, click "Auto Interpolate" button in the draw tab. Then, navigate back to the segment tab and click save labels as workspace variable. Then, close volumeSegmenter app.')
    % Launch the Volume Segmenter app
    volumeSegmenter(niftiData);

    % Wait for the variable 'labels' to appear in the workspace
    while ~evalin('base', 'exist(''labels'', ''var'')')
         pause(1)
    end
    % Retrieve the segmented data from the workspace
    segmentedData = evalin('base', 'labels');
    % Save one for niftiwrite later
    segmentedData2 = evalin('base','labels');
    % Find indices of non-zero slices
    nonZeroIndices = any(any(segmentedData ~= 0, 1), 2);
    % Use logical indexing to keep non-zero images
    segmentedData = segmentedData(:,:,nonZeroIndices);
    % Allocate Area vector, calculate area for each slice with atleast one
    % pixel with logical value =1
    Area = zeros(1,size(segmentedData,3));
    for ii = 1:size(segmentedData,3)
        Area(ii) = sum(segmentedData(:,:,ii),'all');
    end
    % Divide by correction factor
    Area = Area/14;
    % Graph area versus slice number
    figure('Name','Change in Area of Muscle throughout slices')
    plot(Area)
    xlabel('Slice Number')
    ylabel('Area of tricep surae muscle')
    title('Change in tricep surae area throughout MRI Slices')
    % Overlay segmentation onto original volume, adding gradient for ease
    % of vision
    volshow(niftiData,'RenderingStyle','GradientOpacity','GradientOpacityValue',1,'OverlayData',segmentedData2,'OverlayRenderingStyle','LabelOverlay','OverlayAlphamap',0.8)
    % Threshold out all parts of original volume not segmented by user
    niftiData(~segmentedData2)=0;
    % Save segmented volume in NiFti format
    niftiwrite(niftiData,saved_filename)
end
