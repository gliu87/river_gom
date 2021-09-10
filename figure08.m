%% plot transport figure
%% note, because of naming systme, sometimes passive and active are in wrong position.

%% predefined parameters
DIR = 'I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\';
target_year = 2015;
ens = 'passive';

%% domain, colormap and grdfile
minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;
file_grd_sp = [DIR, 'GoM1km_Grd.nc'];
grd = load_roms_grid(file_grd_sp);
load('OMG_CM.mat')
cm4jet_ = cm4jet;
cm4jet = [cm4jet(1:8,:); [1 1 1]; cm4jet(9:16,:)];

%% load count file and zeta file
file = [DIR, '\Processed_Data\', ens, '-SP-Final-', ...
    num2str(target_year), '-transport-100m-200m.mat'];
load(file)

load(['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\Data_River\Processed_Data\', ...
                        ens, '-', 'SP', '-', num2str(target_year), '-mean-saltzeta-24681012.mat'])

months = {'4', '8', '12'};


%% plot u
cyl = 1;
for ii = 1:length(months)
    eval(['Qu = squeeze(nanmean(Quz200_', months{ii}, '(:,:,1:6)-Quz100_', months{ii}, '(:,:,1:6),3));'])
    eval(['Qv = squeeze(nanmean(Qvz200_', months{ii}, '(:,:,1:6)-Qvz100_', months{ii}, '(:,:,1:6),3));'])
    eval(['zeta = squeeze(nanmean(zeta_', months{ii}, '(:,:,1:6),3));'])
    Qu = inpaint_nans(Qu);
    Qv = inpaint_nans(Qv);
    Qz = sqrt(Qu .^ 2 + Qv .^ 2);
    figure(213)
    sb((ii-1)*3+1) = subplot(4,3,(ii-1)*3+1);
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    switch (ii-1)*3+1
        case {1, 4}
            m_grid('xticklabel', (''), 'ytick', 24:2:30,'FontName', 'Helvetica', 'FontSize', 14);
        case {7}
            m_grid('ytick', 24:2:30,'FontName', 'Helvetica', 'FontSize', 14);
        case {2, 3, 5, 6}
            m_grid('xticklabel', (''), 'yticklabel', (''), 'FontName', 'Helvetica', 'FontSize', 14);
        case {8, 9}
            m_grid('yticklabel', (''), 'FontName', 'Helvetica', 'FontSize', 14);
    end
    hold on
    m_gshhs_h('color', 'k');
    m_gshhs('fr', 'color', 'g', 'linewidth', 1)
    m_pcolor(grd.lonp, grd.latp, Qu .* grd.maskp);
    shading interp
    caxis([-250 250])
    colormap(sb((ii-1)*3+1), cm4jet);
    [cs, h] = m_contour(grd.lonr, grd.latr, zeta, [0.17, 0.4, 0.6], ...
        'color', 'k', 'linewidth', 1.5);
    clabel(cs, h, 'fontsize', 10, 'fontname', 'Helvetica', 'labelspacing', 500);
    switch (ii-1)*3+1
        case 1
            yl(cyl) = ylabel('Apr', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
            title('Transport U', 'fontsize', 14, 'fontname', 'Helvetica')
        case 2
            title('Transport V', 'fontsize', 14, 'fontname', 'Helvetica')
        case 3
            title('Transport Vector', 'fontsize', 14, 'fontname', 'Helvetica')
        case 4
            yl(cyl) = ylabel('Aug', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 7
            cb = colorbar('SouthOutside');
            cb.FontName = 'Times New Roman';
            cb.FontSize = 14;
            yl(cyl) = ylabel('Dec', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case {8, 9}
            cb = colorbar('SouthOutside');
            cb.FontName = 'Times New Roman';
            cb.FontSize = 14;
    end
    
    sb((ii-1)*3+2) = subplot(4,3,(ii-1)*3+2);
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    switch (ii-1)*3+2
        case {1, 4}
            m_grid('xticklabel', (''), 'ytick', 24:2:30,'FontName', 'Helvetica', 'FontSize', 14);
        case {7}
            m_grid('ytick', 24:2:30,'FontName', 'Helvetica', 'FontSize', 14);
        case {2, 3, 5, 6}
            m_grid('xticklabel', (''), 'yticklabel', (''), 'FontName', 'Helvetica', 'FontSize', 14);
        case {8, 9}
            m_grid('yticklabel', (''), 'FontName', 'Helvetica', 'FontSize', 14);
    end
    hold on
    m_gshhs_h('color', 'k');
    m_gshhs('fr', 'color', 'g', 'linewidth', 1)
    m_pcolor(grd.lonp, grd.latp, Qv .* grd.maskp);
    shading interp
    caxis([-250 250])
    colormap(sb((ii-1)*3+2), cm4jet);
    [cs, h] = m_contour(grd.lonr, grd.latr, zeta, [0.17, 0.4, 0.6], ...
        'color', 'k', 'linewidth', 1.5);
    clabel(cs, h, 'fontsize', 10, 'fontname', 'Helvetica', 'labelspacing', 500);
    switch (ii-1)*3+2
        case 1
            yl(cyl) = ylabel('Apr', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
            title('Transport U', 'fontsize', 14, 'fontname', 'Helvetica')
        case 2
            title('Transport V', 'fontsize', 14, 'fontname', 'Helvetica')
        case 3
            title('Transport Vector', 'fontsize', 14, 'fontname', 'Helvetica')
        case 4
            yl(cyl) = ylabel('Aug', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 7
            cb = colorbar('SouthOutside');
            cb.FontName = 'Times New Roman';
            cb.FontSize = 14;
            yl(cyl) = ylabel('Dec', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case {8, 9}
            cb = colorbar('SouthOutside');
            cb.FontName = 'Times New Roman';
            cb.FontSize = 14;
    end
    
    
    sb((ii-1)*3+3) = subplot(4,3,(ii-1)*3+3);
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    switch (ii-1)*3+3
        case {1, 4}
            m_grid('xticklabel', (''), 'ytick', 24:2:30,'FontName', 'Helvetica', 'FontSize', 14);
        case {7}
            m_grid('ytick', 24:2:30,'FontName', 'Helvetica', 'FontSize', 14);
        case {2, 3, 5, 6}
            m_grid('xticklabel', (''), 'yticklabel', (''), 'FontName', 'Helvetica', 'FontSize', 14);
        case {8, 9}
            m_grid('yticklabel', (''), 'FontName', 'Helvetica', 'FontSize', 14);
    end
    hold on
    m_gshhs_h('color', 'k');
    m_gshhs('fr', 'color', 'g', 'linewidth', 1)
    m_pcolor(grd.lonp, grd.latp, Qz .* grd.maskp);
    shading interp
    
    dh = 75;
    scale_ = 0.75;
    lon_ = grd.lonp(1:dh:end, 1:dh:end);
    lat_ = grd.latp(1:dh:end, 1:dh:end);
    % min-max normalization
    u_ = Qu(1:dh:end, 1:dh:end);
    v_ = Qv(1:dh:end, 1:dh:end);
    [sx, sy] = size(u_);
    for s1 = 1:sx
        for s2 = 1:sy
            vector_ = [abs(u_(s1, s2)), abs(v_(s1, s2))];
            max_ = max(vector_);
            UU(s1, s2) = u_(s1, s2) / max_;
            VV(s1, s2) = v_(s1, s2) / max_;
        end
    end
    m_quiver(lon_, lat_, UU, VV, scale_, 'color', [126, 125, 128]/255, 'linewidth', 1);
    caxis([0 400])
    cmap = cm4jet_;
    cmap(1,:) = [1 1 1];
    colormap(sb((ii-1)*3+3), cmap);
    [cs, h] = m_contour(grd.lonr, grd.latr, zeta, [0.17, 0.4, 0.6], ...
        'color', 'k', 'linewidth', 1.5);
    clabel(cs, h, 'fontsize', 10, 'fontname', 'Helvetica', 'labelspacing', 500);
    switch (ii-1)*3+3
        case 1
            yl(cyl) = ylabel('Apr', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
            title('Transport U', 'fontsize', 14, 'fontname', 'Helvetica')
        case 2
            title('Transport V', 'fontsize', 14, 'fontname', 'Helvetica')
        case 3
            title('Transport Vector', 'fontsize', 14, 'fontname', 'Helvetica')
        case 4
            yl(cyl) = ylabel('Aug', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 7
            cb = colorbar('SouthOutside');
            cb.FontName = 'Times New Roman';
            cb.FontSize = 14;
            yl(cyl) = ylabel('Dec', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case {8, 9}
            cb = colorbar('SouthOutside');
            cb.FontName = 'Times New Roman';
            cb.FontSize = 14;
    end
end
yl(1).Position(1) = - 0.19;
yl(2).Position(1) = - 0.19;
yl(3).Position(1) = - 0.19;

set(gcf, 'position', [1,41,1920,1083])
    
pos = get(sb(2), 'position')
pos(1) = 0.34;
set(sb(2), 'position', pos)
pos = get(sb(3), 'position')
pos(1) = 0.55;
set(sb(3), 'position', pos)

pos = get(sb(4), 'position')
pos(2) = 0.58;
set(sb(4), 'position', pos)
pos = get(sb(5), 'position')
pos(1) = 0.34;
pos(2) = 0.58;
set(sb(5), 'position', pos)
pos = get(sb(6), 'position')
pos(1) = 0.55;
pos(2) = 0.58;
set(sb(6), 'position', pos)

pos = get(sb(7), 'position')
pos(2) = 0.39;
pos(3) = 0.2134;
pos(4) = 0.1577;
set(sb(7), 'position', pos)
pos = get(sb(8), 'position')
pos(1) = 0.34;
pos(2) = 0.39;
pos(3) = 0.2134;
pos(4) = 0.1577;
set(sb(8), 'position', pos)
pos = get(sb(9), 'position')
pos(1) = 0.55;
pos(2) = 0.39;
pos(3) = 0.2134;
pos(4) = 0.1577;
set(sb(9), 'position', pos)

print('-djpeg', '-r300', ...
    ['./Figure_06_4812_transport_', ...
    num2str(target_year), '_', ens, '_SP_100to200m'])   