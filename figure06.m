%% note, because of naming systme, sometimes passive and active are in wrong position.
warning('off','all')
cd 'I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME';
HOME_DIR = ['I:\Dropbox (GaTech)\Win10\GL_RIVER_HOME\'];

%% step 1. load grid file
file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
file_grd_mr = [HOME_DIR, 'Data_River\GoM3p5km_Grd.nc'];
grdSP = load_roms_grid(file_grd_sp);
grdMR = load_roms_grid(file_grd_mr);

minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;
ori_time = datenum('2013-01-01');
hsp = grdSP.h;
hmr = grdMR.h;

nn=24;
[path, folder] = find_data_path('ens5-N-1', 'SP');
file = [path, 'GOM', '1km', '_rst.', sprintf('%5.5d', nn), '.nc'];
time = ori_time + ncread(file, 'scrum_time')/24/3600;
datestr(time)
%% calculate density field rho
vlevel = 70;
coef = 1;
[~, ~, ~, rho] = get_rho(file, file_grd_sp, 1, vlevel, coef);
rho = real(rho - 1000)';
%% calculate the vector of density gradient
grd = grdSP;
u = ncread(file, 'u', [1 1 70 1], [Inf Inf 1 1]);
v = ncread(file, 'v', [1 1 70 1], [Inf Inf 1 1]);
salt = ncread(file, 'salt', [1 1 70 1], [Inf Inf 1 1]);
data1 = calc_gradientR(salt, grd.pm, grd.pn);
data1 = salt;
data2 = calc_Ftendency(rho, u, v, grd);

[path, folder] = find_data_path('ens5-P-1', 'SP');
file = [path, 'GOM', '1km', '_rst.', sprintf('%5.5d', nn), '.nc'];
time = ori_time + ncread(file, 'scrum_time')/24/3600;
datestr(time)
%% calculate density field rho
vlevel = 70;
coef = 1;
[~, ~, ~, rho] = get_rho(file, file_grd_sp, 1, vlevel, coef);
rho = real(rho - 1000)';
%% calculate the vector of density gradient
grd = grdSP;
u = ncread(file, 'u', [1 1 70 1], [Inf Inf 1 1]);
v = ncread(file, 'v', [1 1 70 1], [Inf Inf 1 1]);
salt = ncread(file, 'salt', [1 1 70 1], [Inf Inf 1 1]);
data3 = calc_gradientR(salt, grd.pm, grd.pn);
data3 = salt;
data4 = calc_Ftendency(rho, u, v, grd);

[path, folder] = find_data_path('ens5-A-1', 'SP');
file = [path, 'GOM', '1km', '_rst.', sprintf('%5.5d', nn), '.nc'];
time = ori_time + ncread(file, 'scrum_time')/24/3600;
datestr(time)
%% calculate density field rho
vlevel = 70;
coef = 1;
[~, ~, ~, rho] = get_rho(file, file_grd_sp, 1, vlevel, coef);
rho = real(rho - 1000)';
%% calculate the vector of density gradient
grd = grdSP;
u = ncread(file, 'u', [1 1 70 1], [Inf Inf 1 1]);
v = ncread(file, 'v', [1 1 70 1], [Inf Inf 1 1]);
salt = ncread(file, 'salt', [1 1 70 1], [Inf Inf 1 1]);
data5 = calc_gradientR(salt, grd.pm, grd.pn);
data5 = salt;
data6 = calc_Ftendency(rho, u, v, grd);

[path, folder] = find_data_path('ens5-P-1', 'MR');
file = [path, 'GOM', '3p5km', '_rst.', sprintf('%5.5d', nn), '.nc'];
time = ori_time + ncread(file, 'scrum_time')/24/3600;
datestr(time)
%% calculate density field rho
vlevel = 70;
coef = 1;
[~, ~, ~, rho] = get_rho(file, file_grd_mr, 1, vlevel, coef);
rho = real(rho - 1000)';
%% calculate the vector of density gradient
grd = grdMR;
u = ncread(file, 'u', [1 1 70 1], [Inf Inf 1 1]);
v = ncread(file, 'v', [1 1 70 1], [Inf Inf 1 1]);
salt = ncread(file, 'salt', [1 1 70 1], [Inf Inf 1 1]);
data7 = calc_gradientR(salt, grd.pm, grd.pn);
data7 = salt;
data8 = calc_Ftendency(rho, u, v, grd);

[path, folder] = find_data_path('ens5-A-1', 'MR');
file = [path, 'GOM', '3p5km', '_rst.', sprintf('%5.5d', nn), '.nc'];
time = ori_time + ncread(file, 'scrum_time')/24/3600;
datestr(time)
%% calculate density field rho
vlevel = 70;
coef = 1;
[~, ~, ~, rho] = get_rho(file, file_grd_mr, 1, vlevel, coef);
rho = real(rho - 1000)';
%% calculate the vector of density gradient
grd = grdMR;
u = ncread(file, 'u', [1 1 70 1], [Inf Inf 1 1]);
v = ncread(file, 'v', [1 1 70 1], [Inf Inf 1 1]);
salt = ncread(file, 'salt', [1 1 70 1], [Inf Inf 1 1]);
data9 = calc_gradientR(salt, grd.pm, grd.pn);
data9 = salt;
data10 = calc_Ftendency(rho, u, v, grd);

DIR = 'F:\Dropbox (GaTech)\EAS-Bracco-TEAM\dsun42\croco_output\GOM_hycom\';
importfile('Capture.PNG');
rr = cdata(:,15,1);
gg = cdata(:,15,2);
bb = cdata(:,15,3);
cmap = [double(rr(3:end-2))/255, double(gg(3:end-2))/255, double(bb(3:end-2))/255];
cmap = flipud(cmap);
x1 = 1:1:length(cmap);
x2 = 1:(length(cmap)-1)/55:length(cmap);
colmap1 = [interp1(x1', cmap(:,1), x2'), interp1(x1', cmap(:,2), x2'), ...
    interp1(x1', cmap(:,3), x2')];

minlon = -98; maxlon = -82; minlat = 24; maxlat = 30.5;
ttt = {'34.44', '1.4e-14', '32.70', '1.2e-12', '33.28', '8.0e-14', ...
    '32.97', '3.3e-14', '33.56', '1.1e-14'};
figure;
cyl = 1;
for id_ = 1:10
    sb(id_)=subplot(5,2,id_)
    m_proj('miller', 'lon', [minlon, maxlon], 'lat', [minlat, maxlat]);
    switch id_
        case 1
            m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
            yl(cyl) = ylabel('SP-NoRiver', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
            title('Salt', 'Fontname', 'Helvetica', 'FontSize', 14, ...
                'FontWeight', 'Bold')
        case 2
            m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
            title('Frontal tendency', 'Fontname', 'Helvetica', 'FontSize', 14, ...
                'FontWeight', 'Bold')
        case 3
            m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
            yl(cyl) = ylabel('SP-Active', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 5
            m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
            yl(cyl) = ylabel('SP-Passive', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 7
            m_grid('ytick', 24:2:30, 'xticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
            yl(cyl) = ylabel('MR-Active', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 9
            m_grid('ytick', 24:2:30, ...
                'FontName', 'Helvetica', 'FontSize', 14);
            yl(cyl) = ylabel('MR-Passive', 'FontName', 'Helvetica', 'FontSize', 15, ...
                'FontWeight', 'Bold');
            cyl = cyl + 1;
        case 10
            m_grid('ytick', 24:2:30, 'yticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
        otherwise
            m_grid('ytick', 24:2:30, 'xticklabel', '', 'yticklabel', '', ...
                'FontName', 'Helvetica', 'FontSize', 14);
    end
    
    if id_ <= 6
        file_grd_sp = [HOME_DIR, 'Data_River\GoM1km_Grd.nc'];
        grd = load_roms_grid(file_grd_sp);
    else
        file_grd_mr = [HOME_DIR, 'Data_River\GoM3p5km_Grd.nc'];
        grd = load_roms_grid(file_grd_mr);
    end
    
    if ismember(id_, [1,3,5,7,9])
        lon = grd.lonr;
        lat = grd.latr;
        mask = grd.maskr;
        a = 26;
        b = 38;
    else
        lon = grd.lonp;
        lat = grd.latp;
        mask = grd.maskp;
        a = -1e-13;
        b = 1e-13;
    end
    
    eval(['data_ = data', num2str(id_), ';'])
    mean_ = nanmean(nanmean(data_ .* mask));
    m_text(-97.5, 30, ttt{id_}, 'FontName', 'Helvetica', 'FontSize', 12)

    hold on
    m_pcolor(lon, lat, mask .* data_); shading interp;
    m_gshhs_h('color', 'k');
    if ismember(id_, [1,3,5,7,9])
        colormap(sb(id_), colormap(colmap1))
    else
        colormap(sb(id_), colormap(m_colmap('diverging', 64)))
    end
    caxis([a b])
    if ismember(id_, [9, 10])
        cb = colorbar('southoutside');
        cb.FontName = 'Helvetica';
        cb.FontSize = 12;
    end
end
set(gcf, 'position', [1 41 1920 1083])


yl(1).Position(1) = - 0.2;
yl(2).Position(1) = - 0.2;
yl(3).Position(1) = - 0.2;
yl(4).Position(1) = - 0.2;
yl(5).Position(1) = - 0.2;

pos = get(sb(2), 'position')
pos(1) = 0.3;
set(sb(2), 'position', pos);

pos = get(sb(3), 'position')
pos(2) = 0.65;
set(sb(3), 'position', pos);

pos = get(sb(4), 'position')
pos(2) = 0.65;
pos(1) = 0.3;
set(sb(4), 'position', pos);

pos = get(sb(5), 'position')
pos(2) = 0.5;
set(sb(5), 'position', pos);

pos = get(sb(6), 'position')
pos(1) = 0.3;
pos(2) = 0.5;
set(sb(6), 'position', pos);

pos = get(sb(7), 'position')
pos(2) = 0.35;
set(sb(7), 'position', pos);

pos = get(sb(8), 'position')
pos(1) = 0.3;
pos(2) = 0.35;
set(sb(8), 'position', pos);

pos = get(sb(9), 'position')
pos(2) = 0.2;
pos(4) = 0.1243;
set(sb(9), 'position', pos);

pos = get(sb(10), 'position')
pos(1) = 0.3;
pos(2) = 0.2;
pos(4) = 0.1243;
set(sb(10), 'position', pos);
