classdef Plotter
    properties
        AveragePV; StdPV; AverageDP; StdDP; T; colors;
    end
    
    methods
        % Constructor
        function self = Plotter(T)
            self.T = T;
        end
        
        % Double curve plot w/ dispersion area
        function doublePlot(self, Average1, Std1, Average2, Std2, ...
                            LineWidth1, LineWidth2, LineType1, LineType2, ...
                            Color1, Color2, XLAbel, YLAbel, Legend1, Legend2)
            arguments
                self
                Average1 (1,:)
                Std1     (1,:)
                Average2 (1,:)
                Std2     (1,:)
                LineWidth1 {mustBeNumeric}
                LineWidth2 {mustBeNumeric}
                LineType1 string
                LineType2 string
                Color1
                Color2
                XLAbel string
                YLAbel string
                Legend1 string
                Legend2 string
            end
            figure
            hold on      
            fill([1:self.T fliplr(1:self.T)], [Average1 - Std1, fliplr(Average1 + Std1)], ...
                  Color1.rgb, 'LineStyle', 'none', 'FaceAlpha', 0.1);
            fill([1:self.T fliplr(1:self.T)], [Average2 - Std2, fliplr(Average2 + Std2)], ...
                  Color2.rgb, 'LineStyle', 'none', 'FaceAlpha', 0.1);
            plot2 = plot(Average2, LineType2, "LineWidth", LineWidth2, "Color", Color2.hex);
            plot1 = plot(Average1, LineType1, "LineWidth", LineWidth1, "Color", Color1.hex);
            xlabel(XLAbel); ylabel(YLAbel);
            legend([plot1, plot2], Legend1, Legend2);
            grid on;
            hold off;
        end
     
        % Plot retailer buying and selling curves
        function plotPricesAndCosts(self, R, C, L, colors)
            arguments
                self
                R (1,:)
                C (1,:)
                L (1,:)
                colors
            end          
            figure
            hold on;
            plot(R, "-o", "LineWidth", 2, 'Color', colors.prosumer.rgb); 
            plot(C, "-o", "LineWidth", 2, 'Color', colors.retailer.rgb); 
            plot(L, "-o", "LineWidth", 2, 'Color', colors.provider.rgb);
            xlabel('Day hours'); ylabel('€/kWh');
            legend('Selling price', 'Buying cost', 'Storage price');
            grid on;
            hold off;
        end
        
        % Plot average constraint values over iterations
        function plotConvergence(self, AverageConstr, StdConstr, Iters)
            arguments
                self          
                AverageConstr (1,:)
                StdConstr     (1,:)
                Iters         (1,1)
            end
            figure
            hold on;
            plot(AverageConstr, '-b'); 
            line([0 Iters], [0 0], 'Color', 'r', 'LineStyle', '-');
            fill([1:Iters fliplr(1:Iters)], ...
                 [AverageConstr - StdConstr, fliplr(AverageConstr + StdConstr)], ...
                  'b', 'LineStyle', 'none', 'FaceAlpha', 0.1);
            xlabel('Iterations'); ylabel('kWh');
            hold off; 
        end
    end
end
