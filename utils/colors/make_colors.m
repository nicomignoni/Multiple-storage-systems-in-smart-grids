% --- MAKE COLORS ---
clear

colors.prosumer.hex    = '#41D15F';         % Prosumer color code (hex)
colors.provider.hex    = '#4B53FF';         % Provider color code (hex)
colors.demand.hex      = '#64D5FF';         % Demand color code (hex)
colors.generation.hex  = '#FEC300';         % Generation color code (hex)
colors.retailer.hex    = '#FF4544';         % Retailer color code (hex)
colors.coordinator.hex = '#FFDF46';         % Coordinator color code (hex)

colors.prosumer.rgb    = [65 209 95]/255;   % Prosumer color code (rgb)
colors.provider.rgb    = [75 83 255]/255;   % Provider color code (rgb)
colors.demand.rgb      = [100 213 255]/255; % Demand color code (rgb)
colors.generation.rgb  = [254 195 0]/255;   % Generation color code (rgb)
colors.retailer.rgb    = [255 69 68]/255;   % Retailer color code (rgb)
colors.coordinator.rgb = [255 223 70]/255;  % Coordinator color code (rgb)

save("colors.mat");