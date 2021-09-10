%% Code for domain --> GoM River case

%% step 1. preprocessing
dir_data = 'I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\';

file_discharge = [dir_data, 'gom_discharge_10River_3hr_201310_201612.mat'];
file_grdH = [dir_data, 'GoM1km_Grd.nc'];
file_grdL = [dir_data, 'GoM3p5km_Grd.nc'];
grdH = load_roms_grid(file_grdH);
grdL = load_roms_grid(file_grdL);

minlon = min(grdH.lonr(:,1));
maxlon = max(grdH.lonr(:,1));
minlat = min(grdH.latr(1,:));
maxlat = max(grdH.latr(1,:));


%% step 2. plot base map subplot 1
figure(213)
subplot(2,1,1)
m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
m_grid('FontName', 'Helvetica', 'FontSize', 15);
hold on
caxis([-4000 0]);
colormap([m_colmap('blue',256)]);
m_shadedrelief([minlon, maxlon],[minlat, maxlat],-grdH.h',...
    'lightangle',-45,'gradientfactor',1.5, 'coord', 'geog');
set(gcf, 'position', [100, 300, 1400, 500])
m_gshhs_h('patch', [242, 214, 136]/255);
m_gshhs('fr', 'color', 'g', 'linewidth', 1)
%m_gshhs('hb', 'color','k')
cb = colorbar;
cb.FontName = 'Helvetica';
cb.FontSize = 12;
title(cb,{'m'}, 'FontName', 'Helvetica','FontSize',14);

%% add soups
load(file_discharge, 'latR', 'lonR', 'tt', 'discharge', 'Rivers');
m_plot(lonR, latR, 'o', 'markersize', 10, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k')
sz_ = 13;
for i = 1:length(Rivers)
    switch i
        case 1
            m_text(lonR(i)-1.8, latR(i), Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 2
            m_text(lonR(i)-1.8, latR(i)-0.1, Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 3
            m_text(lonR(i)-0.15, latR(i)-0.4, [Rivers{i}, newline, Rivers{i+1}],'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 4
            continue
        case 5
            m_text(lonR(i)-0.3, latR(i)-0.3, Rivers{i},'Fontname', ...
               'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 6
            m_text(lonR(i)-0.3, latR(i)-0.3, Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 7
            m_text(lonR(i)-0.3, latR(i)-0.3, Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 8
            m_text(lonR(i)-1.2, latR(i)+0.25, Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 9
            m_text(lonR(i), latR(i)+0.35, Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
        case 10
            m_text(lonR(i), latR(i)+0.3, Rivers{i},'Fontname', ...
                'Helvetica', 'FontSize', sz_, 'color', 'k')
    end
end
m_text(-97.25, 30.25, 'a', 'FontName', 'Helvetica', 'FontSize', 24, ...
    'FontWeight', 'Bold')
set(gcf, 'position', [100, 100, 1700, 900])

f = isnan(discharge(1,:)+discharge(2,:));
discharge(:,f) = [];
tt(f) = [];

ax2 = subplot(2,1,2)
br = bar(datetime(datestr(tt(1:14:end))), discharge(:,1:14:end)', 'stacked');
xlim([datetime('1-Dec-2013'), datetime('31-Dec-2016')])
ylim([0 75000])
xlabel('Time', 'FontName', 'Helvetica', 'FontSize', 15)
ylabel('Discharge (m^3/s)', 'FontName', 'Helvetica', 'FontSize', 15)
legend(Rivers, 'FontName', 'Helvetica', 'FontSize', 10)
br(8).FaceColor = 'k';
br(9).FaceColor = 'r';
br(10).FaceColor = 'b';
bx = gca;
bx.XAxis.FontName = 'Helvetica';
bx.XAxis.FontSize = 14;
bx.YAxis.FontName = 'Helvetica';
bx.YAxis.FontSize = 14;
set(ax2,'YGrid', 'off', 'XGrid', 'on')
text(datetime('1-Jan-2014'), 65000, 'b', 'FontName', 'Helvetica', 'FontSize', 24, ...
    'FontWeight', 'Bold')

%% step 5, arrange position
pos = get(ax2, 'position')
pos(1) = 0.3;
pos(2) = 0.3;
pos(3) = 0.32;
pos(4) = 0.2;
set(ax2, 'position', pos)