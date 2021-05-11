% Chart.
% name - chart name.
% x_arr - variable parameter.
% y_arr - indicators.
% l_arr - which charts to build.
% l_mask - mask for the legend.
% type - chart type
%   0 - normal
%   1 - logarithmic scale
%   2 - normal with relative increases in values 
function [fig] = fn_plot(name, x_arr, y_arr, l_arr, l_mask, type)
    % Dimension of indicators.
    d = size(size(y_arr), 2);
    % 
    n_size = size(l_arr, 1);
    % 
    x_size = size(x_arr, 2);
    %
    if n_size == 1 && d == 2
        % Legend.
        l_size = size(l_arr, 2);
        legend_name = cell(1, l_size);
        for i = 1:l_size
            legend_name{1,i} = sprintf(l_mask, l_arr(i));
        end
        y_plot = y_arr(l_arr,:);
    elseif n_size > 1 && d == 3
        l_size = size(l_arr, 2);
        % Legend.
        legend_name = cell(1, l_size);
        y_plot = zeros(l_size, x_size);
        for i = 1:l_size
            legend_name{1,i} = sprintf(l_mask, l_arr(1, i), l_arr(2, i));
            y_plot(i,:) = y_arr(l_arr(1, i), l_arr(2, i), :);
        end
    else
        fprintf('Dimension error.\n');
        return;
    end

    fig = figure;
    if type == 0
        plot(x_arr, y_plot);
    elseif type == 1
        semilogy(x_arr, y_plot);
    elseif type == 2
        for i = x_size:-1:1
            y_plot(:,i) = y_plot(:,i) ./ y_plot(:,1) - 1.0;
        end
        plot(x_arr, y_plot);
    end
    title(name);
    grid on;
    legend(legend_name, 'Location', 'NorthEast');
    xlim([x_arr(1), x_arr(end)]);
end