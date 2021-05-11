% Building a graph.
% name - graph name.
% edg1, edg2 - graph edge ends.
% node_val - values in nodes.
% edge_val - values on edges.
function [fig] = fn_graph_all(name, edg1, edg2, node_val, edge_val)
    % We normalize the values depending on the parameters.
    node_max = max(node_val);
    edge_max = max(edge_val);
    val_max = max(node_max, edge_max);
    node_weight = node_val / val_max;
    edge_weight = edge_val / val_max;
    n_node = size(node_weight, 1);
    n_edge = size(edge_weight, 1);
    % Color list.
    n_color = 256;
    c_arr = jet(n_color);
    % Graph.
    fig = figure;
    g = graph(edg1, edg2);
    h = plot(g, 'Layout', 'force', 'UseGravity', true, 'LineWidth', 5, 'EdgeAlpha', 1.0);
    % Loop through all nodes.
    for i = 1:n_node
        node_color = round(node_weight(i) * n_color);
        if node_color < 1
            node_color = 1;
        elseif node_color > n_color
            node_color = n_color;
        end
        highlight(h, i, 'NodeColor', c_arr(node_color,:));
        highlight(h, i, 'MarkerSize', 22);
        % Рисуем номера внутри узлов.
        if node_weight(i) > 0.25 &&  node_weight(i) < 0.8
            node_label_color = [0 0 0];
        else
            node_label_color = [1 1 1];
        end
        text(h.XData(i), h.YData(i) + .05, h.NodeLabel(i), 'Color', node_label_color, 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');
    end
    % Delete old numbers.
    h.NodeLabel = {};
    % Loop through all edges.
    for i = 1:n_edge
        edge_color = round(edge_weight(i) * n_color);
        if edge_color < 1
            edge_color = 1;
        elseif edge_color > n_color
            edge_color = n_color;
        end
        highlight(h, [edg1(i), edg2(i)], 'EdgeColor', c_arr(edge_color,:));
    end
    title(name);
    colormap(c_arr)
    % Setting up color bar.
    cb = colorbar;
    cb.FontSize = 14;
    cb.FontWeight = 'bold';
    cb.XTick = [0, 0.25, 0.5, 0.75, 1];
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
        cb.XTickLabel(end+1) = {num2str(cb.XTick(i) * val_max, format)};
    end
    set(fig, 'Position', get(0, 'Screensize'));
end