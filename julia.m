function [EscTime, EscVal, Image] = julia (c, limits, nx, ny, maxEscTime)
% Visualize julia sets, set of complex numbers that generate a bounded seq
%
% HomeworkProgram4
%
% Name: Neild, Lainey
% Section: 27
% Date: 10/14/2021

% nargin = 5 (1 required, 4 mandatory); 
% c = scalar value
% limits = [xmin xmax ymin ymax], x = real, y = imaginary
% nx = pixels in x direction
% ny = pixels in y direction
% maxEscTime = max value for k, num iterations for find escTime
% 
% nargout = 3
% EscTime = array ny x nx of escape time for each pixel
% EscVal = array ny x nx of escape val for each pixel
% Image = array with color data for image

% r = escape radius
r = (1+sqrt(1+4*abs(c)))/2;

% check if optional inputs are defined, if not set to default vals
if ~exist('limits', 'var') || isempty(limits)
    limits = [-r r -r r];
end

if ~exist('nx', 'var') || isempty(nx)
    nx = 1024;
end

if ~exist('ny', 'var') || isempty(ny)
    ny = 1024;
end

if ~exist('maxEscTime', 'var') || isempty(maxEscTime)
    maxEscTime = 1000;
end

% create region:

% linspace - creates nx or ny points spaced between limits(1) and limits(2)
% or between limits(4) and limits(3)
x = linspace(limits(1),limits(2),nx); 
y = linspace(limits(4),limits(3),ny);

% meshgrid -  2-D array based on the coordinates in x, y
[X,Y] = meshgrid(x,y);

% Z - array of complex nums
% all elems spaced evenly bw 4 corners - (1,1) (ny,1), (1, nx), (ny,nx)
Z = X + 1i*Y;

% initializing escape time - time it takes for a sequence to explode
EscTime = Inf(ny, nx);

% initialize escape value - distance it explodes to
EscVal = NaN(ny, nx);

% initialize all values in region to false
done = false(ny, nx);

% iterate through 1 to maxEscTime to see if the seq explodes
for k = 1:maxEscTime
    
    % set each elem of Z to the sum of c and the square of Z 
    Z = Z.^2+c;
    
    % new - when val = not accounted for (done = false) and
    % when the abs of the updated Z val is larger than the escape radius
    new = ~done & abs(Z)>r;
    
    % set the escape time of this new accounted for value to k/escape time
    EscTime(new) = k;
    
    % set escape value of this new accounted for val to the abs val of Z
    EscVal(new) = abs(Z(new));
    
    % update the done array to account for this elem by setting it to true
    done(new) = true;
    
    % if every element in done is true, we have completed enough iterations
    if done
        break;
    end
    
end

% plot result as a color image - call the showJulia file
Image = showJulia(EscTime,EscVal,limits);
    
end


