clear
clc
close all;

result_x = 0;
result_y = 0;
result_z = 0;

counter = 0;

number_of_iteration = 50;

s = 0.5;    %nosise standart sapması

x_position_of_sensors = [20, 80];

y_position_of_sensors = [40, 50];

z_position_of_sensors = [40, 80];

position_of_emitter = [50, 50, 50];

colms =  zeros(1,number_of_iteration);
rows = zeros(1,number_of_iteration);
slice = zeros(1,number_of_iteration);
point_matrix = zeros(1,number_of_iteration);

distance = 0;
sum_square = 0;

for c = 1:1:number_of_iteration
    
error_function = zeros(100, 100,100);

gaussian_noise = s*randn(1,1);

d1_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(1))^2 + (position_of_emitter(2) - y_position_of_sensors(1))^2 + (position_of_emitter(3) - z_position_of_sensors(1))^2);
d2_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(2))^2 + (position_of_emitter(2) - y_position_of_sensors(2))^2 + (position_of_emitter(3) - z_position_of_sensors(2))^2);
% d3_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(3))^2 + (position_of_emitter(2) - y_position_of_sensors(3))^2 + (position_of_emitter(3) - z_position_of_sensors(3))^2);
% d4_actual = sqrt((position_of_emitter(1) - x_position_of_sensors(4))^2 + (position_of_emitter(2) - y_position_of_sensors(4))^2 + (position_of_emitter(3) - z_position_of_sensors(4))^2);

actual_power_difference_12 = (5 * 2 * log10(d2_actual/d1_actual));
% actual_power_difference_13 = (5 * 2 * log10(d3_actual/d1_actual));
% actual_power_difference_14 = (5 * 2 * log10(d4_actual/d1_actual));
% actual_power_difference_23 = (5 * 2 * log10(d3_actual/d2_actual));
% actual_power_difference_24 = (5 * 2 * log10(d4_actual/d2_actual));
% actual_power_difference_34 = (5 * 2 * log10(d4_actual/d3_actual));


% 
% min_row = 0;
% min_col = 0;




for i = 1:1:100
    for j = 1:1:100
        for k = 1:1:100
        
            % Her bir sensör ile emitter arasındaki mesafeyi hesaplayın
            d1 = sqrt((i - x_position_of_sensors(1))^2 + (j - y_position_of_sensors(1))^2 + (k - z_position_of_sensors(1))^2);
            d2 = sqrt((i - x_position_of_sensors(2))^2 + (j - y_position_of_sensors(2))^2 + (k - z_position_of_sensors(2))^2);
%             d3 = sqrt((i - x_position_of_sensors(3))^2 + (j - y_position_of_sensors(3))^2 + (k - z_position_of_sensors(3))^2);
%             d4 = sqrt((i - x_position_of_sensors(4))^2 + (j - y_position_of_sensors(4))^2 + (k - z_position_of_sensors(4))^2);
            
            actual_power_difference_with_noise_12 = actual_power_difference_12 + gaussian_noise;
%             actual_power_difference_with_noise_13 = actual_power_difference_13 + gaussian_noise;
%             actual_power_difference_with_noise_14 = actual_power_difference_14 + gaussian_noise;
%             actual_power_difference_with_noise_23 = actual_power_difference_23 + gaussian_noise;
%             actual_power_difference_with_noise_24 = actual_power_difference_24 + gaussian_noise;
%             actual_power_difference_with_noise_34 = actual_power_difference_34 + gaussian_noise;
            
            % Hata fonksiyonunu hesaplayın
%             error_function(i, j, k) = ((actual_power_difference_with_noise_12 - (5 * 2 * log10(d2/d1)))^2 + (actual_power_difference_with_noise_23 - (5 * 2 * log10(d3/d2)))^2 + (actual_power_difference_with_noise_13 - (5 * 2 * log10(d3/d1)))^2 + (actual_power_difference_with_noise_14 - (5 * 2 * log10(d4/d1)))^2 + (actual_power_difference_with_noise_24 - (5 * 2 * log10(d4/d2)))^2 + (actual_power_difference_with_noise_34 - (5 * 2 * log10(d4/d3)))^2);
        error_function(i, j, k) = (actual_power_difference_with_noise_12 - (5 * 2 * log10(d2/d1)))^2;
        end
    end
  
end

counter = counter + 1;

% Hata matrisinin minimum değerini ve pozisyonunu bulun
[min_error, min_idx] = min(error_function(:));
[min_row, min_col , slices] = ind2sub(size(error_function), min_idx);

fprintf('En küçük hata değeri: %f\n', min_error);
fprintf('%d-)Bu değer %d satırında, %d sütununda ve %d sırasında bulunuyor.\n',counter, min_row, min_col, slices);
   

colms(c) =  min_row;
 rows(c) = min_col;
 slice(c) = slices;


  result_x =  result_x + min_row;
  result_y = result_y + min_col;
  result_z = result_z + slices;
  
  
    % Calculate distance between actual and estimated locations
distance = sqrt( (position_of_emitter(1) - min_row)^2 + (position_of_emitter(2) - min_col)^2 + (position_of_emitter(3) - slices)^2);

% Update sum of squared distances
sum_square = sum_square + (distance^2);
  
  
end

   total_result_x = result_x/number_of_iteration;
   total_result_y = result_y/number_of_iteration;
   total_result_z = result_z/number_of_iteration;

   distance = sqrt( (position_of_emitter(1) - total_result_x)^2 + (position_of_emitter(2) - total_result_y)^2 + (position_of_emitter(3) - total_result_z)^2);
   
   fprintf('\nFinal değeri %f satırında, %f sütununda ve %f sırasında bulunuyor.\n\n', total_result_x, total_result_y, total_result_z);
   fprintf('Gerçek konum ve tahmini konum arası mesafe: %f.\n', distance);
   
    mean_squared_error = sum_square/number_of_iteration;

fprintf('Mean Squared Error: %f.\n', mean_squared_error);
   
   % Create a 3D scatter plot
figure (1);
scatter3(x_position_of_sensors(1), y_position_of_sensors(1), z_position_of_sensors(1), 'Marker', 'o', 'MarkerFaceColor', 'r','MarkerEdgeColor','r', 'DisplayName', 'Sensor 1');
hold on;
scatter3(x_position_of_sensors(2), y_position_of_sensors(2), z_position_of_sensors(2), 'Marker', 'o', 'MarkerFaceColor', 'r','MarkerEdgeColor','r', 'DisplayName', 'Sensor 2');

% scatter3(total_result_x, total_result_y, total_result_z, 'Marker', '^', 'MarkerFaceColor', 'b', 'DisplayName', 'Tahmini Konum');

scatter3 (position_of_emitter(1), position_of_emitter(2), position_of_emitter(3), 'Marker', '.', 'MarkerFaceColor', 'm','MarkerEdgeColor','m', 'DisplayName', 'Emitter','SizeData',1000);

axis([0 100 0 100 0 100])

% Customize the plot
% title('3D Scatter Plot of Points');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend();
grid on;
   





% for ii = 1:1:number_of_iteration   
    
   
   scatter3(colms, rows, slice, 20 , 'filled','g','DisplayName', 'Data');
   hold on
    
% end  
figure (2);   
scatter3(x_position_of_sensors(1), y_position_of_sensors(1), z_position_of_sensors(1), 'Marker', 'o', 'MarkerFaceColor', 'r','MarkerEdgeColor','r', 'DisplayName', 'Sensor 1');
hold on;
scatter3(x_position_of_sensors(2), y_position_of_sensors(2), z_position_of_sensors(2), 'Marker', 'o', 'MarkerFaceColor', 'r','MarkerEdgeColor','r', 'DisplayName', 'Sensor 2');

scatter3(total_result_x, total_result_y, total_result_z, 'Marker', '^', 'MarkerFaceColor', 'b', 'DisplayName', 'Tahmini Konum');

scatter3 (position_of_emitter(1), position_of_emitter(2), position_of_emitter(3), 'Marker', '.', 'MarkerFaceColor', 'm','MarkerEdgeColor','m', 'DisplayName', 'Emitter','SizeData',1000);

axis([0 100 0 100 0 100])

% Customize the plot
% title('3D Scatter Plot of Points');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend();
grid on;
   


% % Emitter ve sensör pozisyonlarını çizin
% figure;
% plot(x_position_of_sensors, y_position_of_sensors, 'o', 'MarkerSize', 10)
% hold on;
% plot(position_of_emitter(1), position_of_emitter(2), 'x', 'MarkerSize', 10)
% plot(min_row, min_col, 'diamond', 'MarkerFaceColor', 'red', 'MarkerSize', 10)
% xlim([0, 100]);
% ylim([0, 100]);
% grid on;
% legend('Sensör', 'Emitter', 'Tahmini Konum');


