% Aurelio Fusco, Huy Nguyen, & Noah Selo
%
% Optics 211
%
% 5/4/2026
%
%% Final Project
% 
% This script allows the user to generate an aperture of their choosing,
% and prompts the user to input the shape of the aperture (Rectangle, 
% Circle, Polygon with number of sides of users choice), number of
% apertures, as well as the dimensions of the aperture(s). It then produces
% a figure of the aperture, and its resulting diffraction pattern as two 
% images- one of the full image (5000px by 5000px) and one of a zoomed 
% in image 250px by 250px image. Using this image, a cross section of the 
% intensity is graphed across the x=0 and y=0 axies.
%
% It is worth noting that the user must answer the prompts correctly or 
% else the script will give an error. For the shape of the aperture, the
% user MUST type out the correctly spelled shape desired (Rectangle, 
% Circle, Polygon), otherwise the script will give an error and end. This 
% also applies to the Y/N for multiple apertures, which the user MUST type
% either "Y" or "N", otherwise the script will give an error and end. For 
% the dimensions of the square aperture, radius of circular aperture, number
% of sides of the polygon aperture as well as its side length, number of rows
% and columns for multiple apertures, the user MUST enter only positive 
% numerical values, otherwise the script will give an error and end. 
%
%% Note:
% The only exception for these variables is that the center to distance variable
% CAN be negative if the user desires, since it will produce the same aperture 
% regardless of being positive or negative. Also, as prompted, the number of sides
% will give an error if the values are smaller than 3 and larger than 25. 



close all;
clear;

% Define Aperture field
apl=5000; % Size of the aperture field
ap=zeros(apl); % Define actual aperture plane
[x, y] = meshgrid(1:apl, 1:apl); % Defining x and y for circle & polygon function

% Center of Apeture field:
c_row = round(1 + apl/2);
c_col = round(1 + apl/2);


prompt1 = 'What shape would you like? Rectangle, Circle, Polygon: ';
shape = input(prompt1,"s");

%===============================Rectangle================================

if strcmpi('rectangle',shape) == 1

    prompt2 = 'More than 1 [Y/N]: '; %How to pose question such that you ask for if user wants grid?
    n = input(prompt2,"s"); %number of shapes, If more then 1 then give grid dimensions
    
    if strcmpi('Y',n) == 1

        prompt3 = 'Number of Rows: ';
        numRow = str2num(input(prompt3,'s'));

        if numRow < 1 % If number of rows is less then 1 return
            disp('Error. Number of rows cannot be less than 1. Please see help file for more information.')
            return
        end %If more than 1 continue 

        if isempty(numRow) % If number of rows entered isn't a numeric value
            disp('Error. Number of rows must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue

        prompt4 = 'Number of Columns: '; 
        numCol = str2num(input(prompt4,'s'));

        if numCol < 1 % If number of Columns less than 1 return 
            disp('Error. Number of columns cannot be less than 1. Please see help file for more information.')
            return 
        end  %If more than 1 continue 

        if isempty(numCol)
            disp('Error. Number of columns must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue

        prompt5 = 'Center to Center distance: ';
        d = str2num(input(prompt5,'s')); %distance between each shape
        if isempty(d)
            disp('Error. Center to distance must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue
        
    elseif strcmpi(n,'N') == 1
        numRow = 1;
        numCol = 1;
        d = 0;
    else
        disp('Error. Response needs to be either Y or N. Please see help file for more information.')
        return
    end 

    %----------------Prompts for Dimensions--------------

    prompt6 = 'Height [px]: ';
    h = str2num(input(prompt6,'s')); % Height of Rectangle 
    
    if h <= 0 %display error if height entered isn't positive
        disp('Error. Height must be greater than 0. Please see help file for more information.')
        return 
    end

        if isempty(h)
            disp('Error. Height must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue


    
    prompt7 = 'Width [px]: ';
    w = str2num(input(prompt7,'s')); % Width of Rectangle
    
    if w <= 0 %display error if width entered isn't positive
        disp('Error. Width must be greater than 0. Please see help file for more information.')
        return 
    end

    if isempty(w)
        disp('Error. Width must be a valid numeric value. Please see help file for more information.')
        return 
    end %If valid number continue
    
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

%========================Circle==================================

%------------------------Columns---------------------------------

elseif strcmpi('circle',shape) == 1

    prompt2 = 'More than 1 [Y/N]: '; % How to pose question such that you ask for if user wants grid?
    n = input(prompt2,"s"); % number of shapes, If more then 1 then give grid dimensions
    
    if strcmpi('Y',n) == 1

        prompt3 = 'Number of Rows: ';
        numRow = str2num(input(prompt3,'s'));

        if numRow < 1 %Display error if number of rows is less then 1
            disp('Error. Number of rows cannot be less than 1. Please see help file for more information.')
            return
        end 

        if isempty(numRow)
            disp('Error. Number of rows must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue

        prompt4 = 'Number of Columns: '; 
        numCol = str2num(input(prompt4,'s'));

        if numCol < 1 % If number of Columns less than 1 return 
            disp('Error. Number of columns cannot be less than 1. Please see help file for more information.')
            return 
        end  %If more than 1 continue 

        if isempty(numCol)
            disp('Error. Number of columns must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue

        prompt5 = 'Center to Center distance: ';
        d = str2num(input(prompt5,'s')); %distance between each shape
        if isempty(d)
            disp('Error. Center to distance must be a valid numeric value. Please see help file for more information.')
            return 
        end % If valid number continue

    elseif strcmpi(n,'N') == 1
        numRow = 1;
        numCol = 1;
        d = 0;
    else
        disp('Error. Response needs to be either Y or N. Please see help file for more information.')
        return
    end 
%-----------------------------------------------------

    prompt6 = 'Radius [px]: ';
    r = str2num(input(prompt6,'s'));
    
    if r <= 0 %display error if radius isn't positive
        disp('Error. Radius must be greater than 0. Please see help file for more information.')
        return 
    end
    if isempty(r)
        disp('Error. Radius must be a valid numeric value. Please see help file for more information.')
        return 
    end % If valid number continue
    


    % Define center positions for the circle lattice
    rowCenters = c_row + ((1:numRow) - (numRow+1)/2) * d;
    colCenters = c_col + ((1:numCol) - (numCol+1)/2) * d;

    % Draw circles
    for ijk = 1:numRow
        for lmn = 1:numCol

            centerRow = rowCenters(ijk);
            centerCol = colCenters(lmn);

            circle = (x - centerCol).^2 + (y - centerRow).^2 <= r^2;

            ap(circle) = 1;

        end
    end

%===================Polygon=========================================

elseif strcmpi('polygon',shape) == 1

    prompt2 = 'More than 1 [Y/N]: ';
    n = input(prompt2,"s");

    if strcmpi('Y',n) == 1

        prompt3 = 'Number of Rows: ';
        numRow = str2num(input(prompt3,'s'));

        if numRow < 1 %Display error if number of rows is less then 1
            disp('Error. Number of rows cannot be less than 1. Please see help file for more information.')
            return
        end 

        if isempty(numRow)
            disp('Error. Number of rows must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue

        prompt4 = 'Number of Columns: '; 
        numCol = str2num(input(prompt4,'s'));

        if numCol < 1 % If number of Columns less than 1 return 
            disp('Error. Number of columns cannot be less than 1. Please see help file for more information.')
            return 
        end  %If more than 1 continue 

        if isempty(numCol)
            disp('Error. Number of columns must be a valid numeric value. Please see help file for more information.')
            return 
        end %If valid number continue

        prompt5 = 'Center to Center distance: ';
        d = str2num(input(prompt5,'s')); %distance between each shape
        if isempty(d)
            disp('Error. Center to distance must be a valid numeric value. Please see help file for more information.')
            return 
        end % If valid number continue

    elseif strcmpi(n,'N') == 1

        numRow = 1;
        numCol = 1;
        d = 0;

    else
        disp('Error. Response needs to be either Y or N. Please see help file for more information.')
        return
    end

    prompt6 = 'Number of Sides (3-25): ';
    numTri = str2num(input(prompt6,'s'));

    if numTri < 3 %display error if number of sides is less than 3
        disp('Error. Number of sides cannot be less than 3. Please see help file for more information.')
        return
    elseif numTri > 25 %display error if number of sides is greater than 25
        disp('Error. Number of sides cannot be greater than 25. Please see help file for more information.')
        return
    end

    if isempty(numTri)
        disp('Error. Number of sides must be a valid numeric value. Please see help file for more information.')
        return 
    end %If valid number continue
    

    prompt7 = 'Side Length [px]: ';
    L = str2num(input(prompt7,'s'));

   if L <= 0 %Display error if length is negative
        disp('Error. Side length must be greater than 0. Please see help file for more information.')
        return 
    end

    if isempty(L)
        disp('Error. Length of sides must be a valid numeric value. Please see help file for more information.')
        return 
    end %If valid number continue
    
    % Define grid center positions
    rowCenters = c_row + ((1:numRow) - (numRow+1)/2) * d;
    colCenters = c_col + ((1:numCol) - (numCol+1)/2) * d;

    % Angle of each triangle at the center
    apexAngle = 2*pi/numTri;
    halfAngle = apexAngle/2;

    %Height and base width determined by side length
    H = L*cos(halfAngle);
    B = 2*L*sin(halfAngle);

    % First triangle centered at 90 degrees from the x-axis
    theta0 = (3*pi)/2;

    % Draw polygon pattern at every grid center
    for rowIndex = 1:numRow
        for colIndex = 1:numCol

            centerRow = rowCenters(rowIndex);
            centerCol = colCenters(colIndex);

            % Draw each triangle inside this polygon pattern
            for triIndex = 1:numTri

                % Center angle of this triangle
                thetaCenter = theta0 + (triIndex-1)*apexAngle;

                % Left and right edge angles
                theta1 = thetaCenter - halfAngle;
                theta2 = thetaCenter + halfAngle;

                % Apex is at the center of this polygon
                v1 = [centerCol, centerRow];

                % Outer two vertices
                v2 = [centerCol + L*cos(theta1), centerRow - L*sin(theta1)];
                v3 = [centerCol + L*cos(theta2), centerRow - L*sin(theta2)];

                % Create triangle
                polygon = inpolygon(x, y, ...
                    [v1(1) v2(1) v3(1)], ...
                    [v1(2) v2(2) v3(2)]);

                % Fill aperture
                ap(polygon) = 1;

            end
        end
    end

%===================Invalid Input=========================================

else %display error if invalid shape is input
    disp('Error. Need to select a valid aperture shape. Please see help file for more information.')  
    return
end



% Plot the aperture field
figure
imagesc(ap) % Plot image of the aperture field
colormap gray % Set the color of the aperture field plot
axis equal % Set the display scale of the axes
axis([0 apl 0 apl]) % Set axes limits to size of aperture field

%% Intensity
fft_ap = fft2(ap); %perform fourier transformation
fft_ap_centered = fftshift(fft_ap);  % shift zero frequency component to center
intensity = real(fft_ap_centered.*conj(fft_ap_centered));          % intensity
% Rescale intensity 
intensity_rescaled = intensity.^0.45;     


%%==============IMAGE OF DIFFRACTION PATTERN=====================
%----------Plot Intensity (5000px*5000px range)----------
figure 
imagesc(intensity_rescaled)  % Plot image of the aperture field 
colormap hot % Set the color of the aperture field plot 
axis image % Set the display scale of the axes 
title('Full-Field Far Diffraction Pattern') % Title of plot
xlabel('Pixels') % Labels x axis
ylabel('Pixels') % Labels y axis
colorbar % Adds a colorbar
ylabel(colorbar, 'Intensity') % Labels the colorbar


%-------------Plot Intensity (250px*250px range)-----------
figure 
imagesc(intensity_rescaled)  % Plot image of the aperture field 
colormap hot % Set the color of the aperture field plot 
axis equal % Set the display scale of the axes 
axis([(apl-250)/2 (apl+250)/2 (apl-250)/2 (apl+250)/2]) % Zooms the field in
title('Center-Field Far Diffraction Pattern') % Title of plot
xlabel('Pixels') % Labels x axis
ylabel('Pixels') % Labels y axis
colorbar % Adds a colorbar
ylabel(colorbar, 'Intensity') % Labels the colorbar

%% =================CROSS SECTIONS=================

% Center of diffraction pattern
center = c_row;

% Extract cross sections
Ix = intensity_rescaled(center, :);    % Horizontal
Iy = intensity_rescaled(:, center);    % Vertical

% Normalize
Ix = Ix / max(Ix);
Iy = Iy / max(Iy);

% Centered coordinate axis
coords = (-apl/2):(apl/2 - 1);

% Zoomed plotting range around center
range = center-300:center+300;

%--------HORIZONTAL--------
figure
plot(coords(range), Ix(range), 'LineWidth', 1.5)
title('Horizontal Cross Section (y = 0)')
xlabel('Spatial Coordinate (pixels)')
ylabel('Normalized Intensity')
grid on

%--------VERTICAL--------
figure
plot(coords(range), Iy(range), 'LineWidth', 1.5)
title('Vertical Cross Section (x = 0)')
xlabel('Spatial Coordinate (pixels)')
ylabel('Normalized Intensity')
grid on
