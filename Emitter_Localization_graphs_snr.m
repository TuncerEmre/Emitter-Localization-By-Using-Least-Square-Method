close all
clear
clc

% Prompt the user to choose whether to use random inputs or not

prompt_yes_no = [ "Do you want to use random inputs ? yes/no "];
dlgtitle_yes_no = 'Input';
dims_yes_no = [1 38];
definput_yes_no = {'no'};
UserInput_yes_no = inputdlg(prompt_yes_no, dlgtitle_yes_no, dims_yes_no, definput_yes_no);

% Check if the user canceled the input dialog.
if isempty(UserInput_yes_no)
    return;
end

% Get the user's choice (yes/no)
yes_no = UserInput_yes_no{1};

% If the user chose 'yes', ask for the number of sensors and signal-to-noise ratio

if strcmp(yes_no, 'yes')
prompt_yes = [ "Enter the number of sensors: ","Enter the signal to noise ratio:"];
dlgtitle_yes = 'Input';
dims_yes = [1 38];
definput_yes = {'2', '3'};
UserInput_yes = inputdlg(prompt_yes, dlgtitle_yes, dims_yes, definput_yes);
% Check if the user canceled the input dialog.
if isempty(UserInput_yes)
    return;
end

% Convert user input from cell array to variables for calculations.
N = str2double(UserInput_yes{1});
x_position_of_sensors = zeros(1,N);
y_position_of_sensors = zeros(1,N);



position_of_emitter = zeros(1,2);
for i = 1:1:N
x_position_of_sensors(i) = randi([1, 100]);
y_position_of_sensors(i) = randi([1, 100]); 

end


for i = 1:1:2
   position_of_emitter(i) = randi([1, 100]); 
end

 % Calculate the noise parameter based on signal-to-noise ratio
% SNR goes up, the noise is goes down  

snr = str2double(UserInput_yes{2});
monte_carlo_trial = 100;
signal_power = 1;
alpha = signal_power/(10^(snr/10));
end 






% If the user chose 'no', ask for specific input values
if strcmp(yes_no, 'no')
prompt = [ "Enter the number of sensors: ","Enter the x position of sensors by putting comma between them:"," Enter the y position of sensors by putting comma between them: " , " Enter position of emitter", "Enter the signal to noise ratio:","Number of monte_carlo_trial"];
dlgtitle = 'Input';
dims = [1 38];
definput = {'4', '30,40,75,80', '80 ,30,65,20', '50 , 50', '3','100'};
UserInput = inputdlg(prompt, dlgtitle, dims, definput);
% Check if the user canceled the input dialog.
if isempty(UserInput)
    return;
end

% Convert user input from cell array to variables for calculations.
N = str2double(UserInput{1});
x_position_of_sensors = zeros(1,N);
y_position_of_sensors = zeros(1,N);



position_of_emitter = zeros(1,2);
x_position_of_sensors = str2double(strsplit(UserInput{2}, ','));
y_position_of_sensors = str2double(strsplit(UserInput{3}, ','));

position_of_emitter = str2double(strsplit(UserInput{4}, ','));

% SNR goes up, the noise is goes down  

snr  = str2double(UserInput{5});
signal_power = 1;
alpha = signal_power/(10^(snr/10));

monte_carlo_trial = str2double(UserInput{6});
end 

number_of_actual_power = factorial(N)/(2 * factorial(N-2));

result_x =  0;
result_y = 0;

sum_square = 0;

colms = zeros(1,monte_carlo_trial);                                                                    %---------------------------------------------- histogram için
rows = zeros(1,monte_carlo_trial);

distance = 0; % zeros(1,number_of_iterations);


for c = 1:1:monte_carlo_trial

error_function = zeros(100, 100);
d_actual = zeros(1,N);
d = zeros(1,N);
actual_power_difference_with_noise = zeros(1,number_of_actual_power);
actual_power_difference = zeros(1,number_of_actual_power);
gaussian_noise = alpha*randn(1,1);
counter_actual_power_difference = 1;
counter_error_calculation = 1;
error_calculation = 0;

% Calculate actual distances between emitter and sensors
for i = 1:1:N
    
   d_actual(i) = sqrt((position_of_emitter(1) - x_position_of_sensors(i))^2 + (position_of_emitter(2) - y_position_of_sensors(i))^2); 
   
   
end

% Calculate actual power differences with and without noise
for i = 1:1:N-1
    for j=  i + 1:1:N
    
    
    actual_power_difference(counter_actual_power_difference) = (5 * 2 * log10(d_actual(j)/d_actual(i)));
    actual_power_difference_with_noise(counter_actual_power_difference) = actual_power_difference(counter_actual_power_difference) + gaussian_noise;
    counter_actual_power_difference = counter_actual_power_difference + 1;
%     disp(['iii = ',num2str(i)])
%            disp(['jjj= ', num2str(j)])
%     
    
    
    end
end





  % Calculate error function for all positions
for i = 1:1:100
    for j = 1:1:100
        % Calculate distances between sensors and current position
        for ii = 1:1:N
          d(ii) = sqrt((i - x_position_of_sensors(ii))^2 + (j - y_position_of_sensors(ii))^2);
        end
        
       for iii = 1:1:N-1
        for jjj =  iii + 1:1:N
            
            error_calculation = error_calculation + (actual_power_difference_with_noise(counter_error_calculation) - (5 * 2 * log10(d(jjj)/d(iii))))^2;
            counter_error_calculation = counter_error_calculation + 1;
        
        end
       end
       
         
               %stor the error values in the matrix
            error_function(i, j) = error_calculation;
            counter_error_calculation = 1;
            error_calculation = 0;
    end
    
end


% Find the position with the minimum error
[min_error, min_idx] = min(error_function(:));
[min_row, min_col] = ind2sub(size(error_function), min_idx);

% 
% fprintf('En küçük hata değeri: %f\n', min_error);
% fprintf('Bu değer %d satırında ve %d sütununda bulunuyor.\n', min_row, min_col);

% Store positions in arrays for further analysis
colms(c) =  min_row;                                                                       %---------------------------------------------- histogram için
rows(c) = min_col; 

% Update total results
result_x =  result_x + min_row;
result_y = result_y + min_col;

% Calculate distance between actual and estimated locations
distance = sqrt( (position_of_emitter(1) - min_row)^2 + (position_of_emitter(2) - min_col)^2);

% fprintf('Distance between actual location and estimated location: %f.\n', distance);

% Update sum of squared distances
sum_square = sum_square + (distance^2);


end

% Calculate average estimated positions and mean squared error
total_result_x = result_x/monte_carlo_trial;               % ortalama değerlerden oluşan noktayı hesaplar
total_result_y = result_y/monte_carlo_trial;

mean_squared_error = sum_square/monte_carlo_trial;

fprintf('Mean Squared Error: %f.\n', mean_squared_error);

% Plot the sensor and emitter locations
figure(1);
% for i = 1:1:N
plot(x_position_of_sensors, y_position_of_sensors, 'o', 'MarkerSize', 10,'DisplayName', 'Sensor','MarkerFaceColor', 'g')
hold on;
plot(position_of_emitter(1), position_of_emitter(2), 's', 'MarkerSize', 15,'DisplayName', 'Emitter','MarkerFaceColor', 'c')
hold on;
% plot(  total_result_x,  total_result_y, 'diamond', 'MarkerFaceColor', 'red', 'MarkerSize', 10,'DisplayName', 'Tahmini Konum')
xlim([0, 100]);
ylim([0, 100]);
grid on;
legend(); %legend fonksiyonu, bir grafikte çizilen elemanların açıklamalarını eklemek için kullanılır. 

% end


% Plot the estimated location
% for kk = 1:1:number_of_iterations                                                                   %---------------------------------------------- histogram için
figure(1);
plot(colms,rows, 'o','MarkerSize', 5,'MarkerFaceColor', 'b','DisplayName', 'Estimated Location Points')

 hold on
 
 xlim([0, 100]);
 ylim([0, 100]);



% Plot a 2D histogram of estimated locations
figure (2);                                                                    %---------------------------------------------- histogram için
X = [colms',rows'];
hist3(X,'Ctrs',{0:3:100 0:3:100})


xlabel('X-axis');
ylabel('Y-axis');
xlim([0, 100]);
ylim([0, 100]);



% Plot the sensor and emitter locations along with the estimated location
figure(3);
plot(x_position_of_sensors, y_position_of_sensors, 'o', 'MarkerSize', 10,'DisplayName', 'Sensor','MarkerFaceColor', 'g')
hold on;
plot(position_of_emitter(1), position_of_emitter(2), 's', 'MarkerSize', 15,'DisplayName', 'Emitter','MarkerFaceColor', 'c')
hold on;
plot(  total_result_x,  total_result_y, 'diamond', 'MarkerFaceColor', 'red', 'MarkerSize', 10,'DisplayName', 'Estimated Location')
xlim([0, 100]);
ylim([0, 100]);
grid on;
legend(); %legend fonksiyonu, bir grafikte çizilen elemanların açıklamalarını eklemek için kullanılır.