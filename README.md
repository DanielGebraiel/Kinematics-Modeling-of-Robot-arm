
# Kinematics Modeling of robotic arm

-This matlab program makes either a two joint or three joint robotic arm model and has three choices for the user to simulate:

- DKPM (The user enters the angle of each joint and the robotic arm moves accordingly and printes the coordinates of X and Y)

- IKPM (The user enters the X,Y coordinates and sum of angles of joints and the robotic arm moves accordingly and prints the angle of each joint)

- Line Trajectory (The user enters the initial X,Y coordinates and the sum of angles of joints. They then enter the final X,Y coordinates and the final sum of angles of joints and the program moves the arm accordingly drawing a line from the initial to the final point)

- In addition the program calculates the working area of the robot and prints it in the bottom right corner

- After each simulation the program prints the results in the console


## Example:

-This is an example of a robotic arm of joints 6,4,3 and the maximum angles of all of the joints are from [-90 to 150]

- The robot arm

![App Screenshot](https://github.com/DanielGebraiel/Kinematics-Modeling-of-Robot-arm/blob/main/screenshots/neutral.png)

- The input screen

![App Screenshot](https://github.com/DanielGebraiel/Kinematics-Modeling-of-Robot-arm/blob/main/screenshots/input.png)

- After applying DKPM with inputs [th1= 10, th2= 20, th3= 100]

![App Screenshot](https://github.com/DanielGebraiel/Kinematics-Modeling-of-Robot-arm/blob/main/screenshots/dkpm.png)

-The output is (X= 7.44, Y= 5.34)

- After applying IKPM with inputs [X= 5, Y= 4, Sum= 120]

![App Screenshot](https://github.com/DanielGebraiel/Kinematics-Modeling-of-Robot-arm/blob/main/screenshots/ikpm.png)

-The output is (th1= -24.24, th2= 99.33, th3= 44.91)

- Line Trajectory

![App Screenshot](https://github.com/DanielGebraiel/Kinematics-Modeling-of-Robot-arm/blob/main/screenshots/lineTrajectory.png)
## Lessons Learned

- How to Utilize the capabilities of matlab such as matrices and graphs
- Multiple new functions in matlab
- Debugging in matlab

