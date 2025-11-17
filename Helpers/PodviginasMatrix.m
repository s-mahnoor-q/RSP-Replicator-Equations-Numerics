%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% conditions_satisfied = PodviginasMatrix(fullTransitionMatrix, gridResolution, showEachCondition,
% colour)
% 
% Evaluate the fullTransitionMatrix at each point in parameter space at a
% resolution of gridResolution. Use this transition matrix to evaluate the
% conditions of Podvigina's Theorem of f.a.s. of heteroclinic cycle. if
% showEachCondition is true, it will generate plots showing in which parts
% of the parameter space each condition is satisfied. 'colour' is a vector
% [r g b] containing the rgb values for the colour of the region, where
% 0<=r,g,b<=1. 'conditions_satisfied' is a matrix which is 1 where the theorem is
% satisfied in parameter space, and 0 otherwise.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function conditions_satisfied = PodviginasMatrix(M, resolution, showEachCondition, colour)
    % M: full transition matrix
    % resolution: number of steps in eps_range
    % showEachCondition: create heatmaps of each of the three conditions
    eps_range = linspace(-1,1,resolution);
    eps_range = eps_range(2:end-1); %don't include endpoints because we will get NaNs in the matrix
        a=linspace(-1,1,11);

    condition_1 = zeros(length(eps_range));
    condition_2_data = zeros(length(eps_range));
    condition_3 = zeros(length(eps_range));
    
    x_axis = length(eps_range):-1:1;

    condition_true_colour = [0 0.8 0.5];
    condition_false_colour = [0.9 0.1 0.1];

    %we want to see when Podvigina's Lemma applies, in the ex-ey space
    for i=1:length(eps_range)
        for j=length(eps_range):-1:1
            ex=eps_range(i); ey=eps_range(j);
            [V,D] = eig(M(ex, ey));
            eigenvalues = diag(D);
            % eigenvalues
            
            [lambda_max,idx] = max(abs(eigenvalues));
            % lambda_max
            % idx
            w_max = V(:,idx);
    
            %IMPORTANT NOTE: the first index is i=1,j=8, corresponding to 
            %the top left entry in ex-ey space, (-0.99,0.99) ish space. this
            %should be in the top left (1,1) entry of the condition matrices...
            %There's probably a better way to index these things lol
    
            %as we go onto the next j (the next ey/row value for some given
            %column ex)
            j_flipped = x_axis(j);
            %if it doesn't make sense, uncomment this and SEEEE
            % fprintf('i:%d j:%d, ex:%.2f ey:%.2f, (%d,%d)\n', i,j,eps_range(i), eps_range(j), i,j_flipped);
    
            %condition 1: is lambda_max real?
            condition_1(j_flipped,i) = isreal(lambda_max);
    
            %condition 2: is lambda_max greater than 1?
            condition_2_data(j_flipped,i) = abs(eigenvalues(idx));
    
            %condition 3: are all entries of w_max non-zero and the same sign?
            %may get a little iffy when lambda is VERY close to 0....
            % w_max
            if isempty(find(w_max==0,1))
                if all(w_max > 0)
                    condition_3(j_flipped,i) = true;
                elseif all(w_max < 0)
                    condition_3(j_flipped,i) = true;
                else
                    condition_3(j_flipped,i) = false;
                end
            end
        end
    end
    condition_2 = condition_2_data > 1;
    conditions_satisfied = double(condition_1 & condition_2 & condition_3);
    
    if (showEachCondition)
        figure('Position',[10 360 400 350]); 
        not_condition_1 = not(condition_1);
        condition_1_img = zeros(resolution-2, resolution-2, 3);
        condition_1_img(:,:,1) = condition_1_img(:,:,1)+ condition_1 * condition_true_colour(1) + not_condition_1 * condition_false_colour(1);  % Red channel
        condition_1_img(:,:,2) = condition_1_img(:,:,2) + condition_1 * condition_true_colour(2)+ not_condition_1 * condition_false_colour(2);  % Green channel
        condition_1_img(:,:,3) = condition_1_img(:,:,3) + condition_1 * condition_true_colour(3)+ not_condition_1 * condition_false_colour(3);  % Blue channel
        imagesc(condition_1_img); 
        xlabel('$\epsilon_x$', Interpreter='latex',FontSize=20)
        ylabel('$\epsilon_y$', Interpreter='latex',FontSize=20)
        title("Condition 1: is $\lambda_{\\max}$ real?", ...
            'Interpreter','latex')
        set(gca, 'xTickLabel', a(2:end-1)); 
        set(gca, 'yTickLabel', flip(a(2:end-1)))

        figure('Position',[410 360 400 350]); 
        not_condition_2 = not(condition_2);
        condition_2_img = zeros(resolution-2, resolution-2, 3);
        condition_2_img(:,:,1) = condition_2_img(:,:,1) + condition_2 * condition_true_colour(1)+ not_condition_2 * condition_false_colour(1);  % Red channel
        condition_2_img(:,:,2) = condition_2_img(:,:,2) + condition_2 * condition_true_colour(2)+ not_condition_2 * condition_false_colour(2);  % Green channel
        condition_2_img(:,:,3) = condition_2_img(:,:,3) + condition_2 * condition_true_colour(3)+ not_condition_2 * condition_false_colour(3);  % Blue channel
        imagesc(condition_2_img);
        xlabel('$\epsilon_x$', Interpreter='latex',FontSize=20)
        ylabel('$\epsilon_y$', Interpreter='latex',FontSize=20)
        title("Condition 2: is $\lambda_{\\max}>1$?", ...
            'Interpreter','latex')
        set(gca, 'xTickLabel', a(2:end-1)); 
        set(gca, 'yTickLabel', flip(a(2:end-1)))

        figure('Position',[10 10 400 350]); 
        not_condition_3=not(condition_3);
        condition_3_img = zeros(resolution-2, resolution-2, 3);
        condition_3_img(:,:,1) = condition_3_img(:,:,1) + condition_3 * condition_true_colour(1)+ not_condition_3 * condition_false_colour(1);  % Red channel
        condition_3_img(:,:,2) = condition_3_img(:,:,2) + condition_3 * condition_true_colour(2)+ not_condition_3 * condition_false_colour(2);  % Green channel
        condition_3_img(:,:,3) = condition_3_img(:,:,3) + condition_3 * condition_true_colour(3)+ not_condition_3 * condition_false_colour(3);  % Blue channel
        imagesc(condition_3_img);
        xlabel('$\epsilon_x$', Interpreter='latex',FontSize=20)
        ylabel('$\epsilon_y$', Interpreter='latex',FontSize=20)
        title("Condition 3: are all entries of $w_{\\max}$ nonzero and the same sign?", ...
            'Interpreter','latex');
        set(gca, 'xTickLabel', a(2:end-1)); 
        set(gca, 'yTickLabel', flip(a(2:end-1)))

    end

    figure('Position',[410 10 400 350]); 
    rgbImage = zeros(resolution-2, resolution-2, 3);
    not_cs = not(conditions_satisfied);
    rgbImage(:,:,1) = conditions_satisfied * colour(1) + not_cs;  % Red channel
    rgbImage(:,:,2) = conditions_satisfied * colour(2) + not_cs;  % Green channel
    rgbImage(:,:,3) = conditions_satisfied * colour(3) + not_cs;  % Blue channel
    im = imagesc(rgbImage);
    title('Regions of stability')
    xlabel('$\epsilon_x$', Interpreter='latex',FontSize=20)
    ylabel('$\epsilon_y$', Interpreter='latex',FontSize=20)
    set(gca, 'xTickLabel', a(2:end-1)); 
    set(gca, 'yTickLabel', flip(a(2:end-1)))
end