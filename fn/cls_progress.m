% Progress bar.
classdef cls_progress < handle
    properties
        len = 0;
        n_all = 0;
        n = 0;
%         f;
    end
    methods
        % Начало прогресса.
        % str - строка для печати.
        % n_all - всего шагов.
        function obj = beg(obj, str, n_all)
            fprintf('%s\n', str);
            obj.len = 0;
            obj.n_all = n_all;
            obj.n = 0;
            tic;
%             % waitbar.
%             obj.f = waitbar(0, str, 'Name', str);
        end
        
        % Завершение прогресса.
        function obj = end(obj)
            for i = 1:obj.len
                fprintf('\b');
            end
            fprintf('Done for %ds.\n', round(toc));
%             % waitbar.
%             close(obj.f);
        end
        
        % Печать прогресса.
        function obj = print(obj)
            for i = 1:obj.len
                fprintf('\b');
            end
            obj.n = obj.n + 1;
            obj.len = fprintf('\tprogress: %d%%, time left: %ds', round(obj.n * 100 / obj.n_all), round(toc * (obj.n_all - obj.n) / obj.n));
%             % waitbar.
%             p = obj.n / obj.n_all;
%             waitbar(p, obj.f, sprintf('%d%% (time left: %ds)', round(p * 100), round(toc * (obj.n_all - obj.n) / obj.n)));
        end
    end
end