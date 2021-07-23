% Load condo production and demand data
clear
load('energy_data.mat');
load('../../utils/colors/colors.mat');

% Time horizon 
T = 24; % hours

%% Seasonal trends %% 
% - Season start is based on meteorological start
% - Starting day is calculated from January 1
seasons.winter.title = 'Winter';
seasons.autumn.title = 'Autumn';
seasons.summer.title = 'Summer';
seasons.spring.title = 'Spring';

seasons.winter.date = 335; % December 1
seasons.autumn.date = 244; % September 1
seasons.summer.date = 152; % June 1 
seasons.spring.date = 60;  % March 1

seasons.spring.PV = PV(seasons.spring.date : seasons.summer.date-1,:);
seasons.summer.PV = PV(seasons.summer.date : seasons.autumn.date-1,:);
seasons.autumn.PV = PV(seasons.autumn.date : seasons.winter.date-1,:);
seasons.winter.PV = [PV(seasons.winter.date : end,:);
                     PV(1 : seasons.spring.date-1,:)];

seasons.spring.DP = DP(seasons.spring.date : seasons.summer.date-1,:);
seasons.summer.DP = DP(seasons.summer.date : seasons.autumn.date-1,:);
seasons.autumn.DP = DP(seasons.autumn.date : seasons.winter.date-1,:);
seasons.winter.DP = [DP(seasons.winter.date:end,:);
                     DP(1 : seasons.spring.date-1,:)];
   
% Plotting results
figure;
tiledlayout(4,1);
season = fieldnames(seasons);
for i=1:4
    nexttile;
    avg_PV = mean(seasons.(season{i}).PV, 1);
    avg_DP = mean(seasons.(season{i}).DP, 1);
    
    std_PV = std(seasons.(season{i}).PV, 1);
    std_DP = std(seasons.(season{i}).DP, 1);
    
    hold on;
    plot(avg_PV, "-o", ...
         'Color', colors.generation.rgb, ...
         'LineWidth', 2); 
    plot(avg_DP, "-o", ...
         'Color', colors.demand.rgb, ...
         'LineWidth', 2); 
    fill([1:T fliplr(1:T)], ...
         [avg_PV - std_PV, fliplr(avg_PV + std_PV)], ...
         colors.generation.rgb, ...
         'LineStyle', 'none', ...
         'FaceAlpha', 0.1);
    fill([1:T fliplr(1:T)], ...
         [avg_DP - std_DP, fliplr(avg_DP + std_DP)], ...
         colors.demand.rgb, ...
         'LineStyle', 'none', ...
         'FaceAlpha', 0.1);
    hold off;
    title(seasons.(season{i}).title);
    legend('Power generation', 'Demand');
    xlabel('Day hours');
    ylabel('kW');
end

%% Weekly trends %% 
week.monday.title    = 'Monday';
week.tuesday.title   = 'Tuesday';
week.wednesday.title = 'Wednesday';
week.thursday.title  = 'Thursday';
week.friday.title    = 'Friday';
week.saturday.title  = 'Saturday';
week.sunday.title    = 'Sunday';

week.monday.PV    = PV(6:7:end,:);
week.tuesday.PV   = PV(7:7:end,:);
week.wednesday.PV = PV(1:7:end,:);
week.thursday.PV  = PV(2:7:end,:);
week.friday.PV    = PV(3:7:end,:);
week.saturday.PV  = PV(4:7:end,:);
week.sunday.PV    = PV(5:7:end,:);

week.monday.DP    = DP(6:7:end,:);
week.tuesday.DP   = DP(7:7:end,:);
week.wednesday.DP = DP(1:7:end,:);
week.thursday.DP  = DP(2:7:end,:);
week.friday.DP    = DP(3:7:end,:);
week.saturday.DP  = DP(4:7:end,:);
week.sunday.DP    = DP(5:7:end,:);

% Plotting results
figure;
tiledlayout(7,1);
day = fieldnames(week);
for i=1:7
    nexttile;
    avg_PV = mean(week.(day{i}).PV, 1);
    avg_DP = mean(week.(day{i}).DP, 1);
    
    std_PV = std(week.(day{i}).PV, 1);
    std_DP = std(week.(day{i}).DP, 1);
    
    hold on;
    plot(avg_PV, "-ob"); 
    plot(avg_DP, "-or"); 
    grid on;
    fill([1:T fliplr(1:T)], ...
         [avg_PV - std_PV, fliplr(avg_PV + std_PV)], 'b', ...
         'LineStyle', 'none', 'FaceAlpha', 0.1);
    fill([1:T fliplr(1:T)], ...
         [avg_DP - std_DP, fliplr(avg_DP + std_DP)], 'r', ...
         'LineStyle', 'none', 'FaceAlpha', 0.1);
    hold off;
    title(week.(day{i}).title);
    legend('Power generation', 'Demand');
    xlabel('Day hours');
    ylabel('kW');
end