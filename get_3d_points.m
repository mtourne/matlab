function [ points2d, points3d ] = get_3d_points(K, depth_img, height, width)
    points2d = NaN(3, height * width);
    points3d = NaN(4, height * width);
    fx = K(1,1);
    cx = K(1,3);
    fy = K(2,2);
    cy = K(2,3);
    % height (i) is y axis
    % width  (j) is x axis
    position = 1;
    for i = 1:height
        for j = 1:width
            depth = depth_img(i, j);
            if depth == 0
                continue;
            end
            point2d = [ j; i; 1 ];
            % similar to K^-1 * (point2d, z(point))
            point3d = [(j - cx)/fx ; (i - cy)/fy; 1; 0] .* depth;
            %point3d = [(j - cx)/fx ; (i - cy)/fy; depth; 0];
            point3d(4) = 1;
            points2d(:, position) = point2d;
            points3d(:, position) = point3d;
            position = position + 1;
        end
    end
    % drop all the NaNs at the end
    points2d = points2d(:,1:position-1);
    points3d = points3d(:,1:position-1);
end