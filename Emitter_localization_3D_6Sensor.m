clear
clc
close all;

result_x = 0;
result_y = 0;
result_z = 0;
sum_square = 0;
counter = 0;

number_of_iteration = 100;

s = 0.5;    %nosise standart sapması

x_position_of_sensors = [10, 10, 46, 58, 31, 69];

y_position_of_sensors = [20, 14, 31, 16, 69, 31];

z_position_of_sensors = [50, 58, 67, 37, 87, 42];

position_of_emitter = [70, 40, 40];

error_function = zeros(100, 100);

for c = 1:1:number_of_iteration
    

gaussian_noise = s*randn(1,1);

d1_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(1))^2 + (position_of_emitter(2) - y_position_of_sensors(1))^2 + (position_of_emitter(3) - z_position_of_sensors(1))^2);
d2_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(2))^2 + (position_of_emitter(2) - y_position_of_sensors(2))^2 + (position_of_emitter(3) - z_position_of_sensors(2))^2);
d3_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(3))^2 + (position_of_emitter(2) - y_position_of_sensors(3))^2 + (position_of_emitter(3) - z_position_of_sensors(3))^2);
d4_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(4))^2 + (position_of_emitter(2) - y_position_of_sensors(4))^2 + (position_of_emitter(3) - z_position_of_sensors(4))^2);
d5_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(5))^2 + (position_of_emitter(2) - y_position_of_sensors(5))^2 + (position_of_emitter(3) - z_position_of_sensors(5))^2);
d6_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(6))^2 + (position_of_emitter(2) - y_position_of_sensors(6))^2 + (position_of_emitter(3) - z_position_of_sensors(6))^2);



actual_power_difference_12 = (5 * 2 * log10(d2_actual/d1_actual));
actual_power_difference_13 = (5 * 2 * log10(d3_actual/d1_actual));
actual_power_difference_14 = (5 * 2 * log10(d4_actual/d1_actual));
actual_power_difference_23 = (5 * 2 * log10(d3_actual/d2_actual));
actual_power_difference_24 = (5 * 2 * log10(d4_actual/d2_actual));
actual_power_difference_34 = (5 * 2 * log10(d4_actual/d3_actual));

actual_power_difference_15 = (5 * 2 * log10(d5_actual/d1_actual));
actual_power_difference_16 = (5 * 2 * log10(d6_actual/d1_actual));
actual_power_difference_25 = (5 * 2 * log10(d5_actual/d2_actual));
actual_power_difference_26 = (5 * 2 * log10(d6_actual/d2_actual));
actual_power_difference_35 = (5 * 2 * log10(d5_actual/d3_actual));
actual_power_difference_36 = (5 * 2 * log10(d6_actual/d3_actual));
actual_power_difference_45 = (5 * 2 * log10(d5_actual/d4_actual));
actual_power_difference_46 = (5 * 2 * log10(d6_actual/d4_actual));
actual_power_difference_56 = (5 * 2 * log10(d6_actual/d5_actual));


% 
% min_row = 0;
% min_col = 0;




for i = 1:1:100
    for j = 1:1:100
        for k = 1:1:100
        
            % Her bir sensör ile emitter arasındaki mesafeyi hesaplayın
            d1 = sqrt((i - x_position_of_sensors(1))^2 + (j - y_position_of_sensors(1))^2 + (k - z_position_of_sensors(1))^2);
            d2 = sqrt((i - x_position_of_sensors(2))^2 + (j - y_position_of_sensors(2))^2 + (k - z_position_of_sensors(2))^2);
            d3 = sqrt((i - x_position_of_sensors(3))^2 + (j - y_position_of_sensors(3))^2 + (k - z_position_of_sensors(3))^2);
            d4 = sqrt((i - x_position_of_sensors(4))^2 + (j - y_position_of_sensors(4))^2 + (k - z_position_of_sensors(4))^2);
            d5 = sqrt((i - x_position_of_sensors(5))^2 + (j - y_position_of_sensors(5))^2 + (k - z_position_of_sensors(5))^2);
            d6 = sqrt((i - x_position_of_sensors(6))^2 + (j - y_position_of_sensors(6))^2 + (k - z_position_of_sensors(6))^2);
            
            actual_power_difference_with_noise_12 = actual_power_difference_12 + gaussian_noise;
            actual_power_difference_with_noise_13 = actual_power_difference_13 + gaussian_noise;
            actual_power_difference_with_noise_14 = actual_power_difference_14 + gaussian_noise;
            actual_power_difference_with_noise_23 = actual_power_difference_23 + gaussian_noise;
            actual_power_difference_with_noise_24 = actual_power_difference_24 + gaussian_noise;
            actual_power_difference_with_noise_34 = actual_power_difference_34 + gaussian_noise;
            
            actual_power_difference_with_noise_15 = actual_power_difference_15 + gaussian_noise;
            actual_power_difference_with_noise_16 = actual_power_difference_16 + gaussian_noise;
            actual_power_difference_with_noise_25 = actual_power_difference_25 + gaussian_noise;
            actual_power_difference_with_noise_26 = actual_power_difference_26 + gaussian_noise;
            actual_power_difference_with_noise_35 = actual_power_difference_35 + gaussian_noise;
            actual_power_difference_with_noise_36 = actual_power_difference_36 + gaussian_noise;
            actual_power_difference_with_noise_45 = actual_power_difference_45 + gaussian_noise;
            actual_power_difference_with_noise_46 = actual_power_difference_46 + gaussian_noise;
            actual_power_difference_with_noise_56 = actual_power_difference_56 + gaussian_noise;
            
            % Hata fonksiyonunu hesaplayın
            error_function(i, j, k) = ...
            ((actual_power_difference_with_noise_12 - (5 * 2 * log10(d2/d1)))^2 + ...
        (actual_power_difference_with_noise_23 - (5 * 2 * log10(d3/d2)))^2 + ...
        (actual_power_difference_with_noise_13 - (5 * 2 * log10(d3/d1)))^2 + ...
        (actual_power_difference_with_noise_14 - (5 * 2 * log10(d4/d1)))^2 + ...
        (actual_power_difference_with_noise_24 - (5 * 2 * log10(d4/d2)))^2 + ...
        (actual_power_difference_with_noise_34 - (5 * 2 * log10(d4/d3)))^2 + ...
        (actual_power_difference_with_noise_15 - (5 * 2 * log10(d5/d1)))^2 +...
        (actual_power_difference_with_noise_16 - (5 * 2 * log10(d6/d1)))^2 + ...
        (actual_power_difference_with_noise_25 - (5 * 2 * log10(d5/d2)))^2 + ...
        (actual_power_difference_with_noise_26 - (5 * 2 * log10(d6/d2)))^2 +...
        (actual_power_difference_with_noise_35 - (5 * 2 * log10(d5/d3)))^2 + ...
        (actual_power_difference_with_noise_36 - (5 * 2 * log10(d6/d3)))^2 +...
        (actual_power_difference_with_noise_45 - (5 * 2 * log10(d5/d4)))^2 +...
        (actual_power_difference_with_noise_46 - (5 * 2 * log10(d6/d4)))^2 +...
        (actual_power_difference_with_noise_56 - (5 * 2 * log10(d6/d5)))^2 ); 
        
        end
    end
  
end

counter = counter + 1;

% Hata matrisinin minimum değerini ve pozisyonunu bulun
[min_error, min_idx] = min(error_function(:));
[min_row, min_col , slices] = ind2sub(size(error_function), min_idx);

fprintf('En küçük hata değeri: %f\n', min_error);
fprintf('%d-)Bu değer %d satırında, %d sütununda ve %d sırasında bulunuyor.\n',counter, min_row, min_col, slices);
   


  result_x =  result_x + min_row;
  result_y = result_y + min_col;
  result_z = result_z + slices;
  
  
  rowM(c) = min_row;
  colM(c) = min_col;
  slicesM(c) = slices;
  
  distance = sqrt( (position_of_emitter(1) - min_row)^2 + (position_of_emitter(2) - min_col)^2 + (position_of_emitter(3) - slices)^2);
  sum_square = sum_square + (distance^2);
end

   total_result_x = result_x/number_of_iteration;
   total_result_y = result_y/number_of_iteration;
   total_result_z = result_z/number_of_iteration;
   
   mean_squared_error = sum_square/number_of_iteration;

fprintf('Mean Squared Error: %f.\n', mean_squared_error);


   %distance = sqrt( (position_of_emitter(1) - total_result_x)^2 + (position_of_emitter(2) - total_result_y)^2 + (position_of_emitter(3) - total_result_z)^2);
   
   %fprintf('\nFinal değeri %f satırında, %f sütununda ve %f sırasında bulunuyor.\n\n', total_result_x, total_result_y, total_result_z);
   %fprintf('Gerçek konum ve tahmini konum arası mesafe: %f.\n', distance);
   
   
   % Create a 3D scatter plot
figure(1);
scatter3(x_position_of_sensors(1), y_position_of_sensors(1), z_position_of_sensors(1), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor1');
hold on;
scatter3(x_position_of_sensors(2), y_position_of_sensors(2), z_position_of_sensors(2), 'Marker', 'o', 'MarkerFaceColor', 'b' , 'DisplayName', 'Sensor2');
scatter3(x_position_of_sensors(3), y_position_of_sensors(3), z_position_of_sensors(3), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor3');
scatter3(x_position_of_sensors(4), y_position_of_sensors(4), z_position_of_sensors(4), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor4');
scatter3(x_position_of_sensors(5), y_position_of_sensors(5), z_position_of_sensors(5), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor5');
scatter3(x_position_of_sensors(6), y_position_of_sensors(6), z_position_of_sensors(6), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor6');

%scatter3(total_result_x, total_result_y, total_result_z, 'Marker', '^', 'MarkerFaceColor', 'y', 'DisplayName', 'Estimated location');

scatter3 (position_of_emitter(1), position_of_emitter(2), position_of_emitter(3), 'Marker', 'o', 'MarkerFaceColor', 'm', 'DisplayName', 'Emitter', 'SizeData', 100);

axis([0 100 0 100 0 100]);
scatter3(rowM, colM, slicesM, 'Marker', 'o', 'MarkerFaceColor', 'g', 'DisplayName', 'points');
% Customize the plot

xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend();
grid on;

figure(2);
scatter3(x_position_of_sensors(1), y_position_of_sensors(1), z_position_of_sensors(1), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor1');
hold on;
scatter3(x_position_of_sensors(2), y_position_of_sensors(2), z_position_of_sensors(2), 'Marker', 'o', 'MarkerFaceColor', 'b' , 'DisplayName', 'Sensor2');
scatter3(x_position_of_sensors(3), y_position_of_sensors(3), z_position_of_sensors(3), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor3');
scatter3(x_position_of_sensors(4), y_position_of_sensors(4), z_position_of_sensors(4), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor4');
scatter3(x_position_of_sensors(5), y_position_of_sensors(5), z_position_of_sensors(5), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor5');
scatter3(x_position_of_sensors(6), y_position_of_sensors(6), z_position_of_sensors(6), 'Marker', 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Sensor6');

scatter3(total_result_x, total_result_y, total_result_z, 'Marker', '^', 'MarkerFaceColor', 'y', 'DisplayName', 'Estimated location');

scatter3 (position_of_emitter(1), position_of_emitter(2), position_of_emitter(3), 'Marker', 'o', 'MarkerFaceColor', 'm', 'DisplayName', 'Emitter', 'SizeData', 100);

axis([0 100 0 100 0 100]);
% scatter3(rowM, colM, slicesM, 'Marker', 'o', 'MarkerFaceColor', 'g', 'DisplayName', 'points');
% Customize the plot

xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend();
grid on;