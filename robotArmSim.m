clear
clc
% Here are some ready test cases
% Uncomment the following lines indicating each example robot arm's variables

%Example 1
% %----------------------------
% L1 = 6;
% L2 = 4;
% L3 = 3;
% th1min = -90;
% th1max = 150;
% th2min = -90;
% th2max = 150;
% th3min = -90;
% th3max = 150;
%----------------------------

%if you use DKPM in example 1 and enter the following in the dialogue box
%theta1= 10 , theta2= 20 , theta3= 100
%the coordinates will be (7.44,5.34)
%if you choose Line trajectory in example 1 and enter the following in the
%dialogue box:
%X(intial) = 13, Y(intial) = 0, phi(intial) = 0
%X(final) = 0, Y(final) = 6, phi(final) = 120


%Example 2
%----------------------------
% L1 = 7;
% L2 = 5;
% L3 = 3;
% th1min = -20;
% th1max = 100;
% th2min = 0;
% th2max = 90;
% th3min = -180;
% th3max = 180;
%----------------------------

%if you use DKPM in example 2 and enter the following in the dialogue box
%theta1= 20 , theta2= 70 , theta3= 120
%the coordinates will be (3.98,5.89)
%if you use IKPM in example 2 and enter the following in the dialogue box
%x= 10 , y= 3 , phi=120
%theta1= -11.85 , theta2= 33.44 , theta3= 98.41
%if you use Line trajectory in example 2 and enter the following in the
%dialogue box
%x(intial) = 10, y(inital) = 3, phi = 120
%x(final) = 0, y(final) = 8, phi = 130

%Example 3
%----------------------------
% L1 = 8;
% L2 = 4;
% L3 = 5;
% th1min = 50;
% th1max = 210;
% th2min = -45;
% th2max = 90;
% th3min = 0;
% th3max = 180;
%----------------------------

%if you use DKPM in example 3 and enter the following in the dialogue box
%theta1= 125 , theta2= 40 , theta3= 70
%the coordinates will be (-11.32,3.49)

%Example 4
%----------------------------
% L1 = 5;
% L2 = 4;
% L3 = 2;
% th1min = -30;
% th1max = 60;
% th2min =0;
% th2max = 90;
% th3min = -45;
% th3max = 180;
%----------------------------

%if you use DKPM in example 4 and enter the following in the dialogue box
%theta1= 60 , theta2= 45 , theta3= 90
%the coordinates will be (-0.47,7.68)
%if you use IKPM in example 2 and enter the following in the dialogue box
%x= 8 , y= 5 , phi=45
%theta1= -0.99 , theta2= 67.62 , theta3= -21.63


%Or you can enter your own parameters by uncommenting the following lines

%Getting input from the user and validating 

%----------------------------
L1=input('Please enter the length of the 1st link: ');
while (L1 < 0)
    L1=input('Error! Please enter a value greater than zero: ');
end

L2=input('Please enter the length of the 2nd link: ');
while (L2 < 0)
    L2=input('Error! Please enter a value greater than zero: ');
end

L3=input('Please enter the length of the 3rd link: ');
while (L3 < 0)
    L3=input('Error! Please enter a value greater than zero: ');
end

th1min=input('Please enter minimum value of theta 1: ');

th1max=input('Please enter maximum value of theta 1: ');
while (th1max < th1min)
  th1max = input('Error! Please enter a value greater than th1 min: ');
end
th2min=input('Please enter minimum value of theta 2: ');

th2max=input('Please enter maximum value of theta 2: ');
while (th2max < th2min)
  th2max = input('Error! Please enter a value greater than th2 min: ');
end

th3min=input('Please enter minimum value of theta 3: ');

th3max=input('Please enter maximum value of theta 3: ');
while (th3max < th3min)
  th3max = input('Error! Please enter a value greater than th3 min: ');
end
%----------------------------

%Plotting the working area
maxLimit = L1 + L2 + L3;
figure ('position',[1 1 920 925]);
axis([-maxLimit maxLimit -maxLimit maxLimit]);
grid on;
hold on;

t1 = th1min : (th1max-th1min)/2000 : th1max;
t2 = th2min : (th2max-th2min)/2000 : th2max;
t3 = th3min : (th3max-th3min)/2000 : th3max;

[T1,T2] = meshgrid(t1, t2);
[T1,T3] = meshgrid(t1, t3);

X = L1 * cosd(T1) + L2*cosd(T1 + T2) + L3*cosd(T1 + T2 + T3);
Y = L1 * sind(T1) + L2*sind(T1 + T2) + L3*sind(T1 + T2 + T3);

workingArea = plot(X, Y, 'y');

%Working area calculation
area = abs(L1*L2*(th3max*(pi/180)-th3min*(pi/180))*(cosd(th2min)-cosd(th2max))*(th1max*(pi/180) - th1min*(pi/180)));
txt = 'Working area';
text((maxLimit-4.5), (-maxLimit + 1.2), txt, 'fontsize', 14);
areaString = num2str(area);
numbertext = [areaString ' inch^2'];
text((maxLimit-4.5), (-maxLimit + 0.5), numbertext , 'fontsize', 13);
 
%Adjusting the initial positions of the links
positionX1 = L1 * cosd(th1min);
positionY1 = L1 * sind(th1min);
positionX2 = L1 * cosd(th1min) + L2*cosd(th1min + th2min);
positionY2 = L1 * sind(th1min) + L2*sind(th1min + th2min);
positionX3 = L1 * cosd(th1min) + L2*cosd(th1min + th2min) + L3*cosd(th1min + th2min + th3min);
positionY3 = L1 * sind(th1min) + L2*sind(th1min + th2min) + L3*sind(th1min + th2min + th3min);

%Drawing the inital position
arm1 = plot ([0 positionX1], [0 positionY1],'b-', 'linewidth', 3);
arm2 = plot ([positionX1 positionX2], [positionY1 positionY2], 'b-', 'linewidth', 3);
arm3 = plot ([positionX2 positionX3], [positionY2 positionY3], 'b-', 'linewidth', 3);
joint1 = plot (0,0, 'ro','linewidth' ,3);
joint2 = plot (positionX1,positionY1, 'ro','linewidth' ,3);
joint3 = plot (positionX2,positionY2, 'ro','linewidth' ,3);
hand = plot (positionX3,positionY3, 'ro','linewidth' ,3);
set(gca, 'xtick',-maxLimit:1:maxLimit); set(gca, 'ytick',-maxLimit:1:maxLimit);

while (1)
    
   choice = inputdlg({'Enter "0" for DKPM,  "1" for IKPM,   "2" for Line trajectory(program ends),    or any other number if you want to end the program'}); 
  
   drawnow;
   
   if (choice{1} ~= '0' && choice{1} ~= '1' && choice{1} ~= '2')
       break;
   end
   
   if (choice{1} == '0')
       
    %DKPM Model

        %Taking input from the user
        Thetas = inputdlg({'Theta 1:','Theta 2:','Theta 3:'});
        theta1Input = str2double(Thetas{1});
        theta2Input = str2double(Thetas{2});
        theta3Input = str2double(Thetas{3});
        
        if (theta1Input > th1max || theta1Input < th1min)
            disp('Error! Angles are out of range');
            continue;
        end
        
        if (theta2Input > th2max || theta2Input < th2min)
            disp('Error! Angles are out of range');
            continue;
        end
        
        if (theta3Input > th3max || theta3Input < th3min)
            disp('Error! Angles are out of range');
            continue;
        end
        
        %Calculating new position
        positionX1 = L1 * cosd(theta1Input);
        positionY1 = L1 * sind(theta1Input);
        positionX2 = L1 * cosd(theta1Input) + L2*cosd(theta1Input + theta2Input);
        positionY2 = L1 * sind(theta1Input) + L2*sind(theta1Input + theta2Input);
        positionX3 = L1 * cosd(theta1Input) + L2*cosd(theta1Input + theta2Input) + L3*cosd(theta1Input + theta2Input + theta3Input);
        positionY3 = L1 * sind(theta1Input) + L2*sind(theta1Input + theta2Input) + L3*sind(theta1Input + theta2Input + theta3Input);


        %Plotting new position
        set (arm1,'xdata',[0 positionX1],'ydata',[0 positionY1]);
        set (arm2,'xdata',[positionX1 positionX2],'ydata',[positionY1 positionY2]);
        set (arm3,'xdata',[positionX2,positionX3],'ydata',[positionY2,positionY3]);
        set (joint2, 'xdata', positionX1,'ydata',positionY1);
        set (joint3, 'xdata', positionX2,'ydata',positionY2);
        set (hand, 'xdata', positionX3,'ydata',positionY3);

        fprintf('The coordinate is: (%.2f,%.2f)\n',positionX3,positionY3);
   end
   
   if (choice{1} == '1')
       
    %IKPM Model
        coordinates = inputdlg({'X-Coordinate:','Y-Coordiante:','Sum of all angles'});

        x_coordinate = str2double(coordinates{1});
        y_coordinate = str2double(coordinates{2});
        phi = str2double(coordinates{3});
        
        wx = x_coordinate - L3*cosd(phi);
        wy = y_coordinate - L3*sind(phi);
        
        costh2 = (wx^2 + wy^2 - L2^2 - L1^2)/(2*L1*L2);
        
%         if (costh2 > 1 || costh2 < -1)
%             disp('There is an error in the input!')
%             continue;
%         end

        theta2 = acosd((wx^2 + wy^2 - L2^2 - L1^2)/(2*L1*L2));

        cosTheta1 = ((L1*wx + L2*wy*sind(theta2) + L2*wx*cosd(theta2))/(L1^2 + 2*L1*L2*cosd(theta2) + L2^2));
        sinTheta1 = ((L1*wy + L2*wy*cosd(theta2) - L2*wx*sind(theta2) )/(L1^2 + 2*L1*L2*cosd(theta2) + L2^2));

        theta1 = atand(abs(sinTheta1)/abs(cosTheta1));
        if (x_coordinate<0 && y_coordinate>0)
            theta1 = 180 - theta1;
        elseif (x_coordinate<0 && y_coordinate<0)
            theta1 = -180 + theta1;
        elseif (x_coordinate>0 && y_coordinate>0)
            theta1 = -theta1;
        end

        theta3 = phi - theta1 - theta2;
        
%         if (theta1 > th1max || theta1 < th1min)
%             disp('There is an error in the input!');
%             continue;
%         end
%         
%         if (theta2 > th2max || theta2 < th2min)
%             disp('There is an error in the input!');
%             continue;
%         end
%         
%         if (theta3 > th3max || theta3 < th3min)
%             disp('There is an error in the input!');
%             continue;
%         end
        
        %Calculating new position
        positionX1 = L1 * cosd(theta1);
        positionY1 = L1 * sind(theta1);
        positionX2 = L1 * cosd(theta1) + L2*cosd(theta1 + theta2);
        positionY2 = L1 * sind(theta1) + L2*sind(theta1 + theta2);
        positionX3 = L1 * cosd(theta1) + L2*cosd(theta1 + theta2) + L3*cosd(theta1 + theta2 + theta3);
        positionY3 = L1 * sind(theta1) + L2*sind(theta1 + theta2) + L3*sind(theta1 + theta2 + theta3);

        %Plotting new position
        set (arm1,'xdata',[0 positionX1],'ydata',[0 positionY1]);
        set (arm2,'xdata',[positionX1 positionX2],'ydata',[positionY1 positionY2]);
        set (arm3,'xdata',[positionX2,positionX3],'ydata',[positionY2,positionY3]);
        set (joint2, 'xdata', positionX1,'ydata',positionY1);
        set (joint3, 'xdata', positionX2,'ydata',positionY2);
        set (hand, 'xdata', positionX3,'ydata',positionY3);

        fprintf('Angles are: %.2f, %.2f, %.2f\n',theta1,theta2,theta3);
   end
    
   if (choice{1} == '2')
       
       intialPoint = inputdlg({'X-Coordinate (initial):','Y-Coordiante (initial):','Sum of all angles (initial)'});
       finalPoint = inputdlg({'X-Coordinate (final):','Y-Coordiante (final):','Sum of all angles (final)'});
        
       x_initial = str2double(intialPoint{1});
       y_initial = str2double(intialPoint{2});
       phi_initial = str2double(intialPoint{3});
        
       x_final = str2double(finalPoint{1});
       y_final = str2double(finalPoint{2});
       phi_final = str2double(finalPoint{3});
        
       xi = [x_initial y_initial phi_initial];
       xf = [x_final y_final phi_final];
        
       a5 = 10*(xf-xi);
       a4 = -15*(xf-xi);
       a3 = 6*(xf-xi);
       a2 = 0;
       a1 = 0;
       ao = xi;
        
       for tBar = 0:0.05:1
            
           X = ((tBar)^5)*a5 + ((tBar)^4)*a4 + ((tBar)^3)*a3 + ((tBar)^2)*a2 + ((tBar)^1)*a1 + ao;
            
           wx = X(1) - L3*cosd(X(3));
           wy = X(2) - L3*sind(X(3));
        
           theta2 = acosd((wx^2 + wy^2 - L2^2 - L1^2)/(2*L1*L2));
           
           costh2 = (wx^2 + wy^2 - L2^2 - L1^2)/(2*L1*L2);
        
           if (costh2 > 1 || costh2 < -1)
            disp('There is an error in the input!')
            break;
           end

           cosTheta1 = ((L1*wx + L2*wy*sind(theta2) + L2*wx*cosd(theta2))/(L1^2 + 2*L1*L2*cosd(theta2) + L2^2));
           sinTheta1 = ((L1*wy + L2*wy*cosd(theta2) - L2*wx*sind(theta2))/(L1^2 + 2*L1*L2*cosd(theta2) + L2^2));

           theta1 = atand(abs(sinTheta1)/abs(cosTheta1));
           if (X(1)<0 && X(2)>0)
               theta1 = 180 - theta1;
           elseif (X(1)<0 && X(2)<0)
               theta1 = 180 + theta1;
           elseif (X(1)>0 && X(2)>0)
               theta1 = -theta1;
           end

           theta3 = X(3) - theta1 - theta2;

           %Calculating new position
           positionX1 = L1 * cosd(theta1);
           positionY1 = L1 * sind(theta1);
           positionX2 = L1 * cosd(theta1) + L2*cosd(theta1 + theta2);
           positionY2 = L1 * sind(theta1) + L2*sind(theta1 + theta2);
           positionX3 = L1 * cosd(theta1) + L2*cosd(theta1 + theta2) + L3*cosd(theta1 + theta2 + theta3);
           positionY3 = L1 * sind(theta1) + L2*sind(theta1 + theta2) + L3*sind(theta1 + theta2 + theta3);

           %Plotting new position
           set (arm1,'xdata',[0 positionX1],'ydata',[0 positionY1]);
           set (arm2,'xdata',[positionX1 positionX2],'ydata',[positionY1 positionY2]);
           set (arm3,'xdata',[positionX2,positionX3],'ydata',[positionY2,positionY3]);
           set (joint2,'xdata', positionX1,'ydata',positionY1);
           set (joint3,'xdata', positionX2,'ydata',positionY2);
           set (hand,'xdata', positionX3,'ydata',positionY3);
           
           if tBar ~= 0
               pointsX = [pointsX positionX3];
               pointsY = [pointsY positionY3];
           else
               pointsX = positionX3;
               pointsY = positionY3;
           end
          
           drawnow;
           pause(0.1);
           
       end
       
       for index = 2:length(pointsX)
           line = plot([pointsX(index-1) pointsX(index)], [pointsY(index-1), pointsY(index)], 'r', 'linewidth', 2);
       end
       break;
       
   end
end

disp('Program has ended');