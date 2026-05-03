% Define Aperture field
apl=5000; % Size of the aperture field
ap=zeros(apl); % Define actual aperture plane

% Center of Apeture field:
c_row = round(1 + apl/2);
c_col = round(1 + apl/2);


prompt1 = 'What shape would you like? Rectangle, Square, Circle, Polygon: ';
shape = input(prompt1,"s");

%===============================Rectangle================================

if strcmpi('rectangle',shape) == 1

    prompt2 = 'More than 1 [Y/N]: '; %How to pose question such that you ask for if user wants grid?
    n = input(prompt2,"s"); %number of shapes, If more then 1 then give grid dimensions
    
    if strcmpi('Y',n) == 1

        prompt3 = 'Number of Rows: ';
        numRow = input(prompt3);

        if numRow < 1 % If number of rows is less then 1 return
            return 
        end 

        prompt4 = 'Number of Columns: '; 
        numCol = input(prompt4);

        if numCol < 1 % If number of Columns less than 1 return 
            return
        end  %If more than 1 continue 

        prompt5 = 'Center to Center distance: ';
        d = input(prompt5); %distance between each shape

    elseif strcmpi(n,'N') == 1
        numRow = 1;
        numCol = 1;
        d = 0;
    else

    end 

    %----------------Prompts for Dimensions--------------
    prompt6 = 'Height: ';
    h = input(prompt6); % Height of Rectangle 

    prompt7 = 'Width: ';
    w = input(prompt7); % Width of Rectangle
    %---------------------------------------------

    % Define center positions
    rowCenters = c_row + ((1:numRow) - (numRow+1)/2) * d;
    colCenters = c_col + ((1:numCol) - (numCol+1)/2) * d;
    
    for ijk = 1:numRow
        for lmn = 1:numCol

            centerRow = rowCenters(ijk);
            centerCol = colCenters(lmn);
            
            rowStart = round(centerRow - h/2);
            rowEnd   = round(centerRow + h/2);

            colStart = round(centerCol - w/2);
            colEnd   = round(centerCol + w/2);

            % Keep indices inside the aperture field
            rowStart = max(1, rowStart);
            rowEnd   = min(apl, rowEnd);

            colStart = max(1, colStart);
            colEnd   = min(apl, colEnd);

            ap(rowStart:rowEnd, colStart:colEnd) = 1;

        end
    end
%====================Circle=======================================
elseif strcmpi('circle',shape) == 1
    
    prompt2 = 'More than 1?: '; %How to pose question such that you ask for if user wants grid?
    n = input(prompt2); %number of shapes, If more then 1 then give grid dimensions
%===================_______=========================================
else
    z = 3;
    return
end


 % Plot the aperture field
figure
imagesc(ap) % Plot image of the aperture field
colormap gray % Set the color of the aperture field plot
axis equal % Set the display scale of the axes
axis([0 apl 0 apl]) % Set axes limits to size of aperture field

%% Intensity (Huy)
fft_ap = fft2(ap); %perform fourier transformation
fft_ap_centered = fftshift(fft_ap);  % shift zero frequency component to center
intensity = real(fft_ap_centered.*conj(fft_ap_centered));          % intensity
% Rescale intensity 
intensity_rescaled = intensity.^0.45;     

%% Plot Intensity 
figure 
imagesc(intensity_rescaled)  % Plot image of the aperture field 
colormap hot % Set the color of the aperture field plot 
axis equal % Set the display scale of the axes 
axis([(apl-250)/2 (apl+250)/2 (apl-250)/2 (apl+250)/2])
