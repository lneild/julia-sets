c = input('Enter a value for the parameter c: ');
limits = [];
while true
    fprintf('Working...\n');
    [EscTime,EscVal,Image] = julia(c,limits);
    fprintf('Select rectangle (or CTRL-C to exit).\n');
    r = getrect;
    limits = [r(1), r(1)+r(3), r(2), r(2)+r(4)];
end
