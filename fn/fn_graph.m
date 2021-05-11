% Building a graph.
% name - graph name.
% edg1, edg2 - graph edge ends.
% node_val - values in nodes.
% node_max - maximum value.
%    not specified or NaN - maximum of node_val.
% node_min - minimum value.
%    not specified - node_min = 0.
%    NaN - minimum of node_val.
function [fig] = fn_graph(name, edg1, edg2, node_val, node_max, node_min)
    % We normalize the values depending on the parameters.
    if nargin < 5 || isnan(node_max)
        node_max = max(node_val);
    end
    if nargin < 6
        node_min = 0;
    elseif isnan(node_min)
        node_min = min(node_val);
    end
    weight = (node_val - node_min) / (node_max - node_min);
    n = size(weight, 1);
    % Color list.
    n_color = 256;
    c_arr = jet(n_color);
    % Graph.
    fig = figure;
    g = graph(edg1, edg2);
    h = plot(g, 'Layout', 'force', 'UseGravity', true, 'LineWidth', 3, 'EdgeColor', 'black');
    % Loop through all nodes.
    for i = 1:n
        node_color = round(weight(i) * n_color);
        if node_color < 1
            node_color = 1;
        elseif node_color > n_color
            node_color = n_color;
        end
        highlight(h, i, 'NodeColor', c_arr(node_color,:));
        highlight(h, i, 'MarkerSize', 22);
        % Draw numbers inside the nodes.
        if weight(i) > 0.25 &&  weight(i) < 0.8
            node_label_color = [0 0 0];
        else
            node_label_color = [1 1 1];
        end
        text(h.XData(i), h.YData(i) + .05, h.NodeLabel(i), 'Color', node_label_color, 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');
    end
    % Delete old numbers.
    h.NodeLabel = {};
    title(name);
    colormap(c_arr)
    % Setting up color bar.
    cb = colorbar;
    cb.FontSize = 14;
    cb.FontWeight = 'bold';
    if node_min < 0 && node_max > 0
        cb.XTick = sort([0, 0.25, 0.5, 0.75, 1, -node_min / (node_max - node_min)]);
    else
        cb.XTick = [0, 0.25, 0.5, 0.75, 1];
    end
    cb.XTickLabel = {};
    if node_max >= 1000
        format = '%.0f';
    elseif node_max >= 100
        format = '%.1f';
    elseif node_max >= 10
        format = '%.2f';
    else
        format = '%.3f';
    end
    for i = 1:size(cb.XTick,2)
        cb.XTickLabel(end+1) = {num2str(cb.XTick(i) * (node_max - node_min) + node_min, format)};
    end
    set(fig, 'Position', get(0, 'Screensize'));
end