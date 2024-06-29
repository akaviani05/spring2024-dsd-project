module tb_parking_management;

reg clk;
reg reset;
reg [7:0] current_hour;
reg car_entered;
reg is_uni_car_entered;
reg car_exited;
reg is_uni_car_exited;
wire [9:0] uni_parked_car;
wire [9:0] parked_car;
wire [9:0] uni_vacated_space;
wire [9:0] vacated_space;
wire uni_is_vacated_space;
wire is_vacated_space;

parking_management uut (
    .clk(clk),
    .reset(reset),
    .current_hour(current_hour),
    .car_entered(car_entered),
    .is_uni_car_entered(is_uni_car_entered),
    .car_exited(car_exited),
    .is_uni_car_exited(is_uni_car_exited),
    .uni_parked_car(uni_parked_car),
    .parked_car(parked_car),
    .uni_vacated_space(uni_vacated_space),
    .vacated_space(vacated_space),
    .uni_is_vacated_space(uni_is_vacated_space),
    .is_vacated_space(is_vacated_space)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    current_hour = 0;
    car_entered = 0;
    is_uni_car_entered = 0;
    car_exited = 0;
    is_uni_car_exited = 0;

    #10;
    reset = 0;

    #10; current_hour = 8; car_entered = 1; is_uni_car_entered = 1;
    #10; car_entered = 0;
    #10; current_hour = 9; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;
    #10; current_hour = 10; car_exited = 1; is_uni_car_exited = 1;
    #10; car_exited = 0;
    #10; current_hour = 11; car_exited = 1; is_uni_car_exited = 0;
    #10; car_exited = 0;
    #10; current_hour = 13; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;
    #10; current_hour = 14; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;
    #10; current_hour = 15; car_entered = 1; is_uni_car_entered = 1;
    #10; car_entered = 0;
    #10; current_hour = 16; car_entered = 1; is_uni_car_entered = 0;
    #10; car_entered = 0;

    #100;
    $finish;
end

initial begin
    $monitor("Time: %0t | current_hour: %0d | uni_parked_car: %0d | parked_car: %0d | uni_vacated_space: %0d | vacated_space: %0d | uni_is_vacated_space: %b | is_vacated_space: %b", 
             $time, current_hour, uni_parked_car, parked_car, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space);
end

endmodule
