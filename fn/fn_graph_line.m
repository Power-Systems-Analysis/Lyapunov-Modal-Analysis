% Building a graph.
% name - graph name.
% edg1, edg2 - graph edge ends.
% edge_val - values on edges.
% edge_max - maximum value.
%    not specified or NaN - maximum of edge_val. 
% edge_min - minimum value.
%    not specified - edge_min = 0.
%    NaN - minimum of edge_val.
function [fig] = fn_graph_line(name, edg1, edg2, edge_val, edge_max, edge_min)
    % We normalize the values depending on the parameters.
    if nargin < 5 || isnan(edge_max)
        edge_max = max(edge_val);
    end
    if nargin < 6
        edge_min = 0;
    elseif isnan(edge_min)
        edge_min = min(edge_val);
    end
    weight = (edge_val - edge_min) / (edge_max - edge_min);
    n = size(weight, 1);
    % Color list.
    n_color = 256;
    c_arr = jet(n_color);
    % Graph.
    fig = figure;
    g = graph(edg1, edg2);
%     h = plot(g, 'Layout', 'force', 'UseGravity', true, 'LineWidth', 5, 'EdgeAlpha', 1.0, 'NodeColor', [0.7 0.7 0.7], 'MarkerSize', 22);
    h = plot(g, 'Layout', 'force', 'UseGravity', true, 'EdgeAlpha', 1.0, 'NodeColor', [0 0 0], 'MarkerSize', 5, 'NodeFontSize', 14, 'NodeFontWeight', 'bold');
    % Loop through all edges.
    for i = 1:n
        if weight(i) > 1
            weight(i) = 1;
        end
        edge_color = round(weight(i) * n_color);
        if edge_color < 1
            edge_color = 1;
        elseif edge_color > n_color
            edge_color = n_color;
        end
        highlight(h, [edg1(i), edg2(i)], 'EdgeColor', c_arr(edge_color,:), 'LineWidth', 1 + weight(i) * 4);
    end
%     % Loop through all nodes.
%     node = unique([edg1, edg2]);
%     for i = 1:size(node, 1)
%         node_i = node(i);
%         text(h.XData(node_i), h.YData(node_i) + .05, h.NodeLabel(node_i), 'Color', [0 0 0], 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');
%     end
%     h.NodeLabel = {};
    title(name);
    colormap(c_arr)
    % Setting up color bar.
    cb = colorbar;
    cb.FontSize = 14;
    cb.FontWeight = 'bold';
    if edge_min < 0 && edge_max > 0
        cb.XTick = sort([0, 0.25, 0.5, 0.75, 1, -edge_min / (edge_max - edge_min)]);
    else
        cb.XTick = [0, 0.25, 0.5, 0.75, 1];
    end
    cb.XTickLabel = {};
    if edge_max >= 1000
        format = '%.0f';
    elseif edge_max >= 100
        format = '%.1f';
    elseif edge_max >= 10
        format = '%.2f';
    else
        format = '%.3f';
    end
    for i = 1:size(cb.XTick,2)
        cb.XTickLabel(end+1) = {num2str(cb.XTick(i) * (edge_max - edge_min) + edge_min, format)};
    end
    set(fig, 'Position', get(0, 'Screensize'));
end