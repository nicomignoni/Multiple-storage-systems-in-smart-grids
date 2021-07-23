function Economy = economy(Case)

    Prosumers.PowerSoldRevenue    = sum(Case.par.R.*Case.var.p_down, 2);
    Prosumers.PowerBoughtCosts    = sum(Case.par.C.*Case.var.p_up, 2);
    Prosumers.PowerStoredCosts    = sum(Case.par.L.*Case.var.s, 2);
    Prosumers.PowerStoredRevenues = 0;
    Prosumers.EfficiencyCosts     = sum(0.5*Case.par.csi'.*(Case.var.p_up.^2 + Case.var.p_down.^2 + Case.var.d_up.^2 + Case.var.d_down.^2), 2);
    Prosumers.TotalCosts          = Prosumers.PowerBoughtCosts - Prosumers.PowerSoldRevenue + ...
                                  + Prosumers.PowerStoredCosts + Prosumers.EfficiencyCosts;
    
    Providers.PowerSoldRevenue    = 0;
    Providers.PowerBoughtCosts    = 0;
    Providers.PowerStoredCosts    = 0;
    Providers.PowerStoredRevenues = sum(Case.par.L.*Case.var.b, 2);
    Providers.EfficiencyCosts     = sum(0.5*Case.par.zeta'.*(Case.var.q_down + Case.var.q_up).^2, 2);
    Providers.TotalCosts          = Providers.EfficiencyCosts - Providers.PowerStoredRevenues;
    
    Retailer.PowerSoldRevenues   = sum(Case.par.R.*Case.var.p_down, 1);
    Retailer.PowerBoughtCosts    = sum(Case.par.C.*Case.var.p_up, 1);
    Retailer.PowerStoredCosts    = 0;
    Retailer.PowerStoredRevenues = 0;
    Retailer.EfficiencyCosts     = 0;
    Retailer.HourlyRevenues      = Retailer.PowerBoughtCosts - Retailer.PowerSoldRevenues;
    
    Economy.Prosumers = Prosumers;
    Economy.Providers = Providers;
    Economy.Retailer  = Retailer;
end
